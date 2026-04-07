package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.bumptech.glide.Glide;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MusicBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.basic.PictureSelector;
import com.luck.picture.lib.config.SelectMimeType;
import com.luck.picture.lib.engine.CompressFileEngine;
import com.luck.picture.lib.entity.LocalMedia;
import com.luck.picture.lib.interfaces.OnResultCallbackListener;
import com.luck.picture.lib.utils.ToastUtils;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.media.UMWeb;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.io.File;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnCompressListener;
import top.zibin.luban.OnNewCompressListener;

public class QingjianEditActivity extends BaseWebViewActivity {
    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    //    @BindView(R.id.ll_del)
//    LinearLayout llDel;
//    @BindView(R.id.ll_setting)
//    LinearLayout llSetting;
//    @BindView(R.id.ll_toshow)
//    LinearLayout llToshow;
//    @BindView(R.id.ll_send)
//    LinearLayout llSend;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;

    private static final int REQUEST_SET_MUSIC = 102;       //设置音乐
    private static final int REQUEST_SET_INFO = 103;        //修改信息
    private static final int REQUEST_CHOOSE_SHARE_IMG = 101;
    private static final int REQUEST_BIANJI = 104;//编辑页面

    private String[] menuTitles = new String[]{"设置音乐", "设置信息"};

    private int intentType;//0:编辑跳转过来  1:列表跳转过来

    ViewHolder vh;
    View pop_view;
    private String mUrl; // 当前页面url
    private String mShowUrl; // 预览url
    private ShareBean mShareBean;

    private String imgurl;
    private boolean isFile;
    private boolean isCanClickShare = true;

    public static void startActivityForResult(Activity context, ShareBean shareBean, int intentType, int requestCode) {
        Intent intent = new Intent(context, QingjianEditActivity.class);
        intent.putExtra("data", shareBean);
        intent.putExtra("intentType", intentType);
        context.startActivityForResult(intent, requestCode);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
        StatusBarUtil.setStatusBarColor(QingjianEditActivity.this, R.color.white);
        StatusBarUtil.setNavigationBarColor(QingjianEditActivity.this, R.color.white);

        EventBusUtil.register(this);
        mShareBean = (ShareBean) getIntent().getSerializableExtra("data");
        intentType = getIntent().getIntExtra("intentType", -1);
        if (mShareBean == null) {
            NToast.show("参数异常");
            finish();
            return;
        }
        mUrl = mShareBean.getUrl();
        initView();
        if (mUrl != null) {
            mShowUrl = mUrl.replaceAll("indexedit", "index");
            loadUrl(mUrl);
        }
    }

    @Override
    public int getContentView() {
        return R.layout.activity_qingjian_edit;
    }

    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(QingjianEditActivity.this));
        llBar.setLayoutParams(params);
//        llSend.setOnClickListener(this);
//        llToshow.setOnClickListener(this);
//        llSetting.setOnClickListener(this);
//        llDel.setOnClickListener(this);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        switch (requestCode) {
            case REQUEST_SET_MUSIC: // 选择音乐返回
                if (resultCode == RESULT_OK && data != null) {
                    MusicBean.DataBean musicBean = (MusicBean.DataBean) data.getSerializableExtra("data");
                    setMusic(musicBean);
                }
                break;
            case REQUEST_SET_INFO:// 修改信息返回
                if (resultCode == RESULT_OK && data != null) {
                    mShareBean = (ShareBean) data.getSerializableExtra("data");
                    mWebView.reload();
                }
                break;
        }
    }

    private void setMusic(MusicBean.DataBean music) {
        MsgLoadDialog.showDialog(this, "设置中...");
        ApiManager.setTemplateMusic(mShareBean.getInvitationsId(), music.getId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("设置成功");
                mWebView.reload();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }


    // 分享
    private void sharePop() {
        final PopupWindow pop = new PopupWindow(this);
        if (vh == null) {
            pop_view = LayoutInflater.from(this).inflate(R.layout.pop_share_qj_layout, null);
            vh = new ViewHolder(pop_view);
            pop_view.setTag(vh);
        } else {
            vh = (ViewHolder) pop_view.getTag();
        }
        //vh.tvTitle.setText(String.format("%s&%s的婚礼请柬", mShareBean.getBoyName(), mShareBean.getGirlName()));
        // SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日");
        vh.edContent.setText("我们将在" + mShareBean.getTime() + "举行宴会，诚挚地邀请您的到来。");
        imgurl = mShareBean.getCover();
        GlideLoad.GlideLoadImg2(mShareBean.getCover(), vh.ivHeadImg);
        vh.llClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pop.dismiss();
            }
        });

        vh.rlSlectPhoto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                ImageSelect.ActivityImageSelectSingle(QingjianEditActivity.this, QingjianEditActivity.this, new ArrayList<String>(), REQUEST_CHOOSE_SHARE_IMG);
                showPop(REQUEST_CHOOSE_SHARE_IMG);
            }
        });
        vh.llShareCir.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (isCanClickShare) {
                    if (!TextUtils.isEmpty(vh.tvTitle.getText().toString())) {
                        isCanClickShare = false;
                        // shar(mShareBean.getShareurl(), vh.tvTitle.getText().toString(), isFile, imgurl, vh.edContent.getText().toString(), 0);
                        saveShareInfo(imgurl, vh.edContent.getText().toString(), vh.tvTitle.getText().toString(), 0);
                    } else {
                        NToast.show("请输入标题后再分享哦！~");
                    }
                }
            }
        });
        vh.llShareFri.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (isCanClickShare) {
                    if (!TextUtils.isEmpty(vh.tvTitle.getText().toString())) {
                        isCanClickShare = false;
                        // shar(mShareBean.getShareurl(), vh.tvTitle.getText().toString(), isFile, imgurl, vh.edContent.getText().toString(), 1);
                        saveShareInfo(imgurl, vh.edContent.getText().toString(), vh.tvTitle.getText().toString(), 1);
                    } else {
                        NToast.show("请输入标题后再分享哦！~");
                    }
                }
            }
        });
        vh.llShareQq.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (isCanClickShare) {
                    if (!TextUtils.isEmpty(vh.tvTitle.getText().toString())) {
                        isCanClickShare = false;
                        //  shar(mShareBean.getShareurl(), vh.tvTitle.getText().toString(), isFile, imgurl, vh.edContent.getText().toString(), 2);
                        saveShareInfo(imgurl, vh.edContent.getText().toString(), vh.tvTitle.getText().toString(), 2);
                    } else {
                        NToast.show("请输入标题后再分享哦！~");
                    }
                }
            }
        });
        vh.llShareQzone.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (isCanClickShare) {
                    if (!TextUtils.isEmpty(vh.tvTitle.getText().toString())) {
                        isCanClickShare = false;
                        //   shar(mShareBean.getShareurl(), vh.tvTitle.getText().toString(), isFile, imgurl, vh.edContent.getText().toString(), 3);
                        saveShareInfo(imgurl, vh.edContent.getText().toString(), vh.tvTitle.getText().toString(), 3);
                    } else {
                        NToast.show("请输入标题后再分享哦！~");
                    }
                }
            }
        });
        vh.llShareSina.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (isCanClickShare) {
                    if (!TextUtils.isEmpty(vh.tvTitle.getText().toString())) {
                        isCanClickShare = false;
                        //   shar(mShareBean.getShareurl(), vh.tvTitle.getText().toString(), isFile, imgurl, vh.edContent.getText().toString(), 4);
                        saveShareInfo(imgurl, vh.edContent.getText().toString(), vh.tvTitle.getText().toString(), 4);
                    } else {
                        NToast.show("请输入标题后再分享哦！~");
                    }

                }
            }
        });

        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = this.getWindowManager().getDefaultDisplay().getWidth();
//        int h = (this.getWindowManager().getDefaultDisplay().getHeight() / 2);
        pop.setWidth(w);
//        pop.setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(pop_view);
        pop.update();
        pop.showAtLocation(llParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });
    }

    public void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        getWindow().setAttributes(lp);
    }

    // 跳转到预览请柬
    private void previewInvitation() {
        if (mShowUrl != null) {
            QingjianYulanActivity.startActivity(this, mShowUrl);
        } else {
            MsgLoadDialog.showDialog(this, "请稍候...");
            ApiManager.getInvitationUrl(mShareBean.getInvitationsId(), false, new OnRequestFinish<BaseBean<String>>() {
                @Override
                public void onFinished() {
                    MsgLoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean<String> data) {
                    mShowUrl = data.getData();
                    QingjianYulanActivity.startActivity(QingjianEditActivity.this, mShowUrl);
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show(ex.getMessage());
                    com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                }
            });
        }
    }


//    @Override
//    public void onClick(View v) {
//        switch (v.getId()) {

//            case R.id.ll_send:// 分享
//                sharePop();
//                break;
//            case R.id.ll_toshow: // 预览
////                previewInvitation();
//                QingjianYulanActivity.startActivity(this, mShowUrl);
//                break;
//            case R.id.ll_setting:// 设置
//                AppUtil.clearInputMethod(v);
//                new PopChooserUtils(QingjianEditActivity.this)
//                        .setChooseData(menuTitles)
//                        .setListenner(new PopChooserUtils.ItemClickListener() {
//                            @Override
//                            public void popItemClick(View view, int position) {
//                                Intent intent;
//                                switch (position) {
//                                    case 0: //设置音乐
//                                        intent = new Intent(QingjianEditActivity.this, ChooseMusicActivity.class);
//                                        startActivityForResult(intent, REQUEST_SET_MUSIC);
//                                        break;
//                                    case 1: //修改信息
//                                        ZhizuoQingjianActivity.startActivityForResult(QingjianEditActivity.this, mShareBean, REQUEST_SET_INFO);
//                                        break;
//                                }
//                            }
//                        })
//                        .show(llParent);
//                break;
//            case R.id.ll_del:
//                del();
//                break;
//        }
//    }

    @OnClick({R.id.iv_back, R.id.ll_zhufu, R.id.ll_binke, R.id.ll_lijin, R.id.ll_bianji, R.id.ll_fenxiang})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.iv_back:
                finish();
                break;
            case R.id.ll_zhufu:
                Intent intent2 = new Intent(QingjianEditActivity.this, BingkeReplyActivity.class);
                intent2.putExtra("tag", 0);
                intent2.putExtra("qingjianid", mShareBean.getInvitationsId());
                startActivity(intent2);
                break;
            case R.id.ll_binke:
                Intent intent3 = new Intent(QingjianEditActivity.this, BingkeReplyActivity.class);
                intent3.putExtra("tag", 1);
                intent3.putExtra("qingjianid", mShareBean.getInvitationsId());
                startActivity(intent3);
                break;
            case R.id.ll_lijin:
                Intent intent4 = new Intent(QingjianEditActivity.this, GiftsActivity.class);
                intent4.putExtra("qingjianid", mShareBean.getInvitationsId());
                startActivity(intent4);
                break;
            case R.id.ll_bianji:
                if (intentType == 1) {
                    Intent intent = new Intent(QingjianEditActivity.this, NewCreateElectronicinvitationActivity.class);
                    intent.putExtra("intentType", 0);
                    intent.putExtra("data", mShareBean);
                    startActivity(intent);
                } else {
                    finish();
                }
                break;
            case R.id.ll_fenxiang:
                sharePop();
                break;
        }
    }

    public static class ShareBean implements Serializable {
        private int invitationsId;  //请柬id
        private String url;         //加载的url
        private String boyName;    //男孩名称
        private String girlName;   //女孩名称
        private String hotle;      // 酒店名称
        private String address;    // 地址
        private String time;       //结婚日期
        private String cover; //封面图片
        private String shareurl;

        public String getShareurl() {
            return shareurl;
        }

        public void setShareurl(String shareurl) {
            this.shareurl = shareurl;
        }

        public String getCover() {
            return cover;
        }

        public void setCover(String cover) {
            this.cover = cover;
        }

        public int getInvitationsId() {
            return invitationsId;
        }

        public void setInvitationsId(int invitationsId) {
            this.invitationsId = invitationsId;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public String getBoyName() {
            return boyName;
        }

        public void setBoyName(String boyName) {
            this.boyName = boyName;
        }

        public String getGirlName() {
            return girlName;
        }

        public void setGirlName(String girlName) {
            this.girlName = girlName;
        }

        public String getHotle() {
            return hotle;
        }

        public void setHotle(String hotle) {
            this.hotle = hotle;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getTime() {
            return time;
        }

        public void setTime(String time) {
            this.time = time;
        }
    }

    class ViewHolder {
        @BindView(R.id.iv_head_img)
        ImageView ivHeadImg;
        @BindView(R.id.rl_slect_photo)
        RelativeLayout rlSlectPhoto;
        @BindView(R.id.ll_share_cir)
        LinearLayout llShareCir;
        @BindView(R.id.ll_share_fri)
        LinearLayout llShareFri;
        @BindView(R.id.ll_share_qq)
        LinearLayout llShareQq;
        @BindView(R.id.ll_share_qzone)
        LinearLayout llShareQzone;
        @BindView(R.id.ll_share_sina)
        LinearLayout llShareSina;
        @BindView(R.id.ll_share_msg)
        LinearLayout llShareMsg;
        @BindView(R.id.ll_close)
        LinearLayout llClose;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.ed_content)
        EditText edContent;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

    //分享跳转
    private void shar(String url, String title, String imag, String description, int index) {
        url = url.replace("indexedit", "index");
        UMWeb web = new UMWeb(url);
        web.setTitle(title);//标题
        UMImage thumb;
        if (imag == null) {
            thumb = new UMImage(QingjianEditActivity.this, R.mipmap.app_icon);
        } else {
            thumb = new UMImage(QingjianEditActivity.this, imag);
        }
        web.setThumb(thumb);  //缩略图
        web.setDescription(description);//描述
        ShareAction shareAction = new ShareAction(QingjianEditActivity.this);
        switch (index) {
            case 0:
                shareAction.withMedia(web).
                        setPlatform(SHARE_MEDIA.WEIXIN_CIRCLE).share();
                break;
            case 1:
                shareAction.withMedia(web).
                        setPlatform(SHARE_MEDIA.WEIXIN).share();
                break;
            case 2:
                shareAction.withMedia(web).
                        setPlatform(SHARE_MEDIA.QQ).share();
                break;
            case 3:
                shareAction.withMedia(web).
                        setPlatform(SHARE_MEDIA.QZONE).share();
                break;
            case 4:
                shareAction.withMedia(web).
                        setPlatform(SHARE_MEDIA.SINA).share();
                break;
        }
        isCanClickShare = true;

    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.CLOSE_YULAN:
                    finish();
                    break;
                case EventCode.YULAN:
                    if (entity.getData() != null)
                        mUrl = (String) entity.getData();
                    mWebView.reload();
                    break;
            }
        } catch (Exception e) {
        }

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
         
    }

    //保存分享信息
    private void saveShareInfo(final String sharecover, final String sharedescribe, final String sharetitle, final int index) {
        LoadDialog.showDialog(this);

        ApiManager.saveQingJianShareInfo(mShareBean.getInvitationsId(), sharecover, sharedescribe, sharetitle, new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                shar(mShareBean.getShareurl(), sharetitle, sharecover, sharedescribe, index);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }


    /**
     * 获取图片路径
     *
     * @return
     */
    private String getPath() {
        String path = Environment.getExternalStorageDirectory() + "/boyi/image/compress";
        File file = new File(path);
        if (file.mkdirs()) {
            return path;
        }
        return path;
    }

    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.CAMERA)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(QingjianEditActivity.this);
                            commonPopWindow.showAtLocation(llBar, Gravity.CENTER, 0, 0);
                            commonPopWindow.getTitText().setText(getResources().getString(R.string.per_photo));
                            commonPopWindow.getCancel().setOnClickListener(view -> {
                                commonPopWindow.dismiss();
                                realShow(type);
                            });
                            commonPopWindow.getSure().setOnClickListener(view -> {
                                commonPopWindow.dismiss();
                            });

                        }else {
                            realShow(type);
                        }
                    }

                    @Override
                    public void onDenied(@NonNull List<String> permissions, boolean doNotAskAgain) {
                        if (doNotAskAgain) {
                            ToastUtils.showToast(QingjianEditActivity.this,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(QingjianEditActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(QingjianEditActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(llBar, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(QingjianEditActivity.this)
                    .openCamera(SelectMimeType.ofImage())
                    .setCompressEngine((CompressFileEngine) (context, source, call) -> {
                        com.linzi.xiguwen.utils.LogUtil.e(getClass().getSimpleName(),"onStartCompress source "+source.size());
                        Luban.with(getApplicationContext())
                                .load(source)
                                .ignoreBy(150).setCompressListener(new OnNewCompressListener() {
                                    @Override
                                    public void onStart() {

                                    }

                                    @Override
                                    public void onSuccess(String source, File compressFile) {
                                        if (call != null) {
                                            call.onCallback(source, compressFile.getAbsolutePath());
                                        }
                                    }

                                    @Override
                                    public void onError(String source, Throwable e) {
                                        if (call != null) {
                                            call.onCallback(source, null);
                                        }

                                    }
                                }).launch();
                    })
                    .forResult(new OnResultCallbackListener<LocalMedia>() {
                        @Override
                        public void onResult(ArrayList<LocalMedia> path) {
                            isFile = true;
                            if (vh != null && path.size() > 0) {
                                String availablePath = path.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = path.get(0).getRealPath();
                                }
                                imgurl = availablePath;
                                uploadImage(new File(imgurl));
                                Glide.with(QingjianEditActivity.this).load(imgurl).into(vh.ivHeadImg);
                                uploadImage(new File(availablePath));
                            }

                        }
                        @Override
                        public void onCancel() {

                        }
                    });
        });
        selectPhotoTypePop.getChose_pic().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(this)
                    .openGallery(SelectMimeType.ofImage())
                    .setMaxSelectNum(1)
                    .setImageEngine(GlideEngine.createGlideEngine())
                    .setCompressEngine((CompressFileEngine) (context, source, call) -> {
                        com.linzi.xiguwen.utils.LogUtil.e(getClass().getSimpleName(),"onStartCompress source "+source.size());
                        Luban.with(getApplicationContext())
                                .load(source)
                                .ignoreBy(150).setCompressListener(new OnNewCompressListener() {
                                    @Override
                                    public void onStart() {

                                    }

                                    @Override
                                    public void onSuccess(String source, File compressFile) {
                                        if (call != null) {
                                            call.onCallback(source, compressFile.getAbsolutePath());
                                        }
                                    }

                                    @Override
                                    public void onError(String source, Throwable e) {
                                        if (call != null) {
                                            call.onCallback(source, null);
                                        }

                                    }
                                }).launch();
                    })
                    .forResult(new OnResultCallbackListener<LocalMedia>() {
                        @Override
                        public void onResult(ArrayList<LocalMedia> path) {
                            isFile = true;
                            if (vh != null && path.size() > 0) {
                                String availablePath = path.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = path.get(0).getRealPath();
                                }
                                imgurl = availablePath;
                                uploadImage(new File(imgurl));
                                Glide.with(QingjianEditActivity.this).load(imgurl).into(vh.ivHeadImg);
                                uploadImage(new File(availablePath));
                            }
                        }
                        @Override
                        public void onCancel() {

                        }
                    });
        });
        selectPhotoTypePop.setOnDismissListener(() -> {
            WindowManager.LayoutParams params = getWindow().getAttributes();
            params.alpha = 1f;
            getWindow().setAttributes(params);
        });
    }




    /**
     * 上传图片
     *
     * @param image
     */
    private void uploadImage(final File image) {
        if (image == null) {
            return;
        }
        ApiManager.uploadImg(image, 2, new OnRequestSubscribe<BaseBean<String>>() {
            @Override
            public void onSuccess(BaseBean<String> data) {
                LoadDialog.CancelDialog();
                imgurl = data.getData();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }
}

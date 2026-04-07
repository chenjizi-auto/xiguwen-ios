package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import androidx.annotation.NonNull;

import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CertificationsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.ImgCompressUtils;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.basic.PictureSelector;
import com.luck.picture.lib.config.SelectMimeType;
import com.luck.picture.lib.engine.CompressFileEngine;
import com.luck.picture.lib.entity.LocalMedia;
import com.luck.picture.lib.interfaces.OnResultCallbackListener;
import com.luck.picture.lib.utils.ToastUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnNewCompressListener;

public class CompanyRZActivity extends BaseActivity {

    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.ed_card_id)
    EditText edCardId;
    @BindView(R.id.ll_notice_zheng)
    LinearLayout llNoticeZheng;
    @BindView(R.id.iv_card_zheng)
    ImageView ivCardZheng;
    @BindView(R.id.rl_zheng)
    RelativeLayout rlZheng;
    @BindView(R.id.iv_card_fan)
    ImageView ivCardFan;
    @BindView(R.id.ll_notice_fan)
    LinearLayout llNoticeFan;
    @BindView(R.id.rl_fan)
    RelativeLayout rlFan;
    @BindView(R.id.iv_zhizhao)
    ImageView ivZhizhao;
    @BindView(R.id.ll_notice_zhizhao)
    LinearLayout llNoticeZhizhao;
    @BindView(R.id.rl_zhizhao)
    RelativeLayout rlZhizhao;
    @BindView(R.id.bt_submit)
    Button btSubmit;

    String path_1;  //正
    String path_2;  //反
    String path_3;  //执照
    private CertificationsBean mData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_company_rz);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("企业实名认证");
        setBack();
        requestRZStatus();
    }

    /**
     * 获取认证状态
     */
    private void requestRZStatus() {
        MsgLoadDialog.showDialog(this, "请稍候...", false);
        ApiManager.getCompanyCertificationStatus(new OnRequestFinish<BaseBean<CertificationsBean>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<CertificationsBean> data) {
                mData = data.getData();
                if (mData == null) {
                    //还未认证
                    return;
                }
                View.OnClickListener listener = new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        switch (mData.getState()) {
                            case CertificationsBean.STATE_ON:
                                finish();
                                break;
                            case CertificationsBean.STATE_PASS:
                               finish();
                                break;
                            case CertificationsBean.STATE_UNPASS:
                                refreshView(mData);
                                break;
                        }
                    }
                };
                switch (mData.getState()) {
                    case CertificationsBean.STATE_ON:
                        showDialog("资料提交成功！", "我们会尽快完成您提供的个人认证资料审核～", "我知道了", listener);
                        break;
                    case CertificationsBean.STATE_PASS:
                        showDialog("恭喜您，实名认证成功！", null, "我知道了", listener);
                        break;
                    case CertificationsBean.STATE_UNPASS:
                        showDialog("很抱歉，实名认证未通过！", mData.getContent(), "修改提交", listener);
                        break;
                    case CertificationsBean.STATE_NOPE:
                        break;
                }
            }

            @Override
            public void onError(Exception ex) {
                showDialog("获取认证状态失败！", null, "我知道了", new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        finish();
                    }
                });
            }
        });
    }

    // 刷新数据
    private void refreshView(CertificationsBean data) {
        if (data != null) {
            edName.setText(data.getName());
            edCardId.setText(data.getIdentitynum());
            if (!TextUtils.isEmpty(data.getIdentitya())) {
                path_1 = data.getIdentitya();
                GlideLoad.GlideLoadImg(this, path_1, ivCardZheng);
            }
            if (!TextUtils.isEmpty(data.getIdentityb())) {
                path_2 = data.getIdentityb();
                GlideLoad.GlideLoadImg(this, path_2, ivCardFan);
            }
            if (!TextUtils.isEmpty(data.getShou_chi_SFZ())) {
                path_3 = data.getShou_chi_SFZ();
                GlideLoad.GlideLoadImg(this, path_3, ivZhizhao);
            }
        }
    }

    private void showDialog(String title, String msg, String button, final View.OnClickListener listener) {
        final AskDialog dialog = new AskDialog(this, this);
        dialog.setTitle(title);
        dialog.setMessage(msg);
        dialog.setSignButton(button, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                if (listener != null) {
                    listener.onClick(v);
                }
            }
        });
        dialog.setCancelable(false);
        dialog.setCanceledOnTouchOutside(false);
        dialog.show();
    }

    @OnClick({R.id.rl_zheng, R.id.rl_fan, R.id.rl_zhizhao, R.id.bt_submit})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.rl_zheng:
                showPop(1002);
                break;
            case R.id.rl_fan:
                showPop(1003);
                break;
            case R.id.rl_zhizhao:
                showPop(1004);
                break;
            case R.id.bt_submit:
                if (check()) {
                    uploadImg();
                }
                break;
        }
    }

    private void showPop(int type) {

        XXPermissions.with(this)
                .permission(Permission.CAMERA)
                .request(new OnPermissionCallback() {

                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(CompanyRZActivity.this);
                            commonPopWindow.showAtLocation(edName, Gravity.CENTER, 0, 0);
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
                            ToastUtils.showToast(mContext,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(mContext, permissions);
                        } else {
                            ToastUtils.showToast(mContext,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(edName, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(mContext)
                    .openCamera(SelectMimeType.ofImage())

                    .setCompressEngine((CompressFileEngine) (context, source, call) -> {
                        com.linzi.xiguwen.utils.LogUtil.e(TAG,"onStartCompress source "+source.size());
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
                        public void onResult(ArrayList<LocalMedia> result) {
                            String availablePath = result.get(0).getAvailablePath();
                            if (availablePath.startsWith("content://")){
                                availablePath = result.get(0).getRealPath();
                            }
                            if (type == 1002){
                                path_1 = availablePath;
                                GlideLoad.GlideLoadImg(mContext, path_1, ivCardZheng);
                            }
                            if (type == 1003){
                                path_2 = availablePath;
                                GlideLoad.GlideLoadImg(mContext, path_2, ivCardFan);
                            }   if (type == 1004){
                                path_3 = availablePath;
                                GlideLoad.GlideLoadImg(mContext, path_3, ivZhizhao);
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
                        com.linzi.xiguwen.utils.LogUtil.e(TAG,"onStartCompress source "+source.size());
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
                        public void onResult(ArrayList<LocalMedia> result) {
                            String availablePath = result.get(0).getAvailablePath();
                            if (availablePath.startsWith("content://")){
                                availablePath = result.get(0).getRealPath();
                            }
                            if (type == 1002){
                                path_1 = availablePath;
                                GlideLoad.GlideLoadImg(mContext, path_1, ivCardZheng);
                            }
                            if (type == 1003){
                                path_2 = availablePath;
                                GlideLoad.GlideLoadImg(mContext, path_2, ivCardFan);
                            }   if (type == 1004){
                                path_3 = availablePath;
                                GlideLoad.GlideLoadImg(mContext, path_3, ivZhizhao);
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



    private boolean check() {
        if (TextUtils.isEmpty(edName.getText().toString().trim())) {
            NToast.show("请输入法人姓名");
            return false;
        }
        if (TextUtils.isEmpty(edCardId.getText().toString().trim())) {
            NToast.show("请输入法人身份证号码");
            return false;
        } else {
            if (!AppUtil.isIdcard(edCardId.getText().toString().trim())) {
                NToast.show("身份证号码有误！");
                return false;
            }
        }

        if (path_1 == null || path_2 == null) {
            NToast.show("请添加身份证照片");
            return false;
        }
        if (path_3 == null) {
            NToast.show("请添加企业营业执照");
            return false;
        }
        return true;
    }

    int uploadFinishCount; //上传图片数量
    boolean uploadFlag;// 上传状态的标记

    private void uploadImg() {
        // 上传图片
        MsgLoadDialog.showDialog(this, "请稍候...");
        List<String> uploadImgs = new ArrayList();
        if (!path_1.toLowerCase().startsWith("http")) {
            uploadImgs.add(path_1);
        }
        if (!path_2.toLowerCase().startsWith("http")) {
            uploadImgs.add(path_2);
        }
        if (!path_3.toLowerCase().startsWith("http")) {
            uploadImgs.add(path_3);
        }
        if (uploadImgs.size() == 0) {
            submitOrder();
            return;
        }
        final int uploadCount = uploadImgs.size();
        uploadFlag = true;
        uploadFinishCount = 0;
        MsgLoadDialog.updateMsg("上传图片中...");
        for (final String uploadImg : uploadImgs) {
            ApiManager.uploadImgBase64(ImgCompressUtils.getBase64StrWithHead(uploadImg), new OnRequestFinish<BaseBean<String>>() {
                @Override
                public void onFinished() {
                    uploadFinishCount++;
                    if (uploadFinishCount == uploadCount) {
                        if (uploadFlag) {
                            submitOrder();
                        } else {
                            NToast.show("上传失败");
                            MsgLoadDialog.CancelDialog();
                        }
                    }
                }

                @Override
                public void onSuccess(BaseBean<String> data) {
                    if (uploadImg.equals(path_1)) {
                        path_1 = data.getData();
                    } else if (uploadImg.equals(path_2)) {
                        path_2 = data.getData();
                    } else if (uploadImg.equals(path_3)) {
                        path_3 = data.getData();
                    }
                }

                @Override
                public void onError(Exception ex) {
                    uploadFlag = false;
                }
            });

        }
    }

    private void submitOrder() {
        MsgLoadDialog.updateMsg("保存中...");
        ApiManager.submitCompanyCertification(edName.getText().toString().trim(), edCardId.getText().toString().trim(), path_1, path_2, path_3, new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("提交成功");
                finish();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }
}

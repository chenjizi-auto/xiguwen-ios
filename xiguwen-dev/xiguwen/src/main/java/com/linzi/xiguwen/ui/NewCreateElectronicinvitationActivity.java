package com.linzi.xiguwen.ui;


import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;

import androidx.annotation.NonNull;
import androidx.core.content.FileProvider;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.PagerSnapHelper;
import androidx.recyclerview.widget.RecyclerView;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.google.gson.Gson;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.QingJianInfoBean;
import com.linzi.xiguwen.bean.QingJianMainBean;
import com.linzi.xiguwen.bean.UnitByJson;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.CropUtils;
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
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.PostEditReuslt;
import com.linzi.xiguwen.view.TextEditPopWindow;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.basic.PictureSelector;
import com.luck.picture.lib.config.SelectMimeType;
import com.luck.picture.lib.engine.CompressFileEngine;
import com.luck.picture.lib.entity.LocalMedia;
import com.luck.picture.lib.interfaces.OnResultCallbackListener;
import com.luck.picture.lib.utils.ToastUtils;


import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnCompressListener;
import top.zibin.luban.OnNewCompressListener;


/**
 * Created by pc on 2018/6/7.
 */

public class NewCreateElectronicinvitationActivity extends AppCompatActivity {
    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.recycleview)
    RecyclerView recycleview;

    private double pageWidth;
    private double pageHeight;
    double paddingLeft, paddingTop, viewWidth, viewHeight;

    private int mCurrentItemOffset;
    private float mScale = 0.85f;//cardview滑动缩放
    private float scaleBili = 0.85f;//cardview缩放
    private int mCurrentItemPos = 0;//显示的item index
    private int intentType;//0 预览跳转  1: 选择模板跳转
    private Context context;
    private QingjianEditActivity.ShareBean mShareBean;
    private String json;//请柬信息json

    private QingJianInfoBean bean;
    private UnitByJson unitByJson;

    private String url;//预览地址


    private InvitationAdapter adapter;

    private QingJianMainBean qingJianMainBean;//适配器数据源

    int imagviewIndex = -1;
    int textviewIndex = -1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(NewCreateElectronicinvitationActivity.this, R.color.white);
            StatusBarUtil.setNavigationBarColor(NewCreateElectronicinvitationActivity.this, R.color.white);
        }
        setContentView(R.layout.new_create_electroinvitation_layout);
        ButterKnife.bind(this);
        intentType = getIntent().getIntExtra("intentType", -1);
        mShareBean = (QingjianEditActivity.ShareBean) getIntent().getSerializableExtra("data");
        url = mShareBean.getUrl();
        context = this;
        initView();
    }

    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(NewCreateElectronicinvitationActivity.this));
        llBar.setLayoutParams(params);
        llBar.setBackgroundColor(NewCreateElectronicinvitationActivity.this.getResources().getColor(R.color.white));

        if (mShareBean == null) {
            NToast.show("参数异常");
            finish();
            return;
        }
        if (intentType != -1) {
            if (intentType == 0) {
                getDataMine();
            } else {
                getDataMuBan();
            }
        } else {
            NToast.show("参数异常");
            finish();
            return;
        }
    }

    /**
     * px to dp
     *
     * @param v
     * @return
     */
    private int getdp(float v) {
        return AppUtil.px2dip(context, v);
    }

    /**
     * dp to px
     *
     * @param v
     * @return
     */
    private int getpx(float v) {
        return AppUtil.dip2px(context, v);
    }

    @OnClick({R.id.ll_back, R.id.ll_right, R.id.ll_shanchu, R.id.ll_shanye, R.id.ll_yulan})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.ll_back:
                finish();
                break;
            case R.id.ll_right:
                Intent intent = new Intent(NewCreateElectronicinvitationActivity.this, ChooseMusicActivity.class);
                intent.putExtra("qingjianid", mShareBean.getInvitationsId());
                startActivity(intent);
                break;
            case R.id.ll_shanchu:
                del();
                break;
            case R.id.ll_shanye:
                if (mCurrentItemPos == 0) {
                    NToast.show("请柬首页不能删除哦！~");
                    return;
                }
                delPage();
                break;
            case R.id.ll_yulan:
                if (intentType == 0) {
                    finish();
                } else {
                    QingjianEditActivity.ShareBean shareBean = new QingjianEditActivity.ShareBean();
                    shareBean.setUrl(url);
                    QingjianEditActivity.startActivityForResult(NewCreateElectronicinvitationActivity.this, shareBean, 0, 123);
                }
                break;
        }
    }

    private void onScrolledChangedCallback() {
        //当前滑动偏移值
        int offset = (int) (mCurrentItemOffset - mCurrentItemPos * getpx((float) viewWidth));
        //当前滑动比例
        float percent = (float) Math.max(Math.abs(offset) * 1.0 / getpx((float) viewWidth), 0.000000000001);
        if (percent > 1) {
            percent = 1;
        }
        View leftView = null;
        View currentView;
        View rightView = null;
        if (mCurrentItemPos > 0) {
            leftView = recycleview.getLayoutManager().findViewByPosition(mCurrentItemPos - 1);
        }
        currentView = recycleview.getLayoutManager().findViewByPosition(mCurrentItemPos);
        if (mCurrentItemPos < recycleview.getAdapter().getItemCount() - 1) {
            rightView = recycleview.getLayoutManager().findViewByPosition(mCurrentItemPos + 1);
        }
        if (mCurrentItemPos == 0) {
            rightView = recycleview.getLayoutManager().findViewByPosition(mCurrentItemPos + 1);
        }

        if (leftView != null) {
            // y = (1 - mScale)x + mScale
            leftView.setScaleY((1 - mScale) * percent + mScale);
            leftView.setScaleX((1 - mScale) * percent + mScale);
        }
        if (currentView != null) {
            // y = (mScale - 1)x + 1
            currentView.setScaleY((mScale - 1) * percent + 1);
            currentView.setScaleX((mScale - 1) * percent + 1);
        }
        if (rightView != null) {
            // y = (1 - mScale)x + mScale
            rightView.setScaleY((1 - mScale) * percent + mScale);
            rightView.setScaleX((1 - mScale) * percent + mScale);
        }
    }

    private void createView(String json) {
        recycleview.setLayoutManager(new LinearLayoutManager(context, LinearLayoutManager.HORIZONTAL, false));
        new PagerSnapHelper() {
            @Override
            public int findTargetSnapPosition(RecyclerView.LayoutManager layoutManager, int velocityX, int velocityY) {
                //获取当前position和左滑还是右滑
                int position = super.findTargetSnapPosition(layoutManager, velocityX, velocityY);
                if (velocityX > 0) {//左滑

                } else {//右滑

                }
                mCurrentItemPos = position;
                return position;
            }
        }.attachToRecyclerView(recycleview);

        recycleview.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(RecyclerView recyclerView, int newState) {
                super.onScrollStateChanged(recyclerView, newState);
                if (newState == 0) {//滑动结束
                    onScrolledChangedCallback();
                }
            }
        });
        qingJianMainBean = createAdapterData(json);
        adapter = new InvitationAdapter(context, qingJianMainBean);
        recycleview.setAdapter(adapter);

        DisplayMetrics metrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(metrics);

        int heightPixel = metrics.heightPixels;
        int widthPixel = metrics.widthPixels;

        pageHeight = getdp(heightPixel);//父布局的高
        pageWidth = getdp(widthPixel);//父布局的宽

        viewHeight = 568 * scaleBili;
        viewWidth = 320 * scaleBili;

        paddingLeft = (pageWidth - viewWidth) / 2;
        paddingTop = (pageHeight - viewHeight) / 2;

        recycleview.setPadding(AppUtil.dip2px(context, (float) paddingLeft), AppUtil.dip2px(context, (float) paddingTop), AppUtil.dip2px(context, (float) paddingLeft), AppUtil.dip2px(context, (float) paddingTop));
        recycleview.setClipToPadding(false);

        recycleview.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
                super.onScrolled(recyclerView, dx, dy);
                // dx>0则表示右滑, dx<0表示左滑, dy<0表示上滑, dy>0表示下滑
                if (dx != 0) {//去掉奇怪的内存疯涨问题
                    mCurrentItemOffset += dx;
                    //computeCurrentItemPos();
                    onScrolledChangedCallback();
                }
            }
        });

        ViewTreeObserver viewTreeObserver = recycleview.getViewTreeObserver();
        viewTreeObserver.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                onScrolledChangedCallback();
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        //裁剪后的图片
        if (requestCode == 2001 && resultCode == RESULT_OK && data != null) {
            int unitid = -1;
            for (int i = 0; i < qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().size(); i++) {
                if (qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getId() == imagviewIndex) {
                    unitid = qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getUnitid();
                }
            }
            String filePath = Environment.getExternalStorageDirectory().getPath() + "/" + "small.jpg";
            if (unitid != -1)
                compress(filePath, imagviewIndex, unitid, mCurrentItemPos);
            else {
                NToast.show("获取图片失败！");
            }
        }
    }

    /**
     * 通过适配器数据源转换JsonBean
     */
    private void reSetBean(int pageIndex, int unitid, String value, int type) {
        List<UnitByJson.BeanBean> bean1 = unitByJson.getBean();
        if (type == 2) {
            bean1.remove(pageIndex);
        } else {
            UnitByJson.BeanBean bean = bean1.get(pageIndex);
            List<UnitByJson.BeanBean.UnitbeanBean> bean2 = bean.getUnitbean();

            for (int j = 0; j < bean2.size(); j++) {
                UnitByJson.BeanBean.UnitbeanBean unitbeanBean = bean2.get(j);
                if (unitbeanBean.getUnitid() == unitid) {
                    unitbeanBean.setValue(value);
                }
            }
        }
        getJson(type);
    }

    /**
     * 组装json传给后台
     *
     * @param type type 0 图片  1文字  2 删页
     */
    private void getJson(int type) {

        String appdata = new Gson().toJson(unitByJson);
        NToast.log("apptag", appdata);
        requsetSave(mShareBean.getInvitationsId(), appdata, type);
    }

    //--------------------------------------------------------------------------------- 图片处理 -------------------------------------------------------------------------------------------------------

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

    /**
     * 压缩图片
     *
     * @param photos
     */
    private void compress(String photos, final int id, final int unitid, final int pageIndex) {
        uploadImage(new File(photos), id, unitid, pageIndex);
    }

    //--------------------------------------------------------------------------------- 提示框 -------------------------------------------------------------------------------------------------------

    /**
     * 删页提醒
     */
    private void delPage() {
        final AskDialog dialog = new AskDialog(this, this);
        dialog.setTitle("警告");
        dialog.setMessage("是否删除该页？");
        dialog.setCancleListener("我点错了", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener("确认删除", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                reSetBean(mCurrentItemPos, -1, null, 2);
            }
        });
        dialog.show();
    }

    /**
     * 删除请柬提醒
     */
    private void del() {
        final AskDialog dialog = new AskDialog(this, this);
        dialog.setTitle("警告");
        dialog.setMessage("是否删除该请柬？");
        dialog.setCancleListener("我点错了", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener("确认删除", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                _del();
            }
        });
        dialog.show();
    }

    /**
     * 重新保存操作
     */
    private void reSave(final int id, final String appdata, final int type) {
        final AskDialog dialog = new AskDialog(this, this);
        dialog.setTitle("警告");
        dialog.setMessage("上一步保存失败，是否重试？");
        dialog.setCancleListener("不用了", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener("重试", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                requsetSave(id, appdata, type);
            }
        });
        dialog.show();
    }

    //--------------------------------------------------------------------------------- 网络请求 -------------------------------------------------------------------------------------------------------

    /**
     * 上传图片
     *
     * @param image
     */
    private void uploadImage(final File image, final int id, final int unitid, final int pageIndex) {
        if (image == null) {
            return;
        }
        int type;
        if (mCurrentItemPos == 0) {
            type = 2;
        } else {
            type = 1;
        }
        ApiManager.uploadImg(image, type, new OnRequestSubscribe<BaseBean<String>>() {
            @Override
            public void onSuccess(BaseBean<String> data) {
                LoadDialog.CancelDialog();
                for (int i = 0; i < qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().size(); i++) {
                    if (qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getId() == id) {
                        qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).setValue(data.getData());
                    }
                }
                reSetBean(pageIndex, unitid, data.getData(), 1);
                adapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }

    /**
     * 删除请柬请求
     */
    private void _del() {
        MsgLoadDialog.showDialog(this, "删除中...");
        ApiManager.delInvitation(mShareBean.getInvitationsId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("删除成功");
                setResult(RESULT_OK);
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH_QINGJIAN_LIST));
                EventBusUtil.sendEvent(new Event(EventCode.CLOSE_YULAN));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    /**
     * 保存请柬请求
     *
     * @param id      umid
     * @param appdata
     * @param type    type 0 图片  1文字  2 删页
     */
    private void requsetSave(final int id, final String appdata, final int type) {
        if (mCurrentItemPos == 0)
            LoadDialog.showDialog(context);
        int t;
        if (mCurrentItemPos == 0) {
            t = 1;
        } else {
            t = 0;
        }
        ApiManager.saveQingJianInfo(id, appdata, t, new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                if (mCurrentItemPos == 0) {
                    EventBusUtil.sendEvent(new Event(EventCode.REFRESH_QINGJIAN_LIST));
                }
                url = data.getData();
                if (type == 0) {

                } else if (type == 1) {

                } else {
                    adapter.notifyItemRemoved(mCurrentItemPos);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                reSave(id, appdata, type);
            }
        });
    }

    /**
     * 我的请柬列表获取请柬信息
     */
    private void getDataMine() {
        LoadDialog.showDialog(context);
        ApiManager.getQingJianInfoByMine(mShareBean.getInvitationsId(), new OnRequestFinish<BaseBean<QingJianInfoBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<QingJianInfoBean> data) {
                bean = data.getData();
                if (bean != null) {
                    json = bean.getAppdata();
                    mShareBean.setInvitationsId(bean.getUmid());
                    if (json.equals("")) {
                        finish();
                        NToast.show("请柬有误，请重试！~");
                    } else {
                        createView(json);
                    }
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                finish();
            }
        });
    }

    /**
     * 模板列表获取请柬信息
     */
    private void getDataMuBan() {
        LoadDialog.showDialog(context);
        ApiManager.getQingJianInfoByMuBan(mShareBean.getInvitationsId(), new OnRequestFinish<BaseBean<QingJianInfoBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<QingJianInfoBean> data) {
                bean = data.getData();
                if (bean != null) {
                    json = bean.getAppdata();
                    mShareBean.setInvitationsId(bean.getUmid());
                    if (json.equals("")) {
                        finish();
                        NToast.show("请柬有误，请重试！~");
                    } else {
                        createView(json);
                    }
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                finish();
            }
        });
    }

    //--------------------------------------------------------------------------------- 适配器 -------------------------------------------------------------------------------------------------------

    /**
     * 通过json组装适配器数据源
     *
     * @param json
     * @return
     */
    private QingJianMainBean createAdapterData(String json) {

        QingJianMainBean qingJianMainBean = new QingJianMainBean();
        List<QingJianMainBean.PageBean> pageBeanList = new ArrayList<>();
        int imgageId = -1;
        int textId = -1;

        //第一层组装bean  转化json用次层
        unitByJson = new Gson().fromJson(json, UnitByJson.class);
        //page bean
        List<UnitByJson.BeanBean> pageUnit = unitByJson.getBean();
        //遍历page bean 取得 page unit
        for (int i = 0; i < pageUnit.size(); i++) {
            QingJianMainBean.PageBean pageBean = new QingJianMainBean.PageBean();
            List<QingJianMainBean.PageBean.ImageBean> imageBeanList = new ArrayList<>();
            List<QingJianMainBean.PageBean.TextBean> textBeanList = new ArrayList<>();
            QingJianMainBean.PageBean.BackgroundBean backgroundBean = new QingJianMainBean.PageBean.BackgroundBean();

            //每页下的weight 元素 list
            List<UnitByJson.BeanBean.UnitbeanBean> unitBeanBeanList = pageUnit.get(i).getUnitbean();
            //阶层排序 sort
            Collections.sort(unitBeanBeanList);
            for (int j = 0; j < unitBeanBeanList.size(); j++) {

                //取得每个weight 元素
                UnitByJson.BeanBean.UnitbeanBean bean = unitBeanBeanList.get(j);

                if (bean.getType() == 3) {//图片
                    imgageId++;
                    QingJianMainBean.PageBean.ImageBean imageBean = new QingJianMainBean.PageBean.ImageBean();
                    imageBean.setUnitid(bean.getUnitid());
                    //id
                    imageBean.setId(imgageId);
                    //图片地址
                    imageBean.setValue(bean.getValue());
                    //图片高度
                    imageBean.setHeight(bean.getHeight());
                    //图片宽度
                    imageBean.setWidth(bean.getWidth());
                    //图片形状
                    imageBean.setShape(bean.getShape());
                    //图片父左边距
                    imageBean.setLeft(bean.getLeft());
                    //图片父上边距
                    imageBean.setTop(bean.getTop());

                    imageBeanList.add(imageBean);

                } else if (bean.getType() == 2) {//文本
                    textId++;
                    QingJianMainBean.PageBean.TextBean textBean = new QingJianMainBean.PageBean.TextBean();
                    textBean.setUnitid(bean.getUnitid());
                    textBean.setId(textId);
                    textBean.setColor(bean.getColor());
                    textBean.setAddress(bean.getAddress());
                    textBean.setHeight(bean.getHeight());
                    textBean.setLeft(bean.getLeft());
                    textBean.setPadding(bean.getPadding());
                    textBean.setSize(bean.getSize());
                    textBean.setTextAlign(bean.getTextAlign());
                    textBean.setTime(bean.getTime());
                    textBean.setTop(bean.getTop());
                    textBean.setValue(bean.getValue());
                    textBean.setWidth(bean.getWidth());
                    textBean.setLineHeight(bean.getLineHeight());
                    textBeanList.add(textBean);

                } else {//背景图
                    backgroundBean.setValue(bean.getValue());
                    backgroundBean.setUnitid(bean.getUnitid());
                }

                pageBean.setImageBeans(imageBeanList);
                pageBean.setTextBeans(textBeanList);
                pageBean.setBackgroundBean(backgroundBean);
            }
            pageBeanList.add(pageBean);
        }
        qingJianMainBean.setPageBeans(pageBeanList);

        return qingJianMainBean;
    }

    class InvitationAdapter extends RecyclerView.Adapter<InvitationAdapter.ViewHolder> {
        private List<ImageView> imageViewList = new ArrayList<>();
        private List<TextView> textViewList = new ArrayList<>();


        private Context mContext;
        private QingJianMainBean list;

        public List<ImageView> getImageViewList() {
            return imageViewList;
        }

        public List<TextView> getTextViewList() {
            return textViewList;
        }

        public InvitationAdapter(Context mContext, QingJianMainBean list) {
            this.mContext = mContext;
            this.list = list;
        }

        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.adapter, parent, false);
            return new ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            holder.rlUnit.removeAllViews();
            deal(list.getPageBeans().get(position), holder.rlUnit);

//            //生成角标
//            TextView tvIndex = new TextView(mContext);
//            tvIndex.setTextSize(14);
//            tvIndex.setTextColor(mContext.getResources().getColor(R.color.white));
//            tvIndex.setBackground(mContext.getResources().getDrawable(R.drawable.qingjian_index_view_bg));
//            tvIndex.setPadding(getpx(8), getpx(4), getpx(8), getpx(4));
//            tvIndex.setText(list.get(position).getPage() + "/" + list.size());
//            holder.rlUnit.addView(tvIndex);
//            RelativeLayout.LayoutParams layoutParams = (RelativeLayout.LayoutParams) tvIndex.getLayoutParams();
//            layoutParams.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM, RelativeLayout.ALIGN_PARENT_RIGHT);
//            tvIndex.setLayoutParams(layoutParams);
        }

        /**
         * 解析数据源生成view
         *
         * @param pageBeans
         * @param rootView
         */
        private void deal(QingJianMainBean.PageBean pageBeans, RelativeLayout rootView) {

            List<QingJianMainBean.PageBean.ImageBean> imageBeanList = pageBeans.getImageBeans();
            List<QingJianMainBean.PageBean.TextBean> textBeanList = pageBeans.getTextBeans();
            QingJianMainBean.PageBean.BackgroundBean backgroundBean = pageBeans.getBackgroundBean();

            //图片
            for (int m = 0; m < imageBeanList.size(); m++) {
                final QingJianMainBean.PageBean.ImageBean imageBean = imageBeanList.get(m);
                String value = imageBean.getValue();//图片地址
                if (value != null && !value.equals("")) {//非空创建View
                    ImageView imageView = new ImageView(mContext);

                    RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                    layoutParams.topMargin = getpx((imageBean.getTop() * scaleBili));
                    layoutParams.leftMargin = getpx((imageBean.getLeft() * scaleBili));


                    //加载网络图片
                    switch (imageBean.getShape()) {
                        case 1://圆形
                            layoutParams.width = getpx((imageBean.getWidth() * scaleBili));
                            layoutParams.height = getpx((imageBean.getHeight() * scaleBili));
                            GlideLoad.GlideLoadCircle(imageBean.getValue(), imageView);
                            break;
                        case 2://正方形
                            layoutParams.width = getpx((imageBean.getWidth() * scaleBili));
                            layoutParams.height = getpx((imageBean.getHeight() * scaleBili));
                            GlideLoad.GlideLoadImg2(imageBean.getValue(), imageView);
                            break;
                        case 3://长方形
                            layoutParams.width = getpx((imageBean.getWidth() * scaleBili));
                            layoutParams.height = getpx((imageBean.getHeight() * scaleBili));
                            GlideLoad.GlideLoadImg2(imageBean.getValue(), imageView);
                            break;
                        default:
                            layoutParams.width = getpx((imageBean.getWidth() * scaleBili));
                            layoutParams.height = getpx((imageBean.getHeight() * scaleBili));
                            GlideLoad.GlideLoadImgNoCenter(imageBean.getValue(), imageView);
                            break;
                    }

                    layoutParams.addRule(Gravity.CENTER);

                    RelativeLayout relativeLayout = new RelativeLayout(mContext);
                    relativeLayout.setGravity(Gravity.CENTER);
                    relativeLayout.addView(imageView);
                    relativeLayout.setLayoutParams(layoutParams);

                    //添加本地修改图标
                    ImageView imageIcon = new ImageView(mContext);
                    imageIcon.setBackgroundResource(R.mipmap.qingjian_bj_icon);
                    relativeLayout.addView(imageIcon);
                    RelativeLayout.LayoutParams layoutParams1 = (RelativeLayout.LayoutParams) imageIcon.getLayoutParams();
                    layoutParams1.addRule(RelativeLayout.CENTER_IN_PARENT);
                    imageIcon.setLayoutParams(layoutParams1);

                    imageView.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            showPop(1001);
                            imagviewIndex = imageBean.getId();
                        }
                    });
                    imageViewList.add(imageView);

                    rootView.addView(relativeLayout);
                } else {
                    return;
                }
            }

            //背景图
            String value = backgroundBean.getValue();
            if (value != null && !value.equals("")) {//非空创建View
                ImageView imageView = new ImageView(mContext);
                RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
                GlideLoad.GlideLoadImgNoCenter(backgroundBean.getValue(), imageView);
                imageView.setLayoutParams(layoutParams);
                rootView.addView(imageView);
            } else {
                return;
            }

            //文本
            for (int n = 0; n < textBeanList.size(); n++) {
                final QingJianMainBean.PageBean.TextBean textBean = textBeanList.get(n);
                String text = textBean.getValue();//字符串

                if (text != null && !text.equals("")) {//非空创建View
                    TextView textView = new TextView(mContext);
                    RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                    layoutParams.topMargin = getpx((textBean.getTop() * scaleBili));
                    layoutParams.leftMargin = getpx((textBean.getLeft() * scaleBili));
                    layoutParams.width = getpx((textBean.getWidth() * scaleBili));
                    //layoutParams.height = getpx((textBean.getHeight() * scaleBili));

                    //textView.setPadding(getpx(textBean.getPadding() * scaleBili), getpx(textBean.getPadding() * scaleBili), getpx(textBean.getPadding() * scaleBili), getpx(textBean.getPadding() * scaleBili));
                    textView.setPadding(0, 0, 0, 0);
                    textView.setTextColor(Color.parseColor(textBean.getColor()));
                    textView.setTextSize(textBean.getSize() * 0.75f);
                    textView.setText(textBean.getValue().replace("<br>", "\n"));
                    textView.setLineSpacing(textBean.getLineHeight() * scaleBili, 1.0f);
                    textView.setBackground(mContext.getResources().getDrawable(R.drawable.test));

                    if (textBean.getTextAlign().equals("left")) {
                        textView.setGravity(Gravity.LEFT);
                    } else if (textBean.getTextAlign().equals("right")) {
                        textView.setGravity(Gravity.RIGHT);
                    } else {
                        textView.setGravity(Gravity.CENTER);
                    }

                    textView.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            createPopWindows(((TextView) view), textBean);
                        }
                    });

                    textView.setLayoutParams(layoutParams);
                    textViewList.add(textView);
                    rootView.addView(textView);
                } else {
                    return;
                }
            }
        }

        @Override
        public int getItemCount() {
            return list.getPageBeans() == null ? 0 : list.getPageBeans().size();
        }

        class ViewHolder extends RecyclerView.ViewHolder {
            @BindView(R.id.rl_unit)
            RelativeLayout rlUnit;

            public ViewHolder(View itemView) {
                super(itemView);
                ButterKnife.bind(this, itemView);
            }
        }

        private void createPopWindows(final TextView view, final QingJianMainBean.PageBean.TextBean textBean) {
            TextEditPopWindow textEditPopWindow = new TextEditPopWindow(context, view.getText().toString());
            textEditPopWindow.setInputMethodMode(PopupWindow.INPUT_METHOD_NEEDED);
            textEditPopWindow.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
            textEditPopWindow.setPostEditReuslt(new PostEditReuslt() {
                @Override
                public void onSubmit(String str) {
                    textviewIndex = textBean.getId();
                    textBean.setValue(str);
                    view.setText(str);
                    str = str.replace("\n", "<br>");
                    reSetBean(mCurrentItemPos, textBean.getUnitid(), str, 1);
                }
            });
            textEditPopWindow.showAtLocation(view, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        }
    }


    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.CAMERA,Permission.MANAGE_EXTERNAL_STORAGE)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(NewCreateElectronicinvitationActivity.this);
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
                            ToastUtils.showToast(NewCreateElectronicinvitationActivity.this,"被永久拒绝授权，请手动授予相机权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(NewCreateElectronicinvitationActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(NewCreateElectronicinvitationActivity.this,"获取存储权限失败");
                        }
                    }
                });
    }

    private void realShow(int type) {
        int max = type == 1001? 1:1;
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(llBar, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(NewCreateElectronicinvitationActivity.this)
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
                        public void onResult(ArrayList<LocalMedia> result) {
                            if (type == 1001){
                                String availablePath = result.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = result.get(0).getRealPath();
                                }
                                Uri uri = Uri.fromFile(new File(availablePath));
                                for (int i = 0; i < qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().size(); i++) {
                                    if (qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getId() == imagviewIndex) {
                                        CropUtils.invokeSystemCrop(NewCreateElectronicinvitationActivity.this, uri, (int) qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getWidth(),
                                                (int) qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getHeight(),
                                                (int) qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getWidth() * 2,
                                                (int) qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getHeight() * 2);
                                    }
                                }
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
                    .setMaxSelectNum(max)
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
                        public void onResult(ArrayList<LocalMedia> result) {
                            if (type == 1001){
                                String availablePath = result.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = result.get(0).getRealPath();
                                }
                                Uri uri = Uri.fromFile(new File(availablePath));
                                for (int i = 0; i < qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().size(); i++) {
                                    if (qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getId() == imagviewIndex) {
                                        CropUtils.invokeSystemCrop(NewCreateElectronicinvitationActivity.this, uri, (int) qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getWidth(),
                                                (int) qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getHeight(),
                                                (int) qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getWidth() * 2,
                                                (int) qingJianMainBean.getPageBeans().get(mCurrentItemPos).getImageBeans().get(i).getHeight() * 2);
                                    }
                                }
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


    @Override
    public void finish() {
        super.finish();
        Event event = new Event(EventCode.YULAN);
        event.setData(url);
        EventBusUtil.sendEvent(event);
    }
}

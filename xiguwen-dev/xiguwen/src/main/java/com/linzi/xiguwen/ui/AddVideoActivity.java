package com.linzi.xiguwen.ui;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.MediaMetadataRetriever;
import android.media.ThumbnailUtils;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.BaseBean;
import com.linzi.xiguwen.bean.VideoBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.ImgCompressUtils;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.UISwitchButton;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.basic.PictureSelectionModel;
import com.luck.picture.lib.basic.PictureSelector;
import com.luck.picture.lib.config.SelectMimeType;
import com.luck.picture.lib.engine.CompressFileEngine;
import com.luck.picture.lib.entity.LocalMedia;
import com.luck.picture.lib.interfaces.OnResultCallbackListener;
import com.luck.picture.lib.utils.ToastUtils;

import org.xutils.common.Callback;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnNewCompressListener;


public class AddVideoActivity extends BaseActivity {


    ArrayList<String> path = new ArrayList<>();
    // /storage/emulated/0/pic
    public final String SAVED_IMAGE_PATH1 = Environment.getExternalStorageDirectory() + "/bytc/img";//+"/pic";
    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.ed_web_http)
    EditText edWebHttp;
    @BindView(R.id.ed_weight)
    EditText edWeight;
    @BindView(R.id.iv_fengmian)
    ImageView ivFengmian;
    @BindView(R.id.ll_choose_fengmian)
    LinearLayout llChooseFengmian;
    @BindView(R.id.iv_vadio)
    ImageView ivVadio;
    @BindView(R.id.ll_choose_vadio)
    LinearLayout llChooseVadio;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    @BindView(R.id.sb_video_type)
    UISwitchButton mSbVideoType;
    @BindView(R.id.tv_video_type)
    TextView mTvVideoType;
    @BindView(R.id.ll_video_url)
    LinearLayout mLlVideoUrl;

    private String img_name;
    String path_1;

    private boolean isUpload;// 是否已经上传成功的标记
    private String mFengMianPath;// 封面图片地址
    private String mVideoPath;// 视频地址
    ProgressDialog mProgressDialog;
    private Callback.Cancelable mUploadTask; // 上传的任务

    private VideoBean mData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_vadio);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (VideoBean) getIntent().getSerializableExtra("data");
        if(mData == null){
            setTitle("添加视频");
        }else{
            setTitle("编辑视频");
        }
        setBack();

        mSbVideoType.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    mTvVideoType.setText("外链");
                    llChooseVadio.setVisibility(View.GONE);
                    mLlVideoUrl.setVisibility(View.VISIBLE);
                } else {
                    mTvVideoType.setText("视频");
                    mLlVideoUrl.setVisibility(View.GONE);
                    llChooseVadio.setVisibility(View.VISIBLE);
                }
            }
        });
        mSbVideoType.setChecked(true);

        refreshView(mData);
    }

    private void refreshView(VideoBean data) {
        if(data != null){
            edWebHttp.setText(data.getVideo_url());
            edName.setText(data.getTitle());
            edWeight.setText(data.getWeigh() + "");
            mFengMianPath = data.getCover();
            GlideLoad.GlideLoadImg(this, mFengMianPath, ivFengmian);
        }
    }

    private boolean check() {
        if (TextUtils.isEmpty(edName.getText().toString().trim())) {
            NToast.show("请输入名称");
            return false;
        }
        if (mSbVideoType.isChecked()) {
            //外链
            if (TextUtils.isEmpty(edWebHttp.getText().toString().trim())) {
                NToast.show("请输入视频链接");
                return false;
            } else if (!edWebHttp.getText().toString().trim().toLowerCase().startsWith("http")) {
                NToast.show("请输入正确的视频链接");
                return false;
            }
        } else {
            if (mVideoPath == null) {
                NToast.show("请选择需要上传的视频");
                return false;
            }
            if (mFengMianPath == null) {
                NToast.show("请选择视频封面");
                return false;
            }
        }
        if(TextUtils.isEmpty(edWeight.getText().toString().trim())){
            NToast.show("请输入排序");
            return false;
        }else{
            try {
                Float.parseFloat(edWeight.getText().toString().trim());
            } catch (Exception e) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                NToast.show("排序输入格式有误");
                return false;
            }
        }
        return true;
    }

    // 上传图片
    public void uploadImg(){
        if(mFengMianPath.toLowerCase().startsWith("http")){
            uploadVideo();
            return;
        }
        MsgLoadDialog.showDialog(this, "上传图片中...");
        ApiManager.uploadImgBase64(ImgCompressUtils.getBase64StrWithHead(mFengMianPath), new OnRequestFinish<com.linzi.xiguwen.net.base.BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(com.linzi.xiguwen.net.base.BaseBean<String> data) {
                mFengMianPath = data.getData();
                uploadVideo();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    // 上传视频
    public void uploadVideo() {
        if (mSbVideoType.isChecked()) {
            // 说明是外链，直接提交表单
            submitOrder(edWebHttp.getText().toString().trim());
        } else {
            if (mVideoPath.toLowerCase().startsWith("http")) {
                submitOrder(mVideoPath);
                return;
            }
            File file = new File(mVideoPath);
            if (file.exists()) {
                if (mProgressDialog == null) {
                    mProgressDialog = new ProgressDialog(this);
                    mProgressDialog.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
                    mProgressDialog.setTitle("上传中...");
                    mProgressDialog.setCanceledOnTouchOutside(false);
                    mProgressDialog.setCancelable(true);
                    mProgressDialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
                        @Override
                        public void onCancel(DialogInterface dialog) {
                            if (mUploadTask != null) {
                                final AskDialog askDialog = new AskDialog(AddVideoActivity.this, AddVideoActivity.this);
                                askDialog.setTitle("提示");
                                askDialog.setMessage("是否取消上传视频？");
                                askDialog.setCancleListener("我点错了", new View.OnClickListener() {
                                    @Override
                                    public void onClick(View v) {
                                        askDialog.dismiss();
                                        if(mUploadTask != null){
                                            mProgressDialog.show();
                                        }
                                    }
                                });
                                askDialog.setSubmitListener("取消上传", new View.OnClickListener() {
                                    @Override
                                    public void onClick(View v) {
                                        mProgressDialog.dismiss();
                                        if (mUploadTask != null) {
                                            mUploadTask.cancel();
                                            mUploadTask = null;
                                        }
                                        askDialog.dismiss();
                                    }
                                });
                                askDialog.show();
                            }
                        }
                    });
                    mProgressDialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
                        @Override
                        public void onDismiss(DialogInterface dialog) {

                        }
                    });
                }
                mUploadTask = ApiManager.uploadVideo(file, new Callback.ProgressCallback<String>() {
                    @Override
                    public void onWaiting() {
                    }

                    @Override
                    public void onStarted() {
                        mProgressDialog.show();
                    }

                    @Override
                    public void onLoading(long total, long current, boolean isDownloading) {
                        if (!isDownloading) {
                            // 如果不是下载，则代表上传
                            total = total / 1024;    // KB为单位
                            current = current / 1024;// KB为单位
                            mProgressDialog.setMax((int) total);
                            mProgressDialog.setProgress((int) current);
                        }
                        com.linzi.xiguwen.utils.LogUtil.i("SystemOut", String.valueOf("进度：" + total + " ->  " + current + " : " + isDownloading));
                    }

                    @Override
                    public void onSuccess(String result) {
                        // 上传成功，进行提交表单
                        Gson gson = new Gson();
                        BaseBean bean = gson.fromJson(result, BaseBean.class);
                        if (bean.getCode() == 0) {
                            //上传成功
                            mVideoPath = bean.getData();
                            submitOrder(mVideoPath);
                        }else{
                            NToast.show(bean.getMessage());
                        }
                    }

                    @Override
                    public void onError(Throwable ex, boolean isOnCallback) {
                        com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                        NToast.show("上传失败");
                    }

                    @Override
                    public void onCancelled(CancelledException cex) {
                        NToast.show("取消上传");
                    }

                    @Override
                    public void onFinished() {
                        mUploadTask = null;
                        mProgressDialog.dismiss();
                    }
                });
            }
        }
    }

    // 提交表单
    public void submitOrder(String videoUrl) {
        if(mData == null){
            MsgLoadDialog.showDialog(this, "保存中...");
            ApiManager.addVideo(mFengMianPath, edName.getText().toString().trim(), videoUrl, (int) Float.parseFloat(edWeight.getText().toString().trim()), new OnRequestFinish<com.linzi.xiguwen.net.base.BaseBean<String>>() {
                @Override
                public void onFinished() {
                    MsgLoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(com.linzi.xiguwen.net.base.BaseBean<String> data) {
                    NToast.show("添加成功");
                    setResult(RESULT_OK);
                    finish();
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show(ex.getMessage());
                    com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                }
            });
        }else{
            MsgLoadDialog.showDialog(this, "保存中...");
            ApiManager.editVideo(mData.getId(), mFengMianPath, edName.getText().toString().trim(), videoUrl, (int) Float.parseFloat(edWeight.getText().toString().trim()), new OnRequestFinish<com.linzi.xiguwen.net.base.BaseBean<String>>() {
                @Override
                public void onFinished() {
                    MsgLoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(com.linzi.xiguwen.net.base.BaseBean<String> data) {
                    NToast.show("添加成功");
                    setResult(RESULT_OK);
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

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 121 && resultCode == RESULT_OK) {
            File photoFile = new File(path_1);
            if (photoFile.exists()) {
                GlideLoad.GlideLoadImg(mContext, path_1 + "/" + img_name, ivFengmian);
                mFengMianPath = path_1 + "/" + img_name;
            } else {
                NToast.show("照片保存失败");
            }
        }
    }


    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.WRITE_EXTERNAL_STORAGE,Permission.CAMERA)
                .request(new OnPermissionCallback() {
            @Override
            public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                if (!allGranted){
                    FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(AddVideoActivity.this);
                    commonPopWindow.showAtLocation(edName, Gravity.CENTER, 0, 0);
                    commonPopWindow.getTitText().setText(getResources().getString(R.string.per_picture));
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
                    ToastUtils.showToast(AddVideoActivity.this,"被永久拒绝授权，请手动存储权限");
                    // 如果是被永久拒绝就跳转到应用权限系统设置页面
                    XXPermissions.startPermissionActivity(AddVideoActivity.this, permissions);
                } else {
                    ToastUtils.showToast(AddVideoActivity.this,"获取存储权限失败");
                }
            }
        });

    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(edName, Gravity.BOTTOM, 0, 0);
        if (type == 124){
            ((LinearLayout)  selectPhotoTypePop.getTake_photo().getParent()).setVisibility(View.GONE);
            selectPhotoTypePop.getChose_pic().setText("选择视频");
        }
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector pictureSelector = PictureSelector.create(this);
            PictureSelectionModel pictureSelectionModel;
            if (type == 123){
                pictureSelectionModel = pictureSelector.openGallery(SelectMimeType.ofImage());
            }
            if (type == 124){
                pictureSelectionModel = pictureSelector.openGallery(SelectMimeType.ofVideo());
            }else {
                pictureSelectionModel = pictureSelector.openGallery(SelectMimeType.ofImage());
            }
            pictureSelectionModel.setMaxSelectNum(1)
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
                            selectPhotoTypePop.dismiss();
                            PictureSelector pictureSelector = PictureSelector.create(AddVideoActivity.this);
                            PictureSelectionModel pictureSelectionModel;
                            pictureSelectionModel = pictureSelector.openGallery(SelectMimeType.ofImage());
                            pictureSelectionModel
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
                                            if (type == 123){
                                                String availablePath = path.get(0).getAvailablePath();
                                                if (availablePath.startsWith("content://")){
                                                    availablePath = path.get(0).getRealPath();
                                                }
                                                path_1 = availablePath;
                                                mFengMianPath = path_1;
                                                GlideLoad.GlideLoadImg(mContext, path_1, ivFengmian);
                                            }
                                            if (type == 124){
                                                String availablePath = path.get(0).getAvailablePath();
                                                if (availablePath.startsWith("content://")){
                                                    availablePath = path.get(0).getRealPath();
                                                }
                                                mVideoPath = availablePath;
                                                GlideLoad.GlideLoadImgVideoFirstFrame(mContext,Uri.parse(path.get(0).getAvailablePath()),ivVadio);

                                            }
                                        }
                                        @Override
                                        public void onCancel() {

                                        }
                                    });
                        }
                        @Override
                        public void onCancel() {

                        }
                    });
        });
        selectPhotoTypePop.getChose_pic().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector pictureSelector = PictureSelector.create(this);
            PictureSelectionModel pictureSelectionModel;
            if (type == 123){
                 pictureSelectionModel = pictureSelector.openGallery(SelectMimeType.ofImage());
            }
            if (type == 124){
                pictureSelectionModel = pictureSelector.openGallery(SelectMimeType.ofVideo());
            }else {
                pictureSelectionModel = pictureSelector.openGallery(SelectMimeType.ofImage());
            }
            pictureSelectionModel
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
                            if (type == 123){
                                String availablePath = path.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = path.get(0).getRealPath();
                                }
                                path_1 = availablePath;
                                mFengMianPath = path_1;
                                GlideLoad.GlideLoadImg(mContext, path_1, ivFengmian);
                            }
                            if (type == 124){
                                String availablePath = path.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = path.get(0).getRealPath();
                                }
                                mVideoPath = availablePath;
                                GlideLoad.GlideLoadImgVideoFirstFrame(mContext,Uri.parse(path.get(0).getAvailablePath()),ivVadio);
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
    
    

    @OnClick({R.id.ll_choose_fengmian, R.id.ll_choose_vadio, R.id.ll_save})
    public void onClick(View view) {
        hideKeyboard(view);
        switch (view.getId()) {
            case R.id.ll_choose_fengmian:
                showPop(123);
                break;
            case R.id.ll_choose_vadio:
                showPop(124);
                break;
            case R.id.ll_save:
                if(check()){
                    uploadImg();
                }
                break;
        }
    }

    /**
     * 获取视频的缩略图
     * 先通过ThumbnailUtils来创建一个视频的缩略图，然后再利用ThumbnailUtils来生成指定大小的缩略图。
     * 如果想要的缩略图的宽和高都小于MICRO_KIND，则类型要使用MICRO_KIND作为kind的值，这样会节省内存。
     *
     * @param videoPath 视频的路径
     * @param width     指定输出视频缩略图的宽度
     * @param height    指定输出视频缩略图的高度度
     * @param kind      参照MediaStore.Images.Thumbnails类中的常量MINI_KIND和MICRO_KIND。
     *                     其中，MINI_KIND: 512 x 384，MICRO_KIND: 96 x 96
     * @return 指定大小的视频缩略图
     */
//    private Bitmap getVideoThumbnail(String videoPath, int width, int height, int kind) {
//        Bitmap bitmap = null;
//        // 获取视频的缩略图
//        bitmap = ThumbnailUtils.createVideoThumbnail(videoPath, kind);
//        com.linzi.xiguwen.utils.LogUtil.i("SystemOut", String.valueOf("w" + bitmap.getWidth()));
//        com.linzi.xiguwen.utils.LogUtil.i("SystemOut", String.valueOf("h" + bitmap.getHeight()));
//        bitmap = ThumbnailUtils.extractThumbnail(bitmap, width, height, ThumbnailUtils.OPTIONS_RECYCLE_INPUT);
//        return bitmap;
//    }

    public Bitmap getVideoThumbnail(String videoPath,int with ,int height,int kind ) {
        Bitmap firstFrame = null;
        MediaMetadataRetriever retriever = new MediaMetadataRetriever();
        try {
            // 设置视频文件路径
            retriever.setDataSource(videoPath, new HashMap<String, String>());
            // 获取视频的首帧图片
             firstFrame = retriever.getFrameAtTime(0); // 参数为微秒，0表示第一帧
             firstFrame = scaleBitmap(firstFrame,with,height);
        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        } finally {
            try {
                retriever.release(); // 释放资源
            } catch (Exception e) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
            }
        }

        return firstFrame;
    }

    /**
     * 缩放Bitmap到指定尺寸
     *
     * @param bitmap    要缩放的Bitmap对象
     * @param newWidth  新的宽度
     * @param newHeight 新的高度
     * @return 缩放后的Bitmap对象，如果缩放失败则返回null
     */
    public static Bitmap scaleBitmap(Bitmap bitmap, int newWidth, int newHeight) {
        if (bitmap == null) {
            return null;
        }

        int width = bitmap.getWidth();
        int height = bitmap.getHeight();

        // 计算缩放比例
        float scaleWidth = ((float) newWidth) / width;
        float scaleHeight = ((float) newHeight) / height;

        // 创建缩放后的Bitmap对象
        Bitmap scaledBitmap = Bitmap.createScaledBitmap(bitmap, newWidth, newHeight, false);

        return scaledBitmap;
    }




    @Override
    public void onBackPressed() {
        if(mUploadTask != null){
            mUploadTask.cancel();
            mUploadTask = null;
        }
        super.onBackPressed();
    }
}

package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AddAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.AtlasDetailBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GetSysCaptureUtils;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.ImgCompressUtils;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.PopChooserUtils;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
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

public class AddTuCeActivity extends BaseActivity {


    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.ed_weight)
    EditText edWeight;
    @BindView(R.id.ed_description)
    EditText edDescription;
    @BindView(R.id.iv_fengmian)
    ImageView ivFengmian;
    @BindView(R.id.ll_choose_fengmian)
    LinearLayout llChooseFengmian;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    private AddAdapter mAdapter;
    ArrayList<String> path = new ArrayList<>();

    // /storage/emulated/0/pic
    public final String SAVED_IMAGE_PATH1= Environment.getExternalStorageDirectory()+"/bytc/img";//+"/pic";
    private String img_name;
    String path_1;

    AtlasDetailBean mData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_tuce);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (AtlasDetailBean) getIntent().getSerializableExtra("data");
        if(mData != null){
            setTitle("编辑图册");
        }else{
            setTitle("添加图册");
        }
        setBack();

        GridLayoutManager manager = new GridLayoutManager(mContext, 3) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter = new AddAdapter(mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                showPop(1002);
            }
        }, new CallBack.ImgClickListener() {
            @Override
            public void imgListener(int id) {
                path.remove(id);
                mAdapter.notifyDataSetChanged();
            }
        }, path, 1);
        recycle.setAdapter(mAdapter);

        refreshData(mData);
    }


    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.CAMERA)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(AddTuCeActivity.this);
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
                            ToastUtils.showToast(AddTuCeActivity.this,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(AddTuCeActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(AddTuCeActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        int num = type == 123?1:9-path.size();
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(edName, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(AddTuCeActivity.this)
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
                            if (type == 1002){
                                for (int i = 0; i < result.size(); i++) {
                                    String availablePath = result.get(i).getAvailablePath();
                                    if (availablePath.startsWith("content://")){
                                        availablePath = result.get(i).getRealPath();
                                    }
                                    path.add(availablePath);
                                }
                                NToast.log("size=====", "" + path.size());
                                mAdapter.notifyDataSetChanged();
                            }
                            if (type == 123){
                                String availablePath = result.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = result.get(0).getRealPath();
                                }
                                path_1 = availablePath;
                                GlideLoad.GlideLoadImg(mContext,path_1,ivFengmian);
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
                    .setMaxSelectNum(num)
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
                            if (type == 1002){
                                for (int i = 0; i < result.size(); i++) {
                                    path.add(result.get(i).getAvailablePath());
                                }
                                NToast.log("size=====", "" + path.size());
                                mAdapter.notifyDataSetChanged();
                            }
                            if (type == 123){
                                String availablePath = result.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = result.get(0).getRealPath();
                                }
                                path_1 = availablePath;
                                GlideLoad.GlideLoadImg(mContext,path_1,ivFengmian);
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


    private void refreshData(AtlasDetailBean data) {
        if(data != null){
            edName.setText(data.getName());
            edWeight.setText(data.getWeight() + "");
            edDescription.setText(data.getSynopsis());
            GlideLoad.GlideLoadImg(this, data.getCover(), ivFengmian);
            path_1 = data.getCover();
            path.clear();
            if(data.getPhotourl() != null){
                for (AtlasDetailBean.PhotoBean photoBean : data.getPhotourl()) {
                    path.add(photoBean.getPhoto());
                }
            }
            mAdapter.notifyDataSetChanged();
        }
    }

    private boolean check(){
        if(TextUtils.isEmpty(edName.getText().toString().trim())){
            NToast.show("图册名称不能为空");
            return false;
        }
        if(TextUtils.isEmpty(edWeight.getText().toString().trim())){
            NToast.show("排序不能为空");
            return false;
        }else{
            try {
                Float.parseFloat(edWeight.getText().toString().trim());
            } catch (Exception e) {
                NToast.show("排序格式有误");
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                return false;
            }
        }
        if(TextUtils.isEmpty(edDescription.getText().toString().trim())){
            NToast.show("图册描述不能为空");
            return false;
        }
        if(TextUtils.isEmpty(path_1)){
            NToast.show("请设置图册封面");
            return false;
        }
        return true;
    }

    //添加图册
    boolean flag; //上传图片的状态
    int finishCount; //上传完成的数量
    private void addAtlas(){
        MsgLoadDialog.showDialog(this, "保存中...");
        //上传图片
        final List<String> uploadFiles = new ArrayList<>();
        if(!path_1.toLowerCase().startsWith("http")){
            uploadFiles.add(path_1);
        }
        for (String p : path) {
            if(!p.toLowerCase().startsWith("http")){
                uploadFiles.add(p);
            }
        }

        final int uploadFileCount = uploadFiles.size();
        if(uploadFileCount == 0){
            submitOrder();
            return;
        }
        finishCount = 0;
        flag = true;
        MsgLoadDialog.updateMsg("上传图片中...");


        new Thread(){
            @Override
            public void run() {
                super.run();
                for (final String uploadFile : uploadFiles) {
                    ApiManager.uploadImgBase64(ImgCompressUtils.getBase64StrWithHead(uploadFile), new OnRequestFinish<BaseBean<String>>() {
                        @Override
                        public void onFinished() {
                            finishCount ++ ;
                            if(finishCount == uploadFileCount){
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        if(flag){
                                            //提交表单
                                            submitOrder();
                                        }else{
                                            NToast.show("上传文件失败");
                                            MsgLoadDialog.CancelDialog();
                                        }
                                    }
                                });
                            }
                        }

                        @Override
                        public void onSuccess(BaseBean<String> data) {
                            if(uploadFile.equals(path_1)){
                                path_1 = data.getData();
                            }
                            if(path.contains(uploadFile)){
                                path.remove(uploadFile);
                                path.add(data.getData());
                            }
                        }

                        @Override
                        public void onError(Exception ex) {
                            flag = false;
                            com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                        }
                    });
                }
            }
        }.start();
    }

    private void submitOrder() {
        MsgLoadDialog.updateMsg("保存中...");
        if(mData == null){
            ApiManager.addAtlas(path_1, edName.getText().toString().trim(), path, edDescription.getText().toString().trim(), edWeight.getText().toString().trim(), new OnRequestFinish<BaseBean<String>>() {
                @Override
                public void onFinished() {
                    MsgLoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean<String> data) {
                    NToast.show(data.getMessage());
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
            //编辑
            ApiManager.editAtlas(mData.getId(), path_1, edName.getText().toString().trim(), path, edDescription.getText().toString().trim(), edWeight.getText().toString().trim(), new OnRequestFinish<BaseBean<String>>() {
                @Override
                public void onFinished() {
                    MsgLoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean<String> data) {
                    NToast.show(data.getMessage());
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
       if (requestCode==121&&resultCode== RESULT_OK){
            File photoFile=new File(path_1);
            if (photoFile.exists()){
                GlideLoad.GlideLoadImg(mContext,path_1+"/"+img_name,ivFengmian);
            }else {
                NToast.show("照片保存失败");
            }
        }
    }

    @OnClick({R.id.ll_choose_fengmian, R.id.ll_save})
    public void onClick(View view) {
        switch (view.getId()){
            case R.id.ll_choose_fengmian:
                 showPop(123);
                break;
            case R.id.ll_save:
                if(check()){
                    addAtlas();
                }
                break;
        }
    }

}

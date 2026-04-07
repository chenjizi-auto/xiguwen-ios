package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.EditText;
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
import com.linzi.xiguwen.bean.BaoJiaDetailBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.ImgCompressUtils;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.basic.PictureSelector;
import com.luck.picture.lib.config.SelectMimeType;
import com.luck.picture.lib.engine.CompressFileEngine;
import com.luck.picture.lib.entity.LocalMedia;
import com.luck.picture.lib.interfaces.OnResultCallbackListener;
import com.luck.picture.lib.utils.ToastUtils;

import org.xutils.common.Callback;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnNewCompressListener;

public class AddBaojiaActivity extends BaseActivity {

    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.ed_price)
    EditText edPrice;       // 报价价格
    @BindView(R.id.ed_dingjing)
    EditText edDingjing;    //报价定金
    @BindView(R.id.ed_zhekou)
    EditText edZhekou;      //报价折扣
    @BindView(R.id.ed_weight)
    EditText edWeight;      //权重
    @BindView(R.id.ed_ps)
    EditText etPs;      //备注
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.ll_save)
    LinearLayout llSave;

    private BaoJiaDetailBean mData;

    private AddAdapter mAdapter;
    ArrayList<String> path = new ArrayList<>();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_baojia);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (BaoJiaDetailBean) getIntent().getSerializableExtra("data");
        if(mData == null){
            setTitle("添加报价");
        }else{
            setTitle("编辑报价");
        }
        setBack();

        GridLayoutManager manager=new GridLayoutManager(mContext,3){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter=new AddAdapter(mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
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
        },path,1);
        recycle.setAdapter(mAdapter);

        refreshData(mData);
    }

    private void refreshData(BaoJiaDetailBean data){
        if(data != null){
            edName.setText(data.getName());
            edPrice.setText(data.getPrice());
            edDingjing.setText(data.getTemporarypay());
            edWeight.setText(data.getWeigh() + "");
            edZhekou.setText(data.getDeductible());
            path.clear();
            if(data.getImglist() != null){
                for (BaoJiaDetailBean.Photo photo : data.getImglist()) {
                    path.add(photo.getPhoto());
                }
                mAdapter.notifyDataSetChanged();
            }
        }
    }




    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.CAMERA,Permission.MANAGE_EXTERNAL_STORAGE)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(AddBaojiaActivity.this);
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
                            ToastUtils.showToast(AddBaojiaActivity.this,"被永久拒绝授权，请手动授予相机权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(AddBaojiaActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(AddBaojiaActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(edName, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(AddBaojiaActivity.this)
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
                            for (int i = 0; i < result.size(); i++) {
                                String availablePath = result.get(i).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = result.get(i).getRealPath();
                                }
                                path.add(availablePath);
                            }
                            mAdapter.notifyDataSetChanged();
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
                    .setMaxSelectNum(9-path.size())
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
                            for (int i = 0; i < result.size(); i++) {
                                String availablePath = result.get(i).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = result.get(i).getRealPath();
                                }
                                path.add(availablePath);
                            }
                            mAdapter.notifyDataSetChanged();
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


    @OnClick({R.id.ll_save})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_save:
                if(check()){
                    uploadImage();
                }
                break;
        }
    }

    private boolean check(){
        if(TextUtils.isEmpty(edName.getText().toString().trim())){
            NToast.show("报价名称不能为空");
            return false;
        }
        if(TextUtils.isEmpty(edPrice.getText().toString().trim())){
            NToast.show("报价价格不能为空");
            return false;
        }else{
            if(parseFloat(edPrice.getText().toString().trim()) < 0){
                NToast.show("报价价格格式不正确");
                return false;
            }
        }
        if(TextUtils.isEmpty(edDingjing.getText().toString().trim())){
            NToast.show("定金金额不能为空");
            return false;
        }else{
            if(parseFloat(edDingjing.getText().toString().trim()) < 0){
                NToast.show("定金金额格式不正确");
                return false;
            }
        }
        if(TextUtils.isEmpty(edZhekou.getText().toString().trim())){
            NToast.show("折扣金额不能为空");
            return false;
        }else{
            if(parseFloat(edZhekou.getText().toString().trim()) < 0){
                NToast.show("折扣金额格式不正确");
                return false;
            }
        }
        if(TextUtils.isEmpty(edWeight.getText().toString().trim())){
            NToast.show("排序不能为空");
            return false;
        }else{
            try {
                Float.parseFloat(edWeight.getText().toString().trim());
            } catch (Exception e) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                NToast.show("排序格式不正确");
                return false;
            }
        }

        return true;
    }

    private float parseFloat(String str){
        try {
            return Float.parseFloat(str);
        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
            return -1;
        }
    }

    //上传图片
    boolean flag; //上传图片的状态
    int finishCount; //上传完成的数量
    Callback.Cancelable cancelable;
    private void uploadImage(){
        MsgLoadDialog.showDialog(mContext, "保存中...");

        //上传文件
        int cacheSize = 0;
        for (String s : path) {
            if(!s.toLowerCase().startsWith("http")){
                cacheSize ++;
            }
        }
        final int uploadFileCount = cacheSize;
        flag = true;
        finishCount = 0;
        if(uploadFileCount == 0){
            submitOrder();
            return;
        }

//        cancelable = ApiManager.uploadImgBase64s(path,new UploadUtils.OnUploadListener<String>() {
//            @Override
//            public void onItemStart(int count, int current) {
//                MsgLoadDialog.updateMsg(String.format("上传图片中（%d/%d）", count, current));
//            }
//
//            @Override
//            public void onErr(int count, int current, Throwable ex) {
//                MsgLoadDialog.CancelDialog();
//                NToast.show("上传图片失败");
//            }
//
//            @Override
//            public void onItemSuccess(int count, int current, BaseBean<String> baseBean) {
//                path.remove(current - 1);
//                path.add(baseBean.getData());
//            }
//
//            @Override
//            public void onAllFinish() {
//                cancelable = null;
//                MsgLoadDialog.updateMsg("保存中...");
//                addGrade();
//            }
//
//            @Override
//            public void onCancel() {
//                MsgLoadDialog.CancelDialog();
//                NToast.show("取消上传");
//            }
//        });

        MsgLoadDialog.updateMsg("上传图片中");
        for (final String uploadFile : path) {
            if(uploadFile.toLowerCase().startsWith("http")){
                continue;
            }
            ApiManager.uploadImgBase64(ImgCompressUtils.getBase64StrWithHead(uploadFile), new OnRequestFinish<BaseBean<String>>() {
                @Override
                public void onFinished() {
                    finishCount ++ ;
                    if(finishCount == uploadFileCount){
                        if(flag){
                            //提交表单
                            submitOrder();
                        }else{
                            NToast.show("上传文件失败");
                            MsgLoadDialog.CancelDialog();
                        }
                    }
                }

                @Override
                public void onSuccess(BaseBean<String> data) {
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


    private void submitOrder(){
        MsgLoadDialog.updateMsg("保存中...");
        float zhekou = parseFloat(edZhekou.getText().toString().trim());
        float baojia = parseFloat(edPrice.getText().toString().trim());
        float dingjing = parseFloat(edDingjing.getText().toString().trim());
        float quanzhong = parseFloat(edWeight.getText().toString().trim());
        String ps = etPs.getText().toString().trim();

        if(mData == null){
            ApiManager.addBaoJia(zhekou, baojia, edName.getText().toString().trim(), dingjing, quanzhong, path,ps, new OnRequestFinish<BaseBean<String>>() {
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
                }
            });
        }else{
            ApiManager.editBaoJia(mData.getQuotationid(), zhekou, baojia, edName.getText().toString().trim(), dingjing, quanzhong, path, new OnRequestFinish<BaseBean<String>>() {
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
                }
            });
        }
    }
}

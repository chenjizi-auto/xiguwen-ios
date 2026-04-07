package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.TextView;

import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AddAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.RenZhengSubmitInfoBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.ImgCompressUtils;
import com.linzi.xiguwen.utils.LoadDialog;
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

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnNewCompressListener;

public class ToRenZhengActivity extends BaseActivity {

    public static final int TYPE_SUBMIT = 0x00;  // 初始化提交
    public static final int TYPE_WATCH = 0x05;   // 查看资料
    public static final int TYPE_RESUBMIT = 0x10;// 重新提交

    @BindView(R.id.ed_context)
    EditText edContext;
    @BindView(R.id.tv_msg)
    TextView tvMsg;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    ArrayList<String> path = new ArrayList<>();
    AddAdapter mADapter;
    private int mType;
    private int mId;
    private RenZhengSubmitInfoBean mData;

    public static void startActivity(Context context, String title, int id, int type){
        Intent intent = new Intent(context, ToRenZhengActivity.class);
        intent.putExtra("id", id);
        intent.putExtra("type", type);
        intent.putExtra("title", title);
        context.startActivity(intent);
    }

    public static void startActivityForResult(Fragment fragment, String title, int id, int type, int request){
        Intent intent = new Intent(fragment.getContext(), ToRenZhengActivity.class);
        intent.putExtra("id", id);
        intent.putExtra("type", type);
        intent.putExtra("title", title);
        fragment.startActivityForResult(intent, request);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_to_ren_zheng);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mId = getIntent().getIntExtra("id", -1);
        String title = getIntent().getStringExtra("title");
        setTitle(title == null ? "提交资料" : title);
        setBack();
        if(mId == -1){
            NToast.show("参数错误！");
            finish();
        }
        mType = getIntent().getIntExtra("type", TYPE_SUBMIT);
        if(mType == TYPE_SUBMIT || mType == TYPE_RESUBMIT){
            setRight("提交", new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    uploadImg();
                }
            });
        }

        GridLayoutManager manager = new GridLayoutManager(mContext, 3){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        com.linzi.xiguwen.utils.LogUtil.e("AddAdapter","---------mType---"+mType);
        mADapter = new AddAdapter(mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                showPop(1002);
            }
        }, new CallBack.ImgClickListener() {
            @Override
            public void imgListener(int id) {
                path.remove(id);
                mADapter.notifyDataSetChanged();
            }
        }, path,mType);
        recycle.setAdapter(mADapter);

        if(mType != TYPE_SUBMIT){
            getRenZhengSubmitInfo();
        }

        if (mType == TYPE_WATCH){
            edContext.setEnabled(false);
            tvMsg.setText("已上传资料");
        }else {
            tvMsg.setText("请将您的线下认证合格证书拍照上传");
        }
    }

    /**
     * 上传图片
     */
    boolean flag; //上传图片的状态
    int finishCount; //上传完成的数量
    private void uploadImg() {
        MsgLoadDialog.showDialog(this, "提交中...");
        List<String> uploadFile = new ArrayList<>();
        for (String p : path) {
            if(!p.toLowerCase().startsWith("http")){
                uploadFile.add(p);
            }
        }
        final int uploadCount = uploadFile.size();
        if(uploadCount == 0){
            if(mType == TYPE_SUBMIT){
                submitRenZhengInfo();
            }else{
                resubmitRenZhengInfo();
            }
        }else{
            MsgLoadDialog.updateMsg("上传图片中...");
            flag = true;
            finishCount = 0;
            for (String file : uploadFile) {
                ApiManager.uploadImgBase64(ImgCompressUtils.getBase64StrWithHead(file), new OnRequestFinish<BaseBean<String>>() {
                    @Override
                    public void onFinished() {
                        finishCount ++;
                        if(uploadCount == finishCount){
                            Iterator<String> iterator = path.iterator();
                            List<String> httpPath = new ArrayList<>();
                            while (iterator.hasNext()){
                                String next = iterator.next();
                                if (next.startsWith("http")){
                                    httpPath.add(next);
                                }
                            }
                            path.clear();
                            path.addAll(httpPath);
                            if(flag){
                                if(mType == TYPE_SUBMIT){
                                    submitRenZhengInfo();
                                }else{
                                    resubmitRenZhengInfo();
                                }
                            }else{
                                NToast.show("上传图片失败，请重试");
                                MsgLoadDialog.CancelDialog();
                            }
                        }
                    }

                    @Override
                    public void onSuccess(BaseBean<String> data) {
                        if(path.contains(data.getData())){
                            int index = path.indexOf(data.getData());
                            path.remove(index);
                            path.add(index, data.getData());
                        } else {
                            path.add(data.getData());
                        }
                    }

                    @Override
                    public void onError(Exception ex) {
                        flag = false;
                    }
                });
            }
        }

    }

    //回显认证资料
    private void getRenZhengSubmitInfo(){
        LoadDialog.showDialog(this);
        ApiManager.getRenZhengSubmitInfo(mId, new OnRequestFinish<BaseBean<RenZhengSubmitInfoBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<RenZhengSubmitInfoBean> data) {
                mData = data.getData();
                edContext.setText(mData.getVideo_url());
                path.clear();
                path.addAll(mData.getR_data());
                mADapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    // 提交认证信息
    private void submitRenZhengInfo(){
        String text = edContext.getText().toString();
        if (TextUtils.isEmpty(text)){
            NToast.show("请输入信息！");
            MsgLoadDialog.CancelDialog();
            return;
        }
        MsgLoadDialog.updateMsg("提交中...");
        String _path = null;
        for (String s : path) {
            if(_path == null){
                _path = s;
            }else{
                _path = _path + "," + s;
            }
        }


        ApiManager.submitRenZhengInfo(mId, _path, text, new OnRequestFinish<BaseBean<String>>() {
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

    // 重新提交认证信息
    private void resubmitRenZhengInfo(){
        String text = edContext.getText().toString();
        if (TextUtils.isEmpty(text)){
            NToast.show("请输入信息！");
            MsgLoadDialog.CancelDialog();
            return;
        }
        MsgLoadDialog.updateMsg("提交中...");
        String _path = null;
        for (String s : path) {
            if(_path == null){
                _path = s;
            }else{
                _path = _path + "," + s;
            }
        }
        ApiManager.reSubmitRenZhengInfo(mData.getDid(), mId, _path, edContext.getText().toString().trim(), new OnRequestFinish<BaseBean<String>>() {
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

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }


    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.CAMERA)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(ToRenZhengActivity.this);
                            commonPopWindow.showAtLocation(edContext, Gravity.CENTER, 0, 0);
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
                            ToastUtils.showToast(ToRenZhengActivity.this,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(ToRenZhengActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(ToRenZhengActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(edContext, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(ToRenZhengActivity.this)
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
                                    path.add(result.get(i).getAvailablePath());
                                }
                                NToast.log("size=====", "" + path.size());
                                mADapter.notifyDataSetChanged();
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
                            if (type == 1002){
                                for (int i = 0; i < result.size(); i++) {
                                    path.add(result.get(i).getAvailablePath());
                                }
                                NToast.log("size=====", "" + path.size());
                                mADapter.notifyDataSetChanged();
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

}

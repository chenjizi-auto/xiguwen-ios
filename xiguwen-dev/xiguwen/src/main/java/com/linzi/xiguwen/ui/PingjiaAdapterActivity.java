package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;

import com.hedgehog.ratingbar.RatingBar;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AddAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
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
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnCompressListener;
import top.zibin.luban.OnNewCompressListener;

public class PingjiaAdapterActivity extends BaseActivity {

    @BindView(R.id.ratingbar)
    RatingBar ratingbar;
    @BindView(R.id.tv_score)
    TextView tvScore;
    @BindView(R.id.ed_context)
    EditText edContext;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.rb_check)
    CheckBox rbCheck;

    ArrayList<String> path = new ArrayList<>();
    AddAdapter mADapter;

    private int intentType;
    private float ratingCount;
    private int order_id;
    private List<String> pictures;
    private StringBuffer imgstr = new StringBuffer();

    private List<String> imglist = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pingjia_adapter);
        ButterKnife.bind(this);
        intentType = getIntent().getIntExtra("intentType", -1);
        order_id = getIntent().getIntExtra("order_id", -1);
    }

    @Override
    protected void initData() {
        setTitle("发布评价");
        setBack();
        setRight("发布", new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                if (!TextUtils.isEmpty(edContext.getText().toString()) && ratingCount > 0) {
                    switch (intentType) {
                        case 0:
                            postWeddingPingJia();
                            break;
                        case 1:
                            postMallPingJia();
                            break;
                        case 2:

                            break;
                        case 3:
                            break;
                    }
                } else {
                    NToast.show("完善评价再发布哦！~");
                }
            }
        });
        GridLayoutManager manager = new GridLayoutManager(mContext, 3);
        recycle.setLayoutManager(manager);

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
                imglist.remove(id);
            }
        }, path, 1);
        recycle.setAdapter(mADapter);

        ratingbar.setOnRatingChangeListener(new RatingBar.OnRatingChangeListener() {
            @Override
            public void onRatingChange(float RatingCount) {
                tvScore.setText(RatingCount + "分");
                ratingCount = RatingCount;
            }
        });


    }
    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.CAMERA)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(PingjiaAdapterActivity.this);
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
                            ToastUtils.showToast(PingjiaAdapterActivity.this,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(PingjiaAdapterActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(PingjiaAdapterActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        int max = 9-path.size();
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(edContext, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setVisibility(View.GONE);
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
                            for (int i = 0; i < result.size(); i++) {
                                String availablePath = result.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = result.get(0).getRealPath();
                                }
                                path.add(availablePath);
                                uploadImage(new File(availablePath));
                            }
                            mADapter.notifyDataSetChanged();
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
    public void onBackPressed() {
//        super.onBackPressed();
        final AskDialog dialog = new AskDialog(mContext, PingjiaAdapterActivity.this);
        dialog.setTitle("系统提示");
        dialog.setMessage("确认取消发布评论吗？");
        dialog.setCancleListener("取消", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener("确定", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                finish();
            }
        });
        dialog.show();
    }

    //婚庆发布评论
    private void postWeddingPingJia() {
        if (imglist != null && imglist.size() > 0) {
            imgstr.setLength(0);
            for (int i = 0; i < imglist.size(); i++) {
                imgstr.append(imglist.get(i) + ",");
            }
        }
        String imgurl = null;
        if (imgstr.toString().endsWith(",")) {
            imgurl = imgstr.subSequence(0, imgstr.length() - 1).toString();
        }
        LoadDialog.showDialog(mContext);
        int anonymous = -1;
        if (rbCheck.isChecked()) {
            anonymous = 2;
        } else {
            anonymous = 1;
        }
        ApiManager.addWeddingPingJia(anonymous, edContext.getText().toString(), order_id, imgurl, ratingCount, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //商城发布评论
    private void postMallPingJia() {
        if (imglist != null && imglist.size() > 0) {
            imgstr.setLength(0);
            for (int i = 0; i < imglist.size(); i++) {
                imgstr.append(imglist.get(i) + ",");
            }
        }
        String imgurl = null;
        if (imgstr.toString().endsWith(",")) {
            imgurl = imgstr.subSequence(0, imgstr.length() - 1).toString();
        }
        LoadDialog.showDialog(mContext);
        int anonymous = -1;
        if (rbCheck.isChecked()) {
            anonymous = 2;
        } else {
            anonymous = 1;
        }
        ApiManager.addMallPingJia(anonymous, edContext.getText().toString(), order_id, imgurl, ratingCount, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }



    private String getPath() {
        String path = Environment.getExternalStorageDirectory() + "/boyi/image/compress";
        File file = new File(path);
        if (file.mkdirs()) {
            return path;
        }
        return path;
    }

    private void uploadImage(final File image) {
        if (image == null) {
            return;
        }
//        LoadDialog.showDialog(mContext);
        ApiManager.uploadImg(image,1, new OnRequestSubscribe<BaseBean<String>>() {
            @Override
            public void onSuccess(BaseBean<String> data) {
                LoadDialog.CancelDialog();
                imglist.add(data.getData());
                //GlideLoad.GlideLoadCircle(image.getAbsolutePath(), ivHeadImg);
//                UserEntity userEntity = new UserEntity();
//                userEntity.setHead(data.getData());
//                updateUserInfo(userEntity);
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }
}

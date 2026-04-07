package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.os.Environment;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

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
import com.linzi.xiguwen.bean.MallOrderDetailsBean;
import com.linzi.xiguwen.bean.MallTuiKuanInfoBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
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

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnNewCompressListener;

public class ShangchengOrderTuikuanActivity extends BaseActivity {


    @BindView(R.id.ed_context)
    EditText edContext;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.tv_tips)
    TextView tvTips;
    @BindView(R.id.tv_money)
    TextView tvMoney;
    @BindView(R.id.cb_agree)
    CheckBox cbAgree;
    @BindView(R.id.iv_img)
    ImageView ivImg;
    @BindView(R.id.tv_titles)
    TextView tvTitles;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.tv_order_status)
    TextView tvOrderStatus;
    @BindView(R.id.tv_danjia)
    TextView tvDanjia;
    @BindView(R.id.dingjintx)
    TextView dingjintx;
    @BindView(R.id.tv_dingjin)
    TextView tvDingjin;
    @BindView(R.id.dikoutext)
    TextView dikoutext;
    @BindView(R.id.tv_dikou)
    TextView tvDikou;
    @BindView(R.id.payyypetext)
    TextView payyypetext;
    @BindView(R.id.tv_pay_type)
    TextView tvPayType;
    @BindView(R.id.tv_num)
    TextView tvNum;
    @BindView(R.id.tv_tuikuanbtn)
    TextView tvTuikuanbtn;

    // ShangchengOrderAdapter.GoodsAdapter mAdpater;

    ArrayList<String> path = new ArrayList<>();
    AddAdapter mADapter;
    private MallOrderDetailsBean.DataBean.GoodsBean bean;

    private List<String> imglist = new ArrayList<>();
    private StringBuffer imgstr = new StringBuffer();

    private String tkPrice;//退款金额

    private boolean isTuiHuo;//标记是否退货
    private int type;//入口为待评价  0 仅退款  1退货退款

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_shangcheng_order_tuikuan);
        ButterKnife.bind(this);
        bean = getIntent().getParcelableExtra("bean");
        isTuiHuo = getIntent().getBooleanExtra("isTuiHuo", false);
        type = getIntent().getIntExtra("type", -1);
        if (bean != null) {
            GlideLoad.GlideLoadImg2(bean.getGoods_image(), ivImg);
            tvTitles.setText(bean.getGoods_name() + "");
            tvTime.setText(bean.getSpecification() + "");
            tvDanjia.setText(Constans.RMB + bean.getPrice());
            tvDingjin.setVisibility(View.GONE);
            dingjintx.setVisibility(View.GONE);
            tvPayType.setVisibility(View.GONE);
            tvNum.setText("" + bean.getQuantity());
            payyypetext.setVisibility(View.GONE);
            if (isTuiHuo) {
                getYiFaHuoData();
            } else {
                getData();
            }
        } else {
            finish();
            NToast.show("跳转失败，请重试！");
        }
    }

    @Override
    protected void initData() {
        setTitle("申请退款");
        setBack();
        setRight("提交", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isTruePost()) {
                    if (isTuiHuo) {
                        postYiFaHuoData();
                    } else {
                        postData();
                    }
                } else {
                    NToast.show("请先完善退款信息，再提交哦！~");
                }
            }
        });

//        LinearLayoutManager manager = new LinearLayoutManager(mContext) {
//            @Override
//            public boolean canScrollVertically() {
//                return false;
//            }
//        };
//        godosList.setLayoutManager(manager);
//
//        mAdpater = new ShangchengOrderAdapter(mContext).new GoodsAdapter();
//        godosList.setAdapter(mAdpater);

        GridLayoutManager manager2 = new GridLayoutManager(mContext, 3) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager2);

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
    }

    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.CAMERA)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(ShangchengOrderTuikuanActivity.this);
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
                            ToastUtils.showToast(ShangchengOrderTuikuanActivity.this,"被永久拒绝授权，请手动授予相机权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(ShangchengOrderTuikuanActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(ShangchengOrderTuikuanActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(edContext, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(ShangchengOrderTuikuanActivity.this)
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
                            String availablePath = path.get(0).getAvailablePath();
                            if (availablePath.startsWith("content://")){
                                availablePath = path.get(0).getRealPath();
                            }
                            uploadImage(new File(availablePath));
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
                    .setMaxSelectNum(3)
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
                            String availablePath = path.get(0).getAvailablePath();
                            if (availablePath.startsWith("content://")){
                                availablePath = path.get(0).getRealPath();
                            }
                            uploadImage(new File(availablePath));
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
    
    
    
    //校验提交是否符合条件
    private boolean isTruePost() {
        edContext.getText().toString();
        if (!edContext.getText().toString().equals("") && cbAgree.isChecked()) {
            return true;
        } else {
            return false;
        }
    }

    //提交退款申请 未发货
    private void postData() {
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
        ApiManager.postMallTuiKuan(imgurl, edContext.getText().toString().trim(), bean.getRec_id(), tkPrice, 1, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.toString());
            }
        });
    }

    //提交退款申请 已发货
    private void postYiFaHuoData() {
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
        if (type == 0) {
            LoadDialog.showDialog(mContext);
            ApiManager.postMallTuiKuanYiFaHuo(imgurl, edContext.getText().toString().trim(), bean.getRec_id(), tkPrice, 1, new OnRequestFinish<BaseBean>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean data) {
                    finish();
                    EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show(ex.toString());
                }
            });
        } else {
            LoadDialog.showDialog(mContext);
            ApiManager.postMallTuiKuanYiFaHuo(imgurl, edContext.getText().toString().trim(), bean.getRec_id(), tkPrice, 2, new OnRequestFinish<BaseBean>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean data) {
                    finish();
                    EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show(ex.toString());
                }
            });
        }
    }

    //获取退款金额 未发货
    private void getData() {
        LoadDialog.showDialog(mContext);
        ApiManager.getMallTuiKuanInfo(bean.getRec_id(), new OnRequestFinish<BaseBean<MallTuiKuanInfoBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MallTuiKuanInfoBean> data) {
                tkPrice = data.getData().getOrderinfo().getOrder_amount();
                tvTips.setText("最多可退" + tkPrice + "元");
                tvMoney.setText("￥" + tkPrice);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }


    //获取退款金额 已发货
    private void getYiFaHuoData() {
        LoadDialog.showDialog(mContext);
        ApiManager.getMallTuiKuanYiFaHuoInfo(bean.getRec_id(), new OnRequestFinish<BaseBean<MallTuiKuanInfoBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MallTuiKuanInfoBean> data) {
                tkPrice = data.getData().getOrderinfo().getOrder_amount();
                tvTips.setText("最多可退" + tkPrice + "元");
                tvMoney.setText("￥" + tkPrice);
            }

            @Override
            public void onError(Exception ex) {

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

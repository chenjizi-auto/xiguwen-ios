package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.annotation.NonNull;
import com.alibaba.fastjson.JSONArray;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.ClassificationBean;
import com.linzi.xiguwen.bean.MyDateBean;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.TypeSelectViewPop;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.CityBean;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;
import com.lljjcoder.citywheel.CityConfig;
import com.lljjcoder.style.citypickerview.CityPickerView;
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
import top.zibin.luban.OnCompressListener;
import top.zibin.luban.OnNewCompressListener;

public class CreateTeamActivity extends BaseActivity implements TypeSelectViewPop.TypeJobSelectListener {

    @BindView(R.id.iv_logo_img)
    ImageView ivLogoImg;
    @BindView(R.id.ll_choose_logo)
    LinearLayout llChooseLogo;
    @BindView(R.id.iv_bg_img)
    ImageView ivBgImg;
    @BindView(R.id.ll_choose_bg)
    LinearLayout llChooseBg;
    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.tv_type)
    TextView tvType;
    @BindView(R.id.ll_choose_type)
    LinearLayout llChooseType;
    @BindView(R.id.tv_area)
    TextView tvArea;
    @BindView(R.id.ll_choose_city)
    LinearLayout llChooseCity;
    @BindView(R.id.ed_address)
    EditText edAddress;
    @BindView(R.id.ed_context)
    EditText edContext;

    private String logPath;
    private String bgPath;

    private String address = "";
    private String provence = "";
    private String county = "";
    private String city = "";

    private String name;
    private String desc;
    private int type = 2;
    private ArrayList<MyDateBean> typeDatas = new ArrayList<>();
    private TypeSelectViewPop typeSelectViewPop;
    private final CityPickerView mPicker = new CityPickerView();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_team);
        ButterKnife.bind(this);
        mPicker.init(this);
    }

    @Override
    protected void initData() {
        setTitle("创建社团");
        setBack();
        setRight("保存", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                submit();
            }
        });

        try {
            String cls = Preferences.getString(Preferences.PROFESSIONAL);
            if (!AppUtil.isEmpty(cls)) {
                List<ClassificationBean> classificationBeans = JSONArray.parseArray(cls, ClassificationBean.class);
                if (!AppUtil.isEmpty(classificationBeans)) {
                    for (int i = 1; i < classificationBeans.size(); i++) {
                        MyDateBean myDateBean = new MyDateBean();
                        myDateBean.setDate(classificationBeans.get(i).getProname());
                        myDateBean.setId(classificationBeans.get(i).getOccupationid());
                        typeDatas.add(myDateBean);
                    }
                }
            }
        } catch (Exception e) {

        }


    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }

    @OnClick({R.id.ll_choose_logo, R.id.ll_choose_bg, R.id.ll_choose_type, R.id.ll_choose_city})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_choose_logo:
                showPop(1001);
                break;
            case R.id.ll_choose_bg:
                showPop(1002);
                break;
            case R.id.ll_choose_type:
                if (typeSelectViewPop == null) {
                    typeSelectViewPop = new TypeSelectViewPop(this);
                    typeSelectViewPop.setData(typeDatas);
                    typeSelectViewPop.setListener(this);

                }
                typeSelectViewPop.show(tvType);
                break;
            case R.id.ll_choose_city:
                selectCity();
                break;
        }
    }

    private void selectCity() {
        CityConfig cityConfig = new CityConfig.Builder().build();
        mPicker.setConfig(cityConfig);

//监听选择点击事件及返回结果
        mPicker.setOnCityItemClickListener(new OnCityItemClickListener() {
            @Override
            public void onSelected(ProvinceBean province, CityBean cityBean, DistrictBean district) {
                provence = province.getName();
                city = cityBean.getName();
                county =district.getName();
//                edLocation.setText(citySelected[0] + citySelected[1] + citySelected[2]);
                tvArea.setText(provence + " " + city + " " + county);
            }

            @Override
            public void onCancel() {
                com.lljjcoder.style.citylist.Toast.ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );

    }


    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.CAMERA)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(CreateTeamActivity.this);
                            commonPopWindow.showAtLocation(ivLogoImg, Gravity.CENTER, 0, 0);
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
                            ToastUtils.showToast(CreateTeamActivity.this,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(CreateTeamActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(CreateTeamActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(tvType, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(CreateTeamActivity.this)
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
                            uploadImage(type,new File(availablePath));
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
                            String availablePath = path.get(0).getAvailablePath();
                            if (availablePath.startsWith("content://")){
                                availablePath = path.get(0).getRealPath();
                            }
                            uploadImage(type,new File(availablePath));
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



    private String getPath() {
        String path = Environment.getExternalStorageDirectory() + "/boyi/image/compress";
        File file = new File(path);
        if (file.mkdirs()) {
            return path;
        }
        return path;
    }

    private void uploadImage(final int code, final File image) {
        if (image == null) {
            return;
        }
        ApiManager.uploadImg(image,1, new OnRequestSubscribe<BaseBean<String>>() {
            @Override
            public void onSuccess(BaseBean<String> data) {
                LoadDialog.CancelDialog();
                if (code == 1001) {
                    GlideLoad.GlideLoadCircle(image.getAbsolutePath(), ivLogoImg);
                    logPath = data.getData().toString();
                } else if (code == 1002) {
                    GlideLoad.GlideLoadImg2(image.getAbsolutePath(), ivBgImg);
                    bgPath = data.getData().toString();
                }


            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });

    }

    private void submit() {

        name = edName.getText().toString().trim();
        address = edAddress.getText().toString().trim();
        desc = edContext.getText().toString().trim();
        if (AppUtil.isEmpty(logPath)) {
            NToast.show("请添加logo");
            return;
        }
        if (AppUtil.isEmpty(bgPath)) {
            NToast.show("请添加背景");
            return;
        }
        if (AppUtil.isEmpty(city)) {
            NToast.show("请选择城市");
            return;
        }
        if (AppUtil.isEmpty(address)) {
            NToast.show("请填写详细地址");
            return;
        }
        if (AppUtil.isEmpty(name)) {
            NToast.show("请填写名称");
            return;
        }
        if (AppUtil.isEmpty(desc)) {
            NToast.show("请填写社团简介");
            return;
        }
        if (type == -1) {
            NToast.show("请选择社团类型");
            return;
        }

        LoadDialog.showDialog(this);
        ApiManager.communityCreate(logPath, bgPath, provence, city, county, address, name, desc, type + "", new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                NToast.show(data.getMessage());
                EventBusUtil.sendEvent(new Event(EventCode.TEAM_ADD_SUCCESS, 0));
                finish();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }

    @Override
    public void selectTye(MyDateBean bean) {
        if (bean == null) {
            return;
        }
        tvType.setText(bean.getDate() + "");
        type = bean.getId();
    }
}

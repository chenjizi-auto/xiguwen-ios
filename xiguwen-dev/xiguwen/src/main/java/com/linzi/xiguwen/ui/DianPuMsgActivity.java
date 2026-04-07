package com.linzi.xiguwen.ui;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.Color;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import com.google.gson.Gson;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AddAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.ProfessionalBean;
import com.linzi.xiguwen.bean.ProvinceBean;
import com.linzi.xiguwen.bean.StoreInformationBean;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.repository.RegionRepository;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.ImgCompressUtils;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LogUtil;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.citywheel.CityConfig;
import com.lljjcoder.style.citypickerview.CityPickerView;
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
import butterknife.OnTextChanged;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnNewCompressListener;

public class DianPuMsgActivity extends BaseActivity {

    @BindView(R.id.iv_img)
    ImageView ivImg;
    @BindView(R.id.ll_choose_bg)
    LinearLayout llChooseBg;
    @BindView(R.id.textView5)
    TextView textView5;
    @BindView(R.id.tv_num)
    TextView tvNum;
    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.tv_style)
    TextView tvStyle;
    @BindView(R.id.ll_choose_type)
    LinearLayout llChooseType;
    @BindView(R.id.tv_zhiye)
    TextView tvZhiye;
    @BindView(R.id.ll_choose_zhiye)
    LinearLayout llChooseZhiye;
    @BindView(R.id.tv_city)
    TextView tvCity;
    @BindView(R.id.ll_choose_city)
    LinearLayout llChooseCity;
    @BindView(R.id.tv_address)
    EditText tvAddress;
    @BindView(R.id.ed_context)
    EditText edContext;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    ArrayList<String> path = new ArrayList<>();
    ArrayList<String> path_bg = new ArrayList<>();
    AddAdapter mADapter;
    StoreInformationBean mData; //店鋪信息
    @BindView(R.id.tv_status)
    TextView tvStatus;
    private List<ProfessionalBean.DataBean> mProfessionallist; // 职业列表
    boolean mIsChangeFlag = false; //是否修改的標記
    private ProfessionalBean.DataBean mSelectProfessional;// 选择的职业
    private String[] mTeamType = new String[]{"个人商家", "团队商家"}; // 商家类型， 1:个人商家 ， 2: 团队商家
    private String[] mShopType = new String[]{"上线", "下线"};
    private int mChooseTeamType;
    private int mChooseShopType;
    private List<ProvinceBean> mProvinces;
    private String mArea;       // 区域编码

    private boolean initFlag = false;// 初始化标记

    private final CityPickerView mPicker=new CityPickerView();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dian_pu_msg);
        ButterKnife.bind(this);
        mPicker.init(this);
    }

    @Override
    protected void initData() {
        setTitle("店铺信息");
        setBack();

        GridLayoutManager manager = new GridLayoutManager(mContext, 3) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
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
            }
        }, path, 1);
        recycle.setAdapter(mADapter);


        requestNetData();
    }

    private void requestNetData() {
        // 加载网络数据
        LoadDialog.showDialog(mContext);
        ApiManager.getStoreInformation(new OnRequestFinish<BaseBean<StoreInformationBean>>() {
            @Override
            public void onFinished() {
            }

            @Override
            public void onSuccess(BaseBean<StoreInformationBean> data) {
                LoadDialog.CancelDialog();
                loadFinish(data);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    private void loadFinish(BaseBean<StoreInformationBean> data) {
        this.mData = data.getData();
        path_bg.clear();
        if (mData.getBackground() != null) {
            path_bg.add(mData.getBackground());
        }
        GlideLoad.GlideLoadRoundedImg(mData.getBackground(), ivImg, 8);
        tvNum.setText(mData.getUserid() + "");
        edName.setText(mData.getNickname());
        tvStyle.setText(mData.getTeamFormat());
        tvStatus.setText(mData.getStatusFormat());
        tvZhiye.setText(mData.getOccupationid() + "");
        tvCity.setText(mData.getPathFormat());
        tvAddress.setText(mData.getSite());
        edContext.setText(mData.getContent());
        path.clear();
        if (data.getData().getUsertype() == 2) {
            //婚庆
            llChooseType.setVisibility(View.VISIBLE);
            llChooseZhiye.setVisibility(View.VISIBLE);
        } else {
            llChooseType.setVisibility(View.GONE);
            llChooseZhiye.setVisibility(View.GONE);
        }
        for (int i = 0; i < mData.getShopimg().size(); i++) {
            LogUtil.d(TAG,"mData.getShopimg().get(i) url =  "+ mData.getShopimg().get(i));
        }
        if (mData.getShopimg() != null) {
            path.addAll(mData.getShopimg());
        }
        mADapter.notifyDataSetChanged();

        mChooseTeamType = mData.getTeam();
        mChooseShopType = mData.getOnlinestatus();

        // 请求店铺类型数据
        if (mProfessionallist == null) {
            requestClassificationlist(false);
        }
        // 请求区域数据
        if (mProvinces == null) {
            requestProvinces(false);
        }
    }

    /**
     * 显示保存菜单
     */
    private void showSaveMenu() {
        setRight("保存", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                changeStoreInformation();
            }
        });
    }

    /**
     * 檢測是否修改
     *
     * @return false表示已经修改过， true表示未修改
     */
    private boolean checkChange() {
        if (mData != null) {
            if (path_bg.size() == 1 && !path_bg.get(0).equals(mData.getBackground())) {
                return false;
            }
            if (!edName.getText().toString().equals(mData.getNickname())) {
                return false;
            }
            if (!tvStyle.getText().toString().equals(mData.getTeamFormat())) {
                return false;
            }
            if (!tvStatus.getText().toString().equals(mData.getStatusFormat())) {
                return false;
            }
            if (!tvZhiye.getText().toString().equals(mData.getOccupationid())) {
                return false;
            }
            if (!tvCity.getText().toString().equals(mData.getPathFormat())) {
                return false;
            }
            if (!tvAddress.getText().toString().equals(mData.getSite())) {
                return false;
            }
            if (!edContext.getText().toString().equals(mData.getContent())) {
                return false;
            }
            if (path.size() != mData.getShopimg().size()) {
                return false;
            }
            for (String p : path) {
                if (!mData.getShopimg().contains(p)) {
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * 修改店铺信息
     */
    boolean flag; //上传状态的标记
    int finishCount = 0;

    private void changeStoreInformation() {

        List<String> uploadFiles = new ArrayList<>();
        for (String p : path_bg) {
            if (!p.startsWith("http")) {
                uploadFiles.add(p);
            }
        }
        for (String p : path) {
            if (!p.startsWith("http")) {
                uploadFiles.add(p);
            }
        }

        //上传文件
        final int uploadFileCount = uploadFiles.size();
        NToast.log(TAG,"uploadFileCount "+uploadFileCount);
        flag = true;
        finishCount = 0;
        if (mSelectProfessional == null){
            ToastUtils.showToast(mContext,"请选择职业");
            return;
        }
        MsgLoadDialog.showDialog(mContext, "保存中...");
        if (uploadFileCount == 0) {
            submitOrder();
            return;
        }
        String patho = uploadFiles.get(0);
        if (TextUtils.isEmpty(patho)){
            NToast.show("店铺背景图不能为空,请上传店铺背景图");
            MsgLoadDialog.CancelDialog();
            return;
        }
        MsgLoadDialog.updateMsg("上传图片中...");
        for (final String uploadFile : uploadFiles) {
            com.linzi.xiguwen.utils.LogUtil.e("uploadImgBase64","=========="+uploadFile);
            String base64StrWithHead = ImgCompressUtils.getBase64StrWithHead(uploadFile);
            File file = new File(uploadFile);
//            com.linzi.xiguwen.utils.LogUtil.e("uploadImgBase64","========== size is "+file.length()/1024);
            com.linzi.xiguwen.utils.LogUtil.e("uploadImgBase64","==========base64StrWithHead "+base64StrWithHead);
//            com.linzi.xiguwen.utils.LogUtil.e("uploadImgBase64","==========base64StrWithHead "+base64StrWithHead);
            ApiManager.uploadImgBase64(base64StrWithHead, new OnRequestFinish<BaseBean<String>>() {
                @Override
                public void onFinished() {
                    finishCount++;
                    NToast.log(TAG,"uploadImgBase64 finishCount  " + finishCount +" flag " + flag);
                    if (finishCount == uploadFileCount) {
                        if (flag) {
                            //提交表单
                            submitOrder();
                        } else {
                            NToast.show("上传文件失败");
                            MsgLoadDialog.CancelDialog();
                        }
                    }
                }

                @Override
                public void onSuccess(BaseBean<String> data) {
                    NToast.log(TAG,"uploadImgBase64 onSuccess data " + data.getData().toString());
                    if (path_bg.contains(uploadFile)) {
                        path_bg.clear();
                        path_bg.add(data.getData());
                    } else if (path.contains(uploadFile)) {
                        path.remove(uploadFile);
                        path.add(data.getData());
                    }

                }

                @Override
                public void onError(Exception ex) {
                    NToast.log(TAG,"uploadImgBase64 filed "+ex.getMessage());
                    flag = false;
                }
            });

        }
    }

    // 提交表单
    private void submitOrder() {

        MsgLoadDialog.updateMsg("保存中...");
        String picPath = "";
        for (String s : path) {
            if (TextUtils.isEmpty(picPath)) {
                picPath = s;
            } else {
                picPath = picPath + "," + s;
            }
        }
        ApiManager.changeStoreInformation(mChooseShopType, edName.getText().toString().trim(), mArea, path_bg.isEmpty() ? "" : path_bg.get(0), edContext.getText().toString().trim(), mSelectProfessional.getOccupationid(),
                picPath, mChooseTeamType, tvAddress.getText().toString().trim(), new OnRequestFinish<BaseBean<String>>() {
                    @Override
                    public void onFinished() {
                        MsgLoadDialog.CancelDialog();
                    }

                    @Override
                    public void onSuccess(BaseBean<String> data) {
                        NToast.show(data.getMessage());
                        requestNetData();
                    }

                    @Override
                    public void onError(Exception ex) {
                        NToast.show(ex.getMessage());
                        com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                    }
                });
    }


    // 初始化职业列表
    private void requestClassificationlist(final boolean showDialog) {
        LoadDialog.showDialog(mContext);
        new ApiManager().getClassificationlist(1 + "", 1000 + "", new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                mProfessionallist = new Gson().fromJson(result, ProfessionalBean.class).getData();
                if (showDialog) {
                    showClassificationDialog(mProfessionallist);
                } else {
                    for (ProfessionalBean.DataBean dataBean : mProfessionallist) {
                        if (dataBean.getProname().equals(mData.getOccupationid())) {
                            mSelectProfessional = dataBean;
                            return;
                        }
                    }
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {
                NToast.show(ex.getMessage());
            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                if (showDialog) {
                    LoadDialog.CancelDialog();
                } else if (initFlag) {
                    LoadDialog.CancelDialog();
                } else {
                    initFlag = true;
                }
            }
        });
    }

    // 显示职业类型
    private void showClassificationDialog(final List<ProfessionalBean.DataBean> list) {
        int checkItem = 0;
        String[] values = new String[list.size()];
        if (mSelectProfessional == null) {
            for (int i = 0; i < list.size(); i++) {
                ProfessionalBean.DataBean dataBean = list.get(i);
                if (dataBean.getProname().equals(tvZhiye.getText().toString())) {
                    checkItem = i;
                }
                values[i] = dataBean.getProname();
            }
        } else {
            for (int i = 0; i < list.size(); i++) {
                ProfessionalBean.DataBean dataBean = list.get(i);
                if (dataBean == mSelectProfessional) {
                    checkItem = i;
                }
                values[i] = dataBean.getProname();
            }
        }
        AlertDialog.Builder dialog = new AlertDialog.Builder(mContext);
        dialog.setTitle("请选择职业类型");
        dialog.setSingleChoiceItems(values, checkItem, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                mSelectProfessional = list.get(i);
                if (!mSelectProfessional.getProname().equals(tvZhiye.getText().toString())) {
                    tvZhiye.setText(mSelectProfessional.getProname());
                    showSaveMenu();
                }
            }
        });
        dialog.setPositiveButton("确定", null);
        dialog.show();
    }

    // 顯示店鋪類型
    private void showDianPuStateDialog() {
        AlertDialog.Builder dialog = new AlertDialog.Builder(mContext);
        dialog.setTitle("请选择店铺类型");
        dialog.setSingleChoiceItems(mTeamType, mTeamType[0].equals(tvStyle.getText().toString()) ? 0 : 1, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                tvStyle.setText(mTeamType[i]);
                mChooseTeamType = i + 1;
                showSaveMenu();
            }
        });
        dialog.setPositiveButton("确定", null);
        dialog.show();
    }

    // 顯示店鋪状态
    private void showChooseDianPuStateDialog() {
        AlertDialog.Builder dialog = new AlertDialog.Builder(mContext);
        dialog.setTitle("请选择店铺状态");
        dialog.setSingleChoiceItems(mShopType, mShopType[0].equals(tvStatus.getText().toString()) ? 0 : 1, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                tvStatus.setText(mShopType[i]);
                mChooseShopType = i + 1;
                showSaveMenu();
            }
        });
        dialog.setPositiveButton("确定", null);
        dialog.show();
    }

    // 请求省市数据
    private void requestProvinces(final boolean showDialog) {
        LoadDialog.showDialog(mContext);
        RegionRepository.getInstance(this).getRegions(new OnCacheRequestFinish<List<ProvinceBean>>() {
            @Override
            public void onSuccess(List<ProvinceBean> data, boolean fromCache) {
                mProvinces = data;
                if (showDialog) {
                    showCityDialog(mProvinces);
                } else {
                    if (mArea == null) {
                        for (ProvinceBean mProvince : mProvinces) {
                            if (mProvince.getName().equals(mData.getProvinceid())) {
                                mArea = mProvince.getId();
                                for (ProvinceBean.CityBean cityBean : mProvince.getCity()) {
                                    if (cityBean.getName().equals(mData.getCityid())) {
                                        mArea = mArea + "-" + cityBean.getId();
                                        for (ProvinceBean.CityBean.CountyBean countyBean : cityBean.getCounty()) {
                                            if (countyBean.getName().equals(mData.getCountyid())) {
                                                mArea = mArea + "-" + countyBean.getId();
                                                return;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }

            @Override
            public void onFinished() {
                if (showDialog) {
                    LoadDialog.CancelDialog();
                } else if (initFlag) {
                    LoadDialog.CancelDialog();
                } else {
                    initFlag = true;
                }
            }
        });
    }

    private void showCityDialog(List<ProvinceBean> provinces) {


        CityConfig cityConfig = new CityConfig.Builder().build();
        cityConfig.setDefaultProvinceName(mData.getProvinceid());
        cityConfig.setDefaultCityName(mData.getCityid());
        cityConfig.setDefaultDistrict(mData.getCountyid());
        mPicker.setConfig(cityConfig);

//监听选择点击事件及返回结果
        mPicker.setOnCityItemClickListener(new OnCityItemClickListener() {
            @Override
            public void onSelected(com.lljjcoder.bean.ProvinceBean province, com.lljjcoder.bean.CityBean cityBean, DistrictBean district) {
                mData.setProvinceid(province.getName());
                mData.setCityid(cityBean.getName());
                mData.setCountyid(district.getName());
                mArea = district.getName();
                tvCity.setText(mData.getPathFormat());
                showSaveMenu();
            }

            @Override
            public void onCancel() {
                com.lljjcoder.style.citylist.Toast.ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );
    }

//    private void showCityDialog() {
//        CityPicker cityPicker = getCity(mData.getProvinceid(), mData.getCityid(), mData.getCountyid());
//        cityPicker.setOnCityItemClickListener(new CityPicker.OnCityItemClickListener() {
//            @Override
//            public void onSelected(String... citySelected) {
//                mData.setProvinceid(citySelected[0]);
//                mData.setCityid(citySelected[1]);
//                mData.setCountyid(citySelected[2]);
//
//                tvCity.setText(mData.getPathFormat());
//                showSaveMenu();
//            }
//
//            @Override
//            public void onCancel() {
//
//            }
//        });
//        cityPicker.show();
//    }


    private void showPop(int type) {

        XXPermissions.with(this)
                .permission(Permission.CAMERA)
                .request(new OnPermissionCallback() {

                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(DianPuMsgActivity.this);
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
        int max = type == 1002 ? 9-path.size():1;
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
                            if (type == 1002){
                                for (int i = 0; i < result.size(); i++) {
                                    String availablePath = result.get(i).getAvailablePath();
                                    if (availablePath.startsWith("content://")){
                                        availablePath = result.get(i).getRealPath();
                                    }
                                    path.add(availablePath);
                                }
                                NToast.log("size=====", "" + path.size());
                                mADapter.notifyDataSetChanged();
                            }
                            if (type == 1003){
                                path_bg.clear();
                                for (int i = 0; i < result.size(); i++) {
                                    String availablePath = result.get(i).getAvailablePath();
                                    if (availablePath.startsWith("content://")){
                                        availablePath = result.get(i).getRealPath();
                                    }
                                    path_bg.add(availablePath);
                                }
                                NToast.log("size=====", "" + path_bg.size());
                                GlideLoad.GlideLoadRoundedImg(path_bg.get(0), ivImg, 8);
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
                           if (type == 1002){
                               for (int i = 0; i < result.size(); i++) {
                                   String availablePath = result.get(i).getAvailablePath();
                                   if (availablePath.startsWith("content://")){
                                       availablePath = result.get(i).getRealPath();
                                   }
                                   path.add(availablePath);
                               }
                               NToast.log("size=====", "" + path.size());
                               mADapter.notifyDataSetChanged();
                           }
                           if (type == 1003){
                               path_bg.clear();
                               for (int i = 0; i < result.size(); i++) {
                                   String availablePath = result.get(i).getAvailablePath();
                                   if (availablePath.startsWith("content://")){
                                       availablePath = result.get(i).getRealPath();
                                   }
                                   path_bg.add(availablePath);
                               }
                               NToast.log("size=====", "" + path_bg.size());
                               GlideLoad.GlideLoadRoundedImg(path_bg.get(0), ivImg, 8);
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


    @OnClick({R.id.ll_choose_bg, R.id.ll_choose_type, R.id.ll_choose_zhiye, R.id.ll_choose_city, R.id.ll_choose_shangxian})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_choose_bg:
                showPop(1003);
                break;
            case R.id.ll_choose_type:
                showDianPuStateDialog();
                break;
            case R.id.ll_choose_shangxian:
                showChooseDianPuStateDialog();
                break;
            case R.id.ll_choose_zhiye:
                if (mProfessionallist == null) {
                    requestClassificationlist(true);
                } else {
                    showClassificationDialog(mProfessionallist);
                }
                break;
            case R.id.ll_choose_city:
//                showCityDialog();
                if (mProvinces == null) {
                    requestProvinces(true);
                } else {
                    showCityDialog(mProvinces);
                }
                break;
        }
    }

    @OnTextChanged(value = {R.id.ed_name, R.id.ed_context, R.id.tv_address}, callback = OnTextChanged.Callback.TEXT_CHANGED)
    public void onTextChanged(CharSequence s, int start, int before, int count) {
        showSaveMenu();
    }

    @Override
    public void onBackPressed() {
        if (!checkChange()) {
            final AskDialog dialog = new AskDialog(this, this);
            dialog.setTitle("提示");
            dialog.setMessage("尚未保存，是否退出？");
            dialog.setCancleListener("取消", new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    dialog.cancel();
                }
            });
            dialog.setSubmitListener("退出", new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    DianPuMsgActivity.super.onBackPressed();
                }
            });
            dialog.show();
        } else {
            super.onBackPressed();
        }
    }
}

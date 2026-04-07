package com.linzi.xiguwen.ui;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import com.google.gson.Gson;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AddAdapter;
import com.linzi.xiguwen.bean.CommodityBean;
import com.linzi.xiguwen.bean.CommodityInventoryBean;
import com.linzi.xiguwen.bean.FreightTemplateBean;
import com.linzi.xiguwen.bean.MineCommodityType;
import com.linzi.xiguwen.bean.ProvinceBean;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.repository.CommodityTypeRepository;
import com.linzi.xiguwen.cache.repository.RegionRepository;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.ImgCompressUtils;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.utils.StatusBarUtil;
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
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnNewCompressListener;

/**
 * Created by PC on 2018-04-12.
 * 添加我的商品界面
 */

public class AddMineCommodityActivity extends AppCompatActivity {

    @BindView(R.id.ll_back)
    LinearLayout llBack;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.ll_bar)
    View llBar;

    @BindView(R.id.tv_type1)
    TextView mTvType1;      //  商品类目
    @BindView(R.id.tv_type2)
    TextView mTvType2;      // 商品子类
    @BindView(R.id.ed_name)
    EditText mEdName;       //  商品名称
    @BindView(R.id.ed_price)
    EditText mEdPrice;       // 商品价格
    @BindView(R.id.ed_unit)
    EditText mEdUnit;       // 商品单位
    @BindView(R.id.ed_quan)
    EditText mEdQuan;       // 现金抵扣券
    @BindView(R.id.ed_weight)
    EditText mEdWeight;     // 商品排序
    @BindView(R.id.tv_freight)
    TextView mTvFreight;    // 运费模板
    @BindView(R.id.tv_path)
    TextView mTvPath;       // 商品地区
    @BindView(R.id.recycle)
    RecyclerView recycle;

    private CommodityBean mData; // 我的商品对象
    private AddAdapter mAdapter;
    ArrayList<String> path = new ArrayList<>(); // 图片数组
    private String mProperty1 = ""; // 属性1
    private String mProperty2 = "";  // 属性2
    private ArrayList<CommodityInventoryBean> mInventorys = new ArrayList<>();


    private List<MineCommodityType> mParentType; //父级类型
    private Map<Integer, List<MineCommodityType>> mChildType; //子级类型
    private List<FreightTemplateBean> mFreightTemplates; // 运费模板
    private List<ProvinceBean> mProvinces;// 地区信息

    private int mType1Id = -1; // 类别1id
    private int mType2Id = -1;// 类别2id
    private int mFreightId = -1; // 运费模板id

    private String mArea = "";
    private String mProvinceId = "";    //省id
    private String mCityId = "";        //市id
    private String mCountyId = "";        //区id

    private final CityPickerView mPicker=new CityPickerView();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(this,R.color.white);
        }

        setContentView(R.layout.activity_add_mine_commodity);
        ButterKnife.bind(this);
        mPicker.init(this);
        initData();
    }

    protected void initData() {
        mData = (CommodityBean) getIntent().getSerializableExtra("data");

        if(mData == null){
            tvTitle.setText("添加商品");
        }else{
            tvTitle.setText("编辑商品");
        }
        llBack.setVisibility(View.VISIBLE);
        llBack.setOnClickListener(view -> finish());

        GridLayoutManager manager=new GridLayoutManager(this,3){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter=new AddAdapter(this, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
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

        refreshView(mData);
        mChildType = new HashMap<>();
    }

    //刷新树
    private void refreshView(CommodityBean data) {
        if(data != null){
            mTvType1.setText(data.getPcolumnname());
            mTvType2.setText(data.getColumnname());
            mEdName.setText(data.getShopname());
            mEdPrice.setText(data.getPrice());
            mEdUnit.setText(data.getCompany());
            mEdQuan.setText(data.getCoupons_price());
            mEdWeight.setText(data.getWeigh() + "");
            mTvFreight.setText(data.getExpressname());
            mTvPath.setText(data.getProvince() + data.getCity() + data.getCounty());
            if(data.getShopimg() != null){
                path.addAll(data.getShopimg());
            }


            mType1Id = data.getPcolumnid();
            mType2Id = data.getColumind();
            mFreightId = data.getExpressid();
            mArea = String.format("%d-%d-%d", data.getProvinceid(), data.getCityid() , data.getCountyid());
            mProvinceId = data.getProvince();
            mCityId = data.getCity();
            mCountyId = data.getCounty();
        }
    }

    //健壮性检查
    private boolean check(){
        return isEmpty(mTvType1, "请选择商品类目")
                && isEmpty(mTvType2, "请选择商品子类")
                && isEmpty(mEdName, "请输入商品名称")
                && isEmpty(mEdPrice, "请输入商品价格")
                && isEmpty(mTvFreight, "请选择运费模板")
                && isEmpty(mTvPath, "请选择商品地区");
    }

    private boolean isEmpty(TextView view, String hint){
        if(TextUtils.isEmpty(text(view))){
            NToast.show(hint);
            return false;
        }
        return true;
    }

    //先上传图片
    boolean flag; //上传图片的状态
    int finishCount; //上传完成的数量
    private void uploadImg() {
        MsgLoadDialog.showDialog(this, "保存中...");
        //上传图片
        final List<String> uploadFiles = new ArrayList<>();
        for (String p : path) {
            if (!p.toLowerCase().startsWith("http")) {
                uploadFiles.add(p);
            }
        }

        final int uploadFileCount = uploadFiles.size();
        if (uploadFileCount == 0) {
            submitOrder();
            return;
        }
        finishCount = 0;
        flag = true;
        MsgLoadDialog.updateMsg("上传图片中...");
        new Thread() {
            @Override
            public void run() {
                super.run();
                for (final String uploadFile : uploadFiles) {
                    ApiManager.uploadImgBase64(ImgCompressUtils.getBase64StrWithHead(uploadFile), new OnRequestFinish<BaseBean<String>>() {
                        @Override
                        public void onFinished() {
                            finishCount++;
                            if (finishCount == uploadFileCount) {
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        if (flag) {
                                            //提交表单
                                            submitOrder();
                                        } else {
                                            NToast.show("上传文件失败");
                                            MsgLoadDialog.CancelDialog();
                                        }
                                    }
                                });
                            }
                        }

                        @Override
                        public void onSuccess(BaseBean<String> data) {
                            if (path.contains(uploadFile)) {
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

    //添加或者修改商品
    private void submitOrder(){
        MsgLoadDialog.updateMsg("保存中...");
        Gson gson = new Gson();
        if(mData == null){
            ApiManager.addMyCommodity(mType1Id, mType2Id, text(mEdName), text(mEdPrice), text(mEdUnit), text(mEdQuan), text(mEdWeight), mFreightId, mArea,
                    mProperty1, mProperty2, gson.toJson(mInventorys), path, new OnRequestFinish<BaseBean<String>>() {
                        @Override
                        public void onFinished() {
                            MsgLoadDialog.CancelDialog();
                        }

                        @Override
                        public void onSuccess(BaseBean<String> data) {
                            NToast.show("保存成功");
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
            ApiManager.editMyCommodity(mData.getShopid(), mType1Id, mType2Id, text(mEdName), text(mEdPrice), text(mEdUnit), text(mEdQuan), text(mEdWeight), mFreightId, mArea,
                    mProperty1, mProperty2, gson.toJson(mInventorys), path, new OnRequestFinish<BaseBean<String>>() {
                        @Override
                        public void onFinished() {
                            MsgLoadDialog.CancelDialog();
                        }

                        @Override
                        public void onSuccess(BaseBean<String> data) {
                            NToast.show("修改成功");
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

    private String text(TextView textView){
        return textView.getText().toString().trim();
    }

    //请求运费模板
    private void requestFreight(){
        if(mFreightTemplates != null){
            showSingleChooseDialog2("请选择运费模板", mFreightTemplates, mFreightId, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    FreightTemplateBean bean = mFreightTemplates.get(which);
                    mFreightId = bean.getId();
                    mTvFreight.setText(bean.getTitle());
                }
            });
            return;
        }
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.getMineCommodityFreightTemplate(new OnRequestFinish<BaseBean<List<FreightTemplateBean>>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<List<FreightTemplateBean>> data) {
                mFreightTemplates = data.getData();
                showSingleChooseDialog2("请选择运费模板", mFreightTemplates, mFreightId, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        FreightTemplateBean bean = mFreightTemplates.get(which);
                        mFreightId = bean.getId();
                        mTvFreight.setText(bean.getTitle());
                    }
                });
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    // 请求地区信息
    private void requestAddress(){
        if(mProvinces != null){
            showCityDialog(mProvinces);
            return;
        }
        MsgLoadDialog.showDialog(this, "请稍候...");
        RegionRepository.getInstance(this).getRegions(new OnCacheRequestFinish<List<ProvinceBean>>() {
            @Override
            public void onSuccess(List<ProvinceBean> data, boolean fromCache) {
                mProvinces = data;
                showCityDialog(mProvinces);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }

            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }
        });
    }

    //请求商品类目
    private void requestTypeList(){
        if(mParentType != null){
            showSingleChooseDialog1("请选择商品类目", mParentType, mType1Id, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    MineCommodityType type = mParentType.get(which);
                    mType1Id = type.getId();
                    mTvType1.setText(type.getName());
                }
            });
            return;
        }
        MsgLoadDialog.showDialog(this, "请稍候...");
        CommodityTypeRepository.getInstance(this).getParentTypes(new OnCacheRequestFinish<List<MineCommodityType>>() {
            @Override
            public void onSuccess(List<MineCommodityType> data, boolean fromCache) {
                mParentType = data;
                showSingleChooseDialog1("请选择商品类目", mParentType, mType1Id, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        MineCommodityType type = mParentType.get(which);
                        mType1Id = type.getId();
                        mTvType1.setText(type.getName());
                    }
                });
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }

            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }
        });
    }

    //请求商品子类
    private void requestChildTypeList(final int pid){
        if(mChildType.containsKey(pid)){
            final List<MineCommodityType> childTypes = mChildType.get(pid);
            showSingleChooseDialog1("请选择商品子类", childTypes, mType2Id, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    MineCommodityType type = childTypes.get(which);
                    mType2Id = type.getId();
                    mTvType2.setText(type.getName());
                }
            });
            return;
        }
        MsgLoadDialog.showDialog(this, "请稍候...");
        CommodityTypeRepository.getInstance(this).getChildTypes(pid, new OnCacheRequestFinish<List<MineCommodityType>>() {
            @Override
            public void onSuccess(List<MineCommodityType> data, boolean fromCache) {
                final List<MineCommodityType> childTypes = data;
                mChildType.put(pid, childTypes);
                showSingleChooseDialog1("请选择商品子类", childTypes, mType2Id, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        MineCommodityType type = childTypes.get(which);
                        mType2Id = type.getId();
                        mTvType2.setText(type.getName());
                    }
                });
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }

            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }
        });
    }

    //显示单选对话框
    private void showSingleChooseDialog1(String title, final List<MineCommodityType> type, int currentId, DialogInterface.OnClickListener listener){
        int checkItem = -1;
        String[] items = new String[type.size()];
        for (int i = 0 ; i < type.size() ; i ++) {
            MineCommodityType commodityType = type.get(i);
            items[i] = commodityType.getName();
            if(currentId == commodityType.getId()){
                checkItem = i;
            }
        }
        _showSingleChooseDialog(title, items, checkItem, listener);
    }


    private void showSingleChooseDialog2(String title, final List<FreightTemplateBean> type, int currentId, DialogInterface.OnClickListener listener){
        int checkItem = -1;
        String[] items = new String[type.size()];
        for (int i = 0 ; i < type.size() ; i ++) {
            FreightTemplateBean bean = type.get(i);
            items[i] = bean.getTitle();
            if(currentId == bean.getId()){
                checkItem = i;
            }
        }
        _showSingleChooseDialog(title, items, checkItem, listener);
    }

    private void showCityDialog(List<ProvinceBean> provinces){
        CityConfig cityConfig = new CityConfig.Builder().build();
        mPicker.setConfig(cityConfig);

//监听选择点击事件及返回结果
        mPicker.setOnCityItemClickListener(new OnCityItemClickListener() {
            @Override
            public void onSelected(com.lljjcoder.bean.ProvinceBean province, com.lljjcoder.bean.CityBean cityBean, DistrictBean district) {
                mProvinceId = province.getId();
                mCityId = cityBean.getId();
                mCountyId = district.getId();
                mArea = district.getName();
                mTvPath.setText(province.getName() + " " + cityBean.getName() + " " + district.getName());
            }

            @Override
            public void onCancel() {
                ToastUtils.showToast(AddMineCommodityActivity.this,"已取消");
            }
        });
        //显示
        mPicker.showCityPicker( );
    }

    private void _showSingleChooseDialog(String title, String[] items, int check, DialogInterface.OnClickListener listener){
        AlertDialog.Builder dialog = new AlertDialog.Builder(this);
        dialog.setTitle(title);
        dialog.setSingleChoiceItems(items, check,listener);
        dialog.setPositiveButton("确定", null);
        dialog.show();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        switch (requestCode){
            case 1002:
                break;
            case 101:
                if(resultCode == RESULT_OK && data != null){
                    String[] dataArr = data.getStringArrayExtra("data");
                    if(dataArr.length == 2){
                        mProperty1 = dataArr[0];
                        mProperty2 = dataArr[1];
                    }
                }
                break;
            case 102:
                if(resultCode == RESULT_OK && data != null){
                    mInventorys = (ArrayList<CommodityInventoryBean>) data.getSerializableExtra("data");
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
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(AddMineCommodityActivity.this);
                            commonPopWindow.showAtLocation(llBack, Gravity.CENTER, 0, 0);
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
                            ToastUtils.showToast(AddMineCommodityActivity.this,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(AddMineCommodityActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(AddMineCommodityActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(llBack, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(AddMineCommodityActivity.this)
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
                                mAdapter.notifyDataSetChanged();
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
                                mAdapter.notifyDataSetChanged();
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


    @OnClick({R.id.ll_commodity_type1, R.id.ll_commodity_type2, R.id.ll_commodity_path, R.id.ll_commodity_freight, R.id.ll_property, R.id.ll_inventory, R.id.ll_save})
    public void onClick(View view){
        switch (view.getId()){
            case R.id.ll_commodity_type1: //    商品类目
                requestTypeList();
                break;
            case R.id.ll_commodity_type2://     商品子类
                if(mType1Id == -1){
                    NToast.show("请先选择类目");
                    return;
                }
                requestChildTypeList(mType1Id);
                break;
            case R.id.ll_commodity_freight://   运费模板
                requestFreight();
                break;
            case R.id.ll_commodity_path://      商品地区
                requestAddress();
                break;
            case R.id.ll_property:      //      商品属性
                CommodityPropertyActivity.startActivity(this, mProperty1, mProperty2, 101);
                break;
            case R.id.ll_inventory:     //      商品库存
                CommodityInventoryActivity.startActivity(this, mInventorys, 102);
                break;
            case R.id.ll_save:          //      保存
                if(check()){
                    uploadImg();
                }
                break;
        }
    }
}

package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;

import androidx.annotation.NonNull;
import androidx.core.graphics.drawable.RoundedBitmapDrawable;
import androidx.core.graphics.drawable.RoundedBitmapDrawableFactory;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.UserEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.PopChooserUtils;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.utils.TimeSeletctUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
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
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;
import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnCompressListener;
import top.zibin.luban.OnNewCompressListener;

public class UserMessageActivity extends BaseActivity {

    @BindView(R.id.iv_head_img)
    ImageView ivHeadImg;
    @BindView(R.id.ll_head)
    LinearLayout llHead;
    @BindView(R.id.tv_nickname)
    TextView tvNickname;
    @BindView(R.id.ll_nickname)
    LinearLayout llNickname;
    @BindView(R.id.textView2)
    TextView textView2;
    @BindView(R.id.tv_sex)
    TextView tvSex;
    @BindView(R.id.ll_sex)
    LinearLayout llSex;
    @BindView(R.id.tv_birthday)
    TextView tvBirthday;
    @BindView(R.id.ll_birthday)
    LinearLayout llBirthday;
    @BindView(R.id.tv_age)
    TextView tvAge;
    @BindView(R.id.ll_age)
    LinearLayout llAge;
    @BindView(R.id.tv_height)
    TextView tvHeight;
    @BindView(R.id.ll_height)
    LinearLayout llHeight;
    @BindView(R.id.tv_weight)
    TextView tvWeight;
    @BindView(R.id.ll_weight)
    LinearLayout llWeight;
    @BindView(R.id.tv_city)
    TextView tvCity;
    @BindView(R.id.ll_city)
    LinearLayout llCity;
    @BindView(R.id.textView3)
    TextView textView3;
    @BindView(R.id.tv_contact_add)
    TextView tvContactAdd;
    @BindView(R.id.ll_contact_add)
    LinearLayout llContactAdd;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;

    //    private ArrayList<String> path = new ArrayList<>();
    private Activity mContext;

    private String nickName;
    private String height;
    private String weight;
    private String address;
    private String provence = "";
    private String county = "";
    private String city = "";
    UserEntity userEntity;

    private final CityPickerView mPicker=new CityPickerView();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_user_message);
        ButterKnife.bind(this);
        mPicker.init(this);
        mContext = this;
        userEntity = new UserEntity();
    }

    @Override
    protected void initData() {

        EventBusUtil.register(this);
        setTitle("个人资料");
        setRight("保存", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                updateUserInfo(userEntity);
            }
        });
        setRight("");
        setRightClickAble(false);
        setBack();
        httpData();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
    }

    private void httpData() {
        ApiManager.userInfo(new OnRequestSubscribe<BaseBean<UserEntity>>() {
            @Override
            public void onSuccess(BaseBean<UserEntity> data) {
//                userEntity = data.getData();
                setUserInfo(data.getData());
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }


    private void setUserInfo(UserEntity userEntity) {
        if (userEntity == null) {
            return;
        }
        nickName = userEntity.getNickname();
        height = userEntity.getHeight();
        weight = userEntity.getWeight();
        address = userEntity.getAddress();
        tvNickname.setText(nickName + "");
        tvAge.setText(userEntity.getAge() + "");
        tvSex.setText(userEntity.getSex() + "");
        tvBirthday.setText(userEntity.getBirthday() + "");
        tvHeight.setText(userEntity.getHeight() + "cm");
        tvWeight.setText(userEntity.getWeight() + "kg");

        if (userEntity.getCityid() != null) {
            city = userEntity.getCityid();
        }

        if (userEntity.getCountyid() != null) {
            county = userEntity.getCountyid();
        }

        if (userEntity.getProvinceid() != null) {
            provence = userEntity.getProvinceid();
        }

        tvCity.setText(provence + " " + city + " " + county);
        tvContactAdd.setText(userEntity.getAddress() + "");
        GlideLoad.GlideLoadCircle(userEntity.getHead(), ivHeadImg);

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
                GlideLoad.GlideLoadCircle(image.getAbsolutePath(), ivHeadImg);
                userEntity.setHead(data.getData());
                setRight("保存");
                setRightClickAble(true);
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

    private void updateUserInfo(UserEntity userEntity) {
        LoadDialog.showDialog(this);
        ApiManager.userInfoUpdate(userEntity, new OnRequestSubscribe<BaseBean<UserEntity>>() {
            @Override
            public void onSuccess(BaseBean<UserEntity> data) {
                ToastUtils.showToast(mContext, "保存成功");
                LoadDialog.CancelDialog();
                setRight("");
                setRightClickAble(false);
                EventBusUtil.sendEvent(new Event(EventCode.LOGIN_SUCCESS));
            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(mContext, ex.getMessage());
                LoadDialog.CancelDialog();
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
         if (requestCode == 1002 && resultCode == Activity.RESULT_OK) {
            Bundle bundle = data.getExtras();
            if (bundle != null) {
                Bitmap bm = (Bitmap) bundle.get("data");
                if (bm != null) {
                    RoundedBitmapDrawable circularBitmapDrawable =
                            RoundedBitmapDrawableFactory.create(mContext.getResources(), bm);
                    circularBitmapDrawable.setCircular(true);
                    ivHeadImg.setImageDrawable(circularBitmapDrawable);
                } else {
                    Toast.makeText(mContext, "没有压缩的图片数据", Toast.LENGTH_LONG).show();
                }
            } else {
                NToast.show("没有获取到图片");
            }
        }
        if (data != null) {
            switch (resultCode) {
                case 121:
                    tvCity.setText(data.getStringExtra("city_name"));
//                    city_code=data.getIntExtra("city_code",0);
//                    NToast.log("city_id",""+city_code);
//                    if(IndexFragment.instence!=null){
//                        IndexFragment.instence.getIndex();
//                    }
                    break;
            }
        }
    }

    @OnClick({R.id.ll_head, R.id.ll_nickname, R.id.ll_sex, R.id.ll_birthday, R.id.ll_age, R.id.ll_height, R.id.ll_weight, R.id.ll_city, R.id.ll_contact_add})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_head:
                showPop(1001);
                break;
            case R.id.ll_nickname:
                EditNicknameActivity.startAction(mContext, nickName, EventCode.USER_UPTATE_NAME);
                break;
            case R.id.ll_sex:
                new PopChooserUtils(UserMessageActivity.this)
                        .setChooseData(new String[]{"男", "女"})
                        .setListenner(new PopChooserUtils.ItemClickListener() {
                            @Override
                            public void popItemClick(View view, int position) {
                                String sex;
                                if (position == 0) {
                                    sex = "男";
//                                    tvSex.setText("男");
//                                    userEntity.setSex(position + "男");
                                } else {
                                    sex = "女";
//                                    tvSex.setText("女");
//                                    userEntity.setSex(position + "女");
                                }

//                                UserEntity userEntity = new UserEntity();
//                                userEntity.setSex(position + "");
                                if (!sex.equals(tvSex.getText().toString())) {
                                    setRight("保存");
                                    setRightClickAble(true);
                                    userEntity.setSex(sex);
                                }

                                tvSex.setText(sex);
//                                updateUserInfo(userEntity);
                            }
                        })
                        .show(llParent);
                break;
            case R.id.ll_birthday:
                new TimeSeletctUtil(UserMessageActivity.this)
                        .isWhen(false)
                        .setListener(new TimeSeletctUtil.getDataListener() {
                            @Override
                            public void getData(int year, int month, int day, String when) {
                                String time = year + "-" + (month + 1) + "-" + day;
                                tvBirthday.setText(time);
                                String longTime = AppUtil.timeToLong(time, "yyyy-MM-dd");
                                Calendar calendar = Calendar.getInstance();
                                int nowYear = calendar.get(GregorianCalendar.YEAR);
                                int age = nowYear - year;

//                                UserEntity userEntity = new UserEntity();
                                userEntity.setBirthday(longTime);
                                userEntity.setAge(age + "");
                                setRight("保存");
                                setRightClickAble(true);
//                                updateUserInfo(userEntity);
                                tvAge.setText(age + "");
                            }

                            @Override
                            public void getToday(int toyear, int tomonth, int today) {

                            }

                            @Override
                            public void getHous(int hour, int m) {

                            }
                        }).selectBirthDate(llParent);
                break;
            case R.id.ll_age:
//                Intent intent2 = new Intent(mContext, EditNicknameActivity.class);
//                startActivity(intent2);
                break;
            case R.id.ll_height:
//                Intent intent3 = new Intent(mContext, EditNicknameActivity.class);
//                startActivity(intent3);
                EditNicknameActivity.startAction(mContext, height, EventCode.USER_UPTATE_HEIGHT);
                break;
            case R.id.ll_weight:
//                Intent intent4 = new Intent(mContext, EditNicknameActivity.class);
//                startActivity(intent4);
                EditNicknameActivity.startAction(mContext, weight, EventCode.USER_UPTATE_WEITHT);
                break;
            case R.id.ll_city:

//                CityListActivity.startAction(mContext, 1);
//                Intent intent6 = new Intent(mContext, SelectCityActivity.class);
//                this.startActivityForResult(intent6, 121);
                selectCity();
                break;
            case R.id.ll_contact_add:
//                Intent intent5 = new Intent(mContext, EditNicknameActivity.class);
//                startActivity(intent5);
                EditNicknameActivity.startAction(mContext, address, EventCode.USER_UPTATE_ADDRESS);
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
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(UserMessageActivity.this);
                            commonPopWindow.showAtLocation(ivHeadImg, Gravity.CENTER, 0, 0);
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
                            ToastUtils.showToast(UserMessageActivity.this,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(UserMessageActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(UserMessageActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(ivHeadImg, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(UserMessageActivity.this)
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
                            if (type == 1001){
                                String availablePath = path.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = path.get(0).getRealPath();
                                }
                                uploadImage(new File(availablePath));
                                GlideLoad.GlideLoadCircle(UserMessageActivity.this,availablePath,ivHeadImg);
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
                            if (type == 1001){
                                String availablePath = path.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = path.get(0).getRealPath();
                                }
                                uploadImage(new File(availablePath));
                                GlideLoad.GlideLoadCircle(UserMessageActivity.this,availablePath,ivHeadImg);
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




    /*
  * 第二种方式调用系统摄像头拍照
  * */
    private void takePhotoByMethod2() {
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        startActivityForResult(intent, 1002);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.USER_UPTATE_NAME:
                    nickName = entity.getData().toString();
                    tvNickname.setText(nickName);
                    userEntity.setNickname(nickName);
                    setRight("保存");
                    setRightClickAble(true);
                    break;
                case EventCode.USER_UPTATE_HEIGHT:
                    height = entity.getData().toString();
                    tvHeight.setText(height + "cm");
                    userEntity.setHeight(height);
                    setRight("保存");
                    setRightClickAble(true);
                    break;
                case EventCode.USER_UPTATE_WEITHT:
                    weight = entity.getData().toString();
                    tvWeight.setText(weight + "kg");
                    userEntity.setWeight(weight);
                    setRight("保存");
                    setRightClickAble(true);
                    break;
                case EventCode.USER_UPTATE_ADDRESS:
                    address = entity.getData().toString();
                    tvContactAdd.setText(address + "");
                    userEntity.setAddress(address);
                    setRight("保存");
                    setRightClickAble(true);
                    break;
                case EventCode.USER_UPTATE_CITY:
//                    CityEntity cityEntity = (CityEntity) entity.getData();
//                    UserEntity userEntity = new UserEntity();
//                    userEntity.setCityid(cityEntity.getId() + "");
//                    tvCity.setText(cityEntity.getName() + "");
//                    updateUserInfo(userEntity);
                    selectCity();
                    setRight("保存");
                    setRightClickAble(true);
                    break;
            }
        } catch (Exception e) {
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
                county = district.getName();
//                edLocation.setText(citySelected[0] + citySelected[1] + citySelected[2]);
                tvCity.setText(provence + " " + city + " " + county);

//                UserEntity userEntity = new UserEntity();
                userEntity.setCityid(city);
                userEntity.setProvinceid(provence);
                userEntity.setCountyid(county);
                setRight("保存");
                setRightClickAble(true);
            }

            @Override
            public void onCancel() {
                com.lljjcoder.style.citylist.Toast.ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );


    }


    private String getPath() {
        String path = Environment.getExternalStorageDirectory() + "/boyi/image/compress";
        File file = new File(path);
        if (file.mkdirs()) {
            return path;
        }
        return path;
    }
}

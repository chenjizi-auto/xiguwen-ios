package com.linzi.xiguwen.ui;

import android.app.AlertDialog;
import android.content.DialogInterface;
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
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AddAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MyExampleDetailBean;
import com.linzi.xiguwen.bean.WeddingEnvironmentBean;
import com.linzi.xiguwen.bean.WeddingTypsBean;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.repository.WeddingDictionaryRepository;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.ImgCompressUtils;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.utils.TimeFormatter;
import com.linzi.xiguwen.utils.TimeSeletctUtil;
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

public class AddExampleActivity extends BaseActivity {


    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.tv_time)
    TextView tvTime;        // 婚礼时间
    @BindView(R.id.ll_choose_time)
    LinearLayout llChooseTime;
    @BindView(R.id.ed_changdi)
    EditText edChangdi;     // 婚礼场地
    @BindView(R.id.ed_dingjing)
    EditText edDingjing;    // 婚礼费用
    @BindView(R.id.ed_type)
    TextView edType;        // 婚礼类型
    @BindView(R.id.ed_huanjing)
    TextView edHuanjing;    // 婚礼环境
    @BindView(R.id.ed_weight)
    EditText edWeight;      // 权重
    @BindView(R.id.iv_fengmian)
    ImageView ivFengmian;   // 婚礼封面
    @BindView(R.id.ll_choose_fengmian)
    LinearLayout llChooseFengmian;
    @BindView(R.id.recycle)
    RecyclerView recycle;   // 婚礼图片
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    @BindView(R.id.ed_wmiaoshu)
    EditText edWmiaoshu;   // 婚礼描述
    private AddAdapter mAdapter;


    ArrayList<String> path = new ArrayList<>();
    String path_fengmian;
    private TimeFormatter mTime;
    private WeddingTypsBean mType; // 类型
    private WeddingEnvironmentBean mEnvironment;  // 环境

    private List<WeddingEnvironmentBean> mEnvironments; // 婚礼环境列表
    private List<WeddingTypsBean> mTypes;               // 婚礼类型列表

    private MyExampleDetailBean mData;
    private boolean mIsWaitEdit;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_example);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (MyExampleDetailBean) getIntent().getSerializableExtra("data");
        if(mData == null){
            setTitle("添加案例");
        }else{
            setTitle("编辑案例");
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
//                ImageSelect.ActivityImageSelectMore(AddExampleActivity.this, mContext, 9, path, 1002);
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

        refreshView(mData);
    }

    private void refreshView(MyExampleDetailBean data) {
        if(data != null){
            edName.setText(data.getTitle());
            if(!TextUtils.isEmpty(data.getWeddingtime())){
                String[] time = data.getWeddingtime().split("-");
                if(time.length == 3){
                    try {
                        mTime = new TimeFormatter(Integer.parseInt(time[0]), Integer.parseInt(time[1]), Integer.parseInt(time[2]));
                        tvTime.setText(time[0] + "年" + time[1] + "月" + time[2] + "日");
                    } catch (Exception e) {
                        com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                    }
                }
            }
            edChangdi.setText(data.getWeddingplace());
            edDingjing.setText(data.getWeddingexpenses() + "");
            edWeight.setText(data.getWeigh() + "");
            path_fengmian = data.getWeddingcover();
            edWmiaoshu.setText(data.getWeddingdescribe());

            requestWeddingTypes(false);
            requestWeddingEnvironments(false);

            GlideLoad.GlideLoadImg(this, path_fengmian, ivFengmian);
            path.clear();
            if(data.getPhtupian() != null){
                for (MyExampleDetailBean.Photo photo : data.getPhtupian()) {
                    path.add(photo.getPhotourl());
                }
            }
            mAdapter.notifyDataSetChanged();
        }
    }


    private boolean check(){
        if(TextUtils.isEmpty(edName.getText().toString().trim())){
            NToast.show("请输入案例名称");
            edName.requestFocus();
            return false;
        }
        if(mTime == null){
            NToast.show("请选择日期");
            return false;
        }
        if(TextUtils.isEmpty(edChangdi.getText().toString().trim())){
            NToast.show("请输入场地");
            edChangdi.requestFocus();
            return false;
        }
        if(TextUtils.isEmpty(edDingjing.getText().toString().trim())){
            NToast.show("请输入婚礼费用");
            edDingjing.requestFocus();
            return false;
        }else{
            try {
                Float.parseFloat(edDingjing.getText().toString().trim());
            } catch (Exception e) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                NToast.show("婚礼费用格式有误");
                return false;
            }
        }

        if(mType == null){
            NToast.show("请选择婚礼类型");
            return false;
        }

        if(mEnvironment == null){
            NToast.show("请选择婚礼环境");
            return false;
        }

        if(TextUtils.isEmpty(edWeight.getText().toString().trim())){
            NToast.show("请输入排序");
            edWeight.requestFocus();
            return false;
        }else{
            try {
                Float.parseFloat(edWeight.getText().toString().trim());
            } catch (Exception e) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                NToast.show("排序格式有误");
                return false;
            }
        }

        if(path_fengmian == null){
            NToast.show("请选择封面图片");
            return false;
        }

        if(TextUtils.isEmpty(edWmiaoshu.getText().toString().trim())){
            NToast.show("请输入描述");
            edWmiaoshu.requestFocus();
            return false;
        }

        if(path == null || path.size() == 0){
            NToast.show("请选择婚礼图片");
            return false;
        }
        return true;
    }

    //添加图册
    boolean flag; //上传图片的状态
    int finishCount; //上传完成的数量
    private void addExample(){
        MsgLoadDialog.showDialog(mContext, "保存中...");
        //上传图片
        List<String> uploadFiles = new ArrayList<>();
        if(!path_fengmian.toLowerCase().startsWith("http")){
            uploadFiles.add(path_fengmian);
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
        MsgLoadDialog.updateMsg( "上传图片中...");
        for (final String uploadFile : uploadFiles) {
            new Thread(){
                @Override
                public void run() {
                    super.run();
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
                            if(uploadFile.equals(path_fengmian)){
                                path_fengmian = data.getData();
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
            }.start();
        }
    }


    //提交表单
    private void submitOrder(){
        MsgLoadDialog.updateMsg("保存中...");
        if(mData == null){
            ApiManager.addMyExample(edName.getText().toString().trim(), path, path_fengmian,
                    edWmiaoshu.getText().toString().trim(),
                    mEnvironment.getId(), edDingjing.getText().toString().trim(),
                    edChangdi.getText().toString().trim(), mTime.getFormatDate(),
                    mType.getId(), edWeight.getText().toString().trim(),
                    new OnRequestFinish<BaseBean<String>>() {
                        @Override
                        public void onFinished() {
                            MsgLoadDialog.CancelDialog();
                        }

                        @Override
                        public void onSuccess(BaseBean<String> data) {
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
            if(mTypes == null){
                mIsWaitEdit = true;
                requestWeddingTypes(false);
                return ;
            }else if(mEnvironments == null){
                mIsWaitEdit = true;
                requestWeddingEnvironments(false);
                return ;
            }

            ApiManager.editMyExample(mData.getId(), edName.getText().toString().trim(), path, path_fengmian,
                    edWmiaoshu.getText().toString().trim(),
                    mEnvironment.getId(), edDingjing.getText().toString().trim(),
                    edChangdi.getText().toString().trim(), mTime.getFormatDate(),
                    mType.getId(), edWeight.getText().toString().trim(),
                    new OnRequestFinish<BaseBean<String>>() {
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

    private void requestWeddingTypes(final boolean showDialog){
        LoadDialog.showDialog(this);
        WeddingDictionaryRepository.getInstance(this).getWeddingTypes(new OnCacheRequestFinish<List<WeddingTypsBean>>() {
            @Override
            public void onSuccess(List<WeddingTypsBean> data, boolean fromCache) {
                mTypes = data;
                if(showDialog){
                    showTypes();
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }

            @Override
            public void onFinished() {
                if(showDialog || mEnvironments != null){
                    LoadDialog.CancelDialog();
                }
                if(!showDialog){
                    for (WeddingTypsBean type : mTypes) {
                        if(type.getId() == mData.getWeddingtypeid()){
                            mType = type;
                            edType.setText(mType.getTitle());
                        }
                    }
                }
                if(mIsWaitEdit){
                    if(mEnvironments != null){
                        submitOrder();
                    }else{
                        requestWeddingEnvironments(false);
                    }
                }
            }
        });
    }

    private void requestWeddingEnvironments(final boolean showDialog){
        LoadDialog.showDialog(this);
        WeddingDictionaryRepository.getInstance(this).getWeddingEnvironments(new OnCacheRequestFinish<List<WeddingEnvironmentBean>>() {
            @Override
            public void onSuccess(List<WeddingEnvironmentBean> data, boolean fromCache) {
                mEnvironments = data;
                if(showDialog){
                    showEnvironments();
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }

            @Override
            public void onFinished() {
                if(showDialog || mTypes != null){
                    LoadDialog.CancelDialog();
                }
                if(!showDialog){
                    for (WeddingEnvironmentBean environment : mEnvironments) {
                        if(environment.getId() == mData.getWeddingenvironmentid()){
                            mEnvironment = environment;
                            edHuanjing.setText(mEnvironment.getTitle());
                        }
                    }
                }
                if(mIsWaitEdit){
                    submitOrder();
                }
            }
        });
    }

    private void showTypes(){
        int checkItem = -1;
        String[] values = new String[mTypes == null ? 0 : mTypes.size()];
        String chooseType = edType.getText().toString().trim();
        if(mTypes != null){
            for (int i = 0 ; i < mTypes.size() ; i ++) {
                WeddingTypsBean type = mTypes.get(i);
                values[i] = type.getTitle();
                if(chooseType.equals(type.getTitle())){
                    checkItem = i;
                }
            }
        }
        AlertDialog.Builder dialog = new AlertDialog.Builder(mContext);
        dialog.setTitle("请选择婚礼类型");
        dialog.setSingleChoiceItems(values, checkItem, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                mType = mTypes.get(i);
                edType.setText(mType.getTitle());
            }
        });
        dialog.setPositiveButton("确定", null);
        dialog.show();
    }

    private void showEnvironments(){
        int checkItem = -1;
        String[] values = new String[mEnvironments == null ? 0 : mEnvironments.size()];
        String chooseType = edHuanjing.getText().toString().trim();
        if(mEnvironments != null){
            for (int i = 0 ; i < mEnvironments.size() ; i ++) {
                WeddingEnvironmentBean type = mEnvironments.get(i);
                values[i] = type.getTitle();
                if(chooseType.equals(type.getTitle())){
                    checkItem = i;
                }
            }
        }
        AlertDialog.Builder dialog = new AlertDialog.Builder(mContext);
        dialog.setTitle("请选择环境类型");
        dialog.setSingleChoiceItems(values, checkItem, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                mEnvironment = mEnvironments.get(i);
                edHuanjing.setText(mEnvironment.getTitle());
            }
        });
        dialog.setPositiveButton("确定", null);
        dialog.show();
    }




    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.CAMERA)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(AddExampleActivity.this);
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
                            ToastUtils.showToast(AddExampleActivity.this,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(AddExampleActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(AddExampleActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        int max = type == 1002?9-path.size():1;
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(edName, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(AddExampleActivity.this)
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
                              for (int i = 0; i <result.size() ; i++) {
                                  String availablePath = result.get(i).getAvailablePath();
                                  if (availablePath.startsWith("content://")){
                                      availablePath = result.get(i).getRealPath();
                                  }
                                  path.add(availablePath);
                              }
                              mAdapter.notifyDataSetChanged();
                          }
                          if (type == 1003){
                              String availablePath = result.get(0).getAvailablePath();
                              if (availablePath.startsWith("content://")){
                                  availablePath = result.get(0).getRealPath();
                              }
                              path_fengmian = availablePath;
                              NToast.log("size=====", "" + path.size());
                              GlideLoad.GlideLoadImg(mContext, path_fengmian, ivFengmian);
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
                                for (int i = 0; i <result.size() ; i++) {
                                    String availablePath = result.get(i).getAvailablePath();
                                    if (availablePath.startsWith("content://")){
                                        availablePath = result.get(i).getRealPath();
                                    }
                                    path.add(availablePath);
                                }
                                mAdapter.notifyDataSetChanged();
                            }
                            if (type == 1003){
                                String availablePath = result.get(0).getAvailablePath();
                                if (availablePath.startsWith("content://")){
                                    availablePath = result.get(0).getRealPath();
                                }
                                path_fengmian = availablePath;
                                NToast.log("size=====", "" + path.size());
                                GlideLoad.GlideLoadImg(mContext, path_fengmian, ivFengmian);
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


    @OnClick({R.id.ll_choose_time, R.id.ll_save,  R.id.tv_time, R.id.ll_choose_fengmian, R.id.ll_wedding_environment, R.id.ll_wedding_type})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_save:
                if(check()){
                    addExample();
                }
                break;
            case R.id.ll_choose_time:
            case R.id.tv_time:
                HideKeyboard(view);
                new TimeSeletctUtil(AddExampleActivity.this)
                        .isWhen(true)
                        .setListener(new TimeSeletctUtil.getDataListener() {
                            @Override
                            public void getData(int year, int month, int day, String when) {
                                tvTime.setText(year + "年" + (month + 1) + "月" + day + "日  ");
                                mTime = new TimeFormatter(year, month, day);
                                com.linzi.xiguwen.utils.LogUtil.i("SystemOut", String.valueOf(mTime.getFormatDate()));
                            }

                            @Override
                            public void getToday(int toyear, int tomonth, int today) {

                            }

                            @Override
                            public void getHous(int hour, int m) {

                            }
                        }).isWhen(false).selectDate(llParent);
                break;
            case R.id.ll_choose_fengmian:
//                ImageSelect.ActivityImageSelectMore(AddExampleActivity.this, mContext, 1, new ArrayList<String>(), 1003);
                showPop(1003);
                break;
            case R.id.ll_wedding_environment:
                // 婚礼环境
                if(mEnvironments == null){
                    requestWeddingEnvironments(true);
                }else{
                    showEnvironments();
                }
                break;
            case R.id.ll_wedding_type:
                // 婚礼类型
                if(mTypes == null){
                    requestWeddingTypes(true);
                }else{
                    showTypes();
                }
                break;
        }
    }

}

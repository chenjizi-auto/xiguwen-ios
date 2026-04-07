package com.linzi.xiguwen.ui;
import android.os.Build;
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
import androidx.fragment.app.FragmentActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AddAdapter;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginHepler;
import com.linzi.xiguwen.utils.LoginHeplerListener;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
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

public class AddActivitiesActivity extends FragmentActivity implements LoginHeplerListener {

    @BindView(R.id.ed_context)
    EditText edContext;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.iv_add_img)
    TextView ivAddImg;
    @BindView(R.id.iv_add_biaoqing)
    ImageView ivAddBiaoqing;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.tv_last_page)
    TextView tvLastPage;
    @BindView(R.id.ll_back)
    LinearLayout llBack;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.tv_right)
    TextView tvRight;
    @BindView(R.id.ll_right)
    LinearLayout llRight;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    @BindView(R.id.ll_bar2)
    LinearLayout llBar2;

    private ArrayList<String> path = new ArrayList<>();

    AddAdapter mADapter;
//    @BindView(R.id.ll_parent)
//    RelativeLayout llParent;

    private String content;
    private List<String> pathList;

    private List<File> thumbImages = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            //getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(AddActivitiesActivity.this, R.color.white);
            StatusBarUtil.setNavigationBarColor(AddActivitiesActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_add_activities);
        ButterKnife.bind(this);
        initData();
    }

    private void addSave() {
        content = Preferences.getString(Preferences.SYNAMIC_CONTENT);
        if (!AppUtil.isEmpty(content)) {
            edContext.setText(content);
        }
        String image = Preferences.getString(Preferences.SYNAMIC_IMAGE);
        if (!AppUtil.isEmpty(image)) {
            try {
                pathList = JSONArray.parseArray(image, String.class);
                path.clear();
                path.addAll(pathList);
                mADapter.notifyDataSetChanged();
            } catch (Exception e) {
            }
        }

    }


    private void save() {
        content = edContext.getText().toString();
        if (!AppUtil.isEmpty(content)) {
            Preferences.saveString(Preferences.SYNAMIC_CONTENT, content);
        }
        if (!AppUtil.isEmpty(pathList)) {
            Preferences.saveString(Preferences.SYNAMIC_IMAGE, JSON.toJSONString(pathList));
        }
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        save();
    }

    public void setBack() {
        llBack.setVisibility(View.VISIBLE);
        llBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
    }

    public void setBack(String lastPage, View.OnClickListener clickListener) {
        llBack.setVisibility(View.VISIBLE);
        ivBack.setVisibility(View.GONE);
        tvLastPage.setText(lastPage);
        llBack.setOnClickListener(clickListener);
    }


    public void setRight(String title, View.OnClickListener listener) {
        tvRight.setText(title);
        llRight.setVisibility(View.VISIBLE);
        llRight.setOnClickListener(listener);
    }


    protected void initData() {

//        //获得状态栏高度
//        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(AddActivitiesActivity.this));
//        llBar2.setLayoutParams(params);
//        // ViewCompat.setAlpha(llBar, 0);
//        llBar2.setBackgroundColor(AddActivitiesActivity.this.getResources().getColor(R.color.white));

        tvTitle.setText("写动态");
        setTitle("写动态");
        setBack("取消", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                showAskPop(llParent);
                save();
                finish();
            }
        });
        setRight("发布  ", new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                LoginHepler.LoginHepler(AddActivitiesActivity.this, 200, true, AddActivitiesActivity.this);
//                dynamicPublish();
            }
        });
        GridLayoutManager manager = new GridLayoutManager(this, 3);
        recycle.setLayoutManager(manager);

        mADapter = new AddAdapter(this, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
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
        }, path);
        recycle.setAdapter(mADapter);

        addSave();
    }
    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.CAMERA,Permission.MANAGE_EXTERNAL_STORAGE)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(AddActivitiesActivity.this);
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
                            ToastUtils.showToast(AddActivitiesActivity.this,"被永久拒绝授权，请手动授予相机权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(AddActivitiesActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(AddActivitiesActivity.this,"获取存储权限失败");
                        }
                    }
                });
    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(edContext, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(AddActivitiesActivity.this)
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
                            mADapter.notifyDataSetChanged();
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


    private void dynamicPublish() {
//        content = edContext.getText().toString().trim();
//        if (AppUtil.isEmpty(content)) {
//            ToastUtils.showToast(this, "请输入发表内容");
//            return;
//        }
//        LoadDialog.showDialog(this);
        ApiManager.dynamicPublish(content, thumbImages, new OnRequestSubscribe<BaseBean<String>>() {
            @Override
            public void onSuccess(BaseBean<String> data) {
                ToastUtils.showToast(AddActivitiesActivity.this, data.getMessage());
                Preferences.saveString(Preferences.SYNAMIC_CONTENT, "");
                Preferences.saveString(Preferences.SYNAMIC_IMAGE, "");
                LoadDialog.CancelDialog();
                finish();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(AddActivitiesActivity.this, ex.getMessage());

            }
        });
    }

    @OnClick({R.id.iv_add_img, R.id.iv_add_biaoqing})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.iv_add_img:
                showPop(1002);
                break;
            case R.id.iv_add_biaoqing:

                break;
        }
    }

 /*   private void showAskPop(View llParent) {
        View view = LayoutInflater.from(this).inflate(R.layout.pop_exit_activities_layout, null);
        ViewHolder vh = new ViewHolder(view);
        final PopupWindow pop = new PopupWindow(this);

        vh.llClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pop.dismiss();
            }
        });

        vh.llNoSave.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });

        vh.llSave.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });

        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = this.getWindowManager().getDefaultDisplay().getWidth();
//        int h = (this.getWindowManager().getDefaultDisplay().getHeight() / 5)*2;
        pop.setWidth(w);
//        pop.setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(view);
        pop.update();
        pop.showAtLocation(llParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });
    }*/

    @Override
    public void loginOpinion(int code) {
//        dynamicPublish();

        content = edContext.getText().toString().trim();
        if (AppUtil.isEmpty(content)) {
            ToastUtils.showToast(this, "请输入发表内容");
            return;
        }
        if (!AppUtil.isEmpty(path)) {
            compress(path);
        } else {
            LoadDialog.showDialog(this);
            dynamicPublish();
        }

    }

    class ViewHolder {
        @BindView(R.id.ll_save)
        LinearLayout llSave;
        @BindView(R.id.ll_no_save)
        LinearLayout llNoSave;
        @BindView(R.id.ll_close)
        LinearLayout llClose;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }


    private void compress(final List<String> photos) {
        photoIndex = 0;
        if (thumbImages != null) {
            thumbImages.clear();
        }
        for (int i = 0; i < photos.size(); i++) {
            showResult(photos, new File(photos.get(i)));
        }

    }

    int photoIndex = 0;

    private void showResult(List<String> photos, File file) {
        photoIndex++;
        if (file != null) {
            thumbImages.add(file);
        }
        if (photoIndex == photos.size()) {
            dynamicPublish();
        }
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

package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;

import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.StatusBarUtil;

import butterknife.BindView;

public class QingjianYulanActivity extends BaseWebViewActivity {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.bt_create)
    Button btCreate;

    private int type; // 页面类型
    private int id;     // 请柬id
    private String mUrl;

    public static void startActivity(Context context, String url) {
        Intent intent = new Intent(context, QingjianYulanActivity.class);
        intent.putExtra("url", url);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(QingjianYulanActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(QingjianYulanActivity.this, R.color.white);
        }
//        type=getIntent().getIntExtra("type",0);
//        id=getIntent().getIntExtra("id",0);
        mUrl = getIntent().getStringExtra("url");
        initView();
        if(mUrl != null){
            loadUrl(mUrl);
        }
    }

    @Override
    public int getContentView() {
        return R.layout.activity_qingjian_yulan;
    }

    private void initView(){
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(QingjianYulanActivity.this));
        llBar.setLayoutParams(params);
        btCreate.setVisibility(View.GONE);

        ivBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
    }

    private void getUrl(){
        LoadDialog.showDialog(this);
//       ApiManager.getInvitationUrl(SPUtil.get("token", ""), SPUtil.get("userid", 0), id, 1, new Callback.CommonCallback<String>() {
//            @Override
//            public void onSuccess(String result) {
//                NToast.log("dizhi",result);
//                InvitationUrlBean base= JSONObject.parseObject(result,InvitationUrlBean.class);
//                if(base.getCode()==0){
//                    mUrl=base.getUrl();
//                    loadUrl(mUrl);
//                }else{
//                    NToast.show(base.getMessage());
//                }
//            }
//
//            @Override
//            public void onError(Throwable ex, boolean isOnCallback) {
//                //请求失败。。
//            }
//
//            @Override
//            public void onCancelled(CancelledException cex) {
//
//            }
//
//            @Override
//            public void onFinished() {
//                LoadDialog.CancelDialog();
//            }
//        });
    }
}

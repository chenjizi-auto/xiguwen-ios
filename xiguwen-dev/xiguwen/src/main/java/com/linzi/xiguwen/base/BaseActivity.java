package com.linzi.xiguwen.base;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.lljjcoder.style.citypickerview.CityPickerView;


import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/10/30.
 */

public abstract class BaseActivity extends AppCompatActivity {

    protected String TAG = getClass().getSimpleName();
    public Context mContext;

    private TextView tvLastPage;
    private LinearLayout llBack, llClose;
    private TextView tvTitle, tvRight;
    private LinearLayout llRight, llRightAdd;
    private LinearLayout llParent, llBar;
    private RelativeLayout llTitle;
    private ImageView ivRight, iv_back;
    private View line;

    /**
     * 隐藏键盘
     *
     * @param view
     */
    public static void hideKeyboard(View view) {
        InputMethodManager imm = (InputMethodManager) view.getContext()
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        if (imm != null) {
            imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
        }
    }


    /**
     * 弹键盘
     *
     * @param view
     */
    public static void showKeyboard(View view) {
        InputMethodManager imm = (InputMethodManager) view.getContext()
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        if (imm != null) {
            imm.showSoftInput(view, 0);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        NToast.log("oncreate",getClass().getCanonicalName().toString());
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(BaseActivity.this, R.color.white);
            StatusBarUtil.setNavigationBarColor(BaseActivity.this, R.color.white);
        }

        super.setContentView(R.layout.activity_base);

        tvLastPage = (TextView) findViewById(R.id.tv_last_page);
        tvTitle = (TextView) findViewById(R.id.tv_title);
        tvRight = (TextView) findViewById(R.id.tv_right);
        llBack = (LinearLayout) findViewById(R.id.ll_back);
        llClose = (LinearLayout) findViewById(R.id.ll_close);
        llRight = (LinearLayout) findViewById(R.id.ll_right);
        llRightAdd = (LinearLayout) findViewById(R.id.ll_right_add);
        llParent = (LinearLayout) findViewById(R.id.ll_parent);
        llTitle = (RelativeLayout) findViewById(R.id.ll_title);
        llBar = (LinearLayout) findViewById(R.id.ll_bar);
        ivRight = (ImageView) findViewById(R.id.iv_right);
        iv_back = (ImageView) findViewById(R.id.iv_back);
        line = findViewById(R.id.line);

        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(BaseActivity.this));
        llBar.setLayoutParams(params);

        mContext = this;

        StringBuffer stringBuffer = new StringBuffer();
        for (int i = 0; i < 5; i++) {
            stringBuffer.append(" ");
        }
    }

    public void setTopBarVisibility(int visibility) {
        llTitle.setVisibility(visibility);
        line.setVisibility(visibility);
    }

    public LinearLayout getLlBar(){
        return  llBar;
    }

    public void setContentView(int layoutResID) {
        View view = LayoutInflater.from(this).inflate(layoutResID, llParent, false);
        llParent.removeAllViews();
        ButterKnife.bind(this, view);
        llParent.addView(view);
        initData();
    }

    public void setTitle(String title) {
        tvTitle.setText(title);
    }

    public void setTitle(int id) {
        tvTitle.setText("");
        tvTitle.setBackgroundResource(id);
    }

    public void setTitleClickListener(View.OnClickListener listener) {
        if (tvTitle != null) {
            tvTitle.setOnClickListener(listener);
        }
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

    public LinearLayout getLlBack(){
        return llBack;
    }

    public void setBack(String lastPage, View.OnClickListener clickListener) {
        llBack.setVisibility(View.VISIBLE);
        iv_back.setVisibility(View.GONE);
        tvLastPage.setText(lastPage);
        llBack.setOnClickListener(clickListener);
    }

    public void setClose(View.OnClickListener clickListener) {
        llBack.setVisibility(View.GONE);
        llClose.setVisibility(View.VISIBLE);
        llClose.setOnClickListener(clickListener);
    }

    public void setRight(String title, View.OnClickListener listener) {
        tvRight.setText(title);
        llRight.setVisibility(View.VISIBLE);
        llRight.setOnClickListener(listener);
    }

    public void setRightClickAble(boolean boo) {
        llRight.setClickable(boo);
    }

    public void setRight(String title) {
        tvRight.setText(title);
        llRight.setVisibility(View.VISIBLE);
    }

    public void setRightAdd(View.OnClickListener listener) {
        ivRight.setImageDrawable(mContext.getResources().getDrawable(R.mipmap.icon_right_add));
        llRightAdd.setVisibility(View.VISIBLE);
        llRightAdd.setOnClickListener(listener);
    }

    public void setRightAdd(int id, View.OnClickListener listener) {
        ivRight.setImageDrawable(mContext.getResources().getDrawable(id));
        llRightAdd.setVisibility(View.VISIBLE);
        llRightAdd.setOnClickListener(listener);
    }

    public void intent(Class<?> cla) {
        Intent intent = new Intent(mContext, cla);
        startActivity(intent);
    }

//    public CityPicker getCity(String provice, String city, String district) {
//        if (provice == null) {
//            provice = "四川省";
//            city = "成都市";
//            district = "武侯区";
//        }
//        return new CityPicker.Builder(mContext).textSize(20)
//                .titleTextColor("#000000")
//                .backgroundPop(0xa0000000)
//                .province(provice)
//                .city(city)
//                .district(district)
//                .textColor(Color.parseColor("#000000"))
//                .provinceCyclic(true)
//                .cityCyclic(false)
//                .districtCyclic(false)
//                .visibleItemsCount(5)
//                .itemPadding(10)
//                .build();
//    }

//    public CityPicker getCity(String provice, String city) {
//        if (provice == null) {
//            provice = "四川省";
//            city = "成都市";
//        }
//        return new CityPicker.Builder(mContext).textSize(20)
//                .titleTextColor("#000000")
//                .backgroundPop(0xa0000000)
//                .province(provice)
//                .city(city)
//                .textColor(Color.parseColor("#000000"))
//                .provinceCyclic(true)
//                .cityCyclic(false)
//                .onlyShowProvinceAndCity(true)
//                .visibleItemsCount(5)
//                .itemPadding(10)
//                .build();
//    }

    public void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        getWindow().setAttributes(lp);
    }

    /**
     * 显示键盘
     *
     * @param context
     * @param view
     */
    public void showInputMethod(Context context, View view) {
        InputMethodManager im = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
//        im.showSoftInput(view, 0);
        im.toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);
    }

    //隐藏虚拟键盘
    public void HideKeyboard(View v) {
        InputMethodManager imm = (InputMethodManager) v.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
        if (imm.isActive()) {
            imm.hideSoftInputFromWindow(v.getApplicationWindowToken(), 0);
        }
    }


    //将dp转换为px
    public int dip2px(float dpValue) {
        final float scale = mContext.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    protected abstract void initData();

}

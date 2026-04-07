package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;

import butterknife.BindView;
import butterknife.ButterKnife;


/**
 * Created by pc on 2019/3/6.
 */

public class OrderSearchActivity extends AppCompatActivity {

    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.tv_close)
    TextView tvClose;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    private String content;
    private int intentType;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(OrderSearchActivity.this, R.color.white);
            StatusBarUtil.setNavigationBarColor(OrderSearchActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_order_search);
        ButterKnife.bind(this);
        initView();
    }

    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(OrderSearchActivity.this));
        llBar.setLayoutParams(params);
// ViewCompat.setAlpha(llBar, 0);
        llBar.setBackgroundColor(OrderSearchActivity.this.getResources().getColor(R.color.white));
        intentType = getIntent().getIntExtra("intentType", -1);
        tvClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (tvClose.getText().toString().equals("搜索")) {
                    search();
                }
                finish();
            }
        });


        edSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                content = edSearch.getText().toString().trim();
                if (!AppUtil.isEmpty(content)) {
                    tvClose.setText("搜索");
                } else {
                    tvClose.setText("取消");
                }
            }
        });
    }

    private void search() {
        Intent intent = new Intent(this, OrderSearchResultActivity.class);
        intent.putExtra("intentType", intentType);
        intent.putExtra("content", content);
        startActivity(intent);
    }
}

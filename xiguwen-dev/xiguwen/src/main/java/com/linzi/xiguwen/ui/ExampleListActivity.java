package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.PopupWindow;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ExampleFragmentAdapter;
import com.linzi.xiguwen.adapter.PopArrowAdapter;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.view.CusRadioButton;

import java.util.Arrays;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ExampleListActivity extends AppCompatActivity {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.ll_back)
    LinearLayout llBack;
    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.rb_all)
    CusRadioButton rbAll;
    @BindView(R.id.rb_location)
    CusRadioButton rbLocation;
    @BindView(R.id.rb_sort)
    CusRadioButton rbSort;
    @BindView(R.id.rb_saixuan)
    CusRadioButton rbSaixuan;
    @BindView(R.id.ll_group)
    LinearLayout llGroup;
    @BindView(R.id.hot_recycle)
    RecyclerView hotRecycle;

    Context mContext;

    String[] arrow = {"全部", "策划师", "摄像师", "主持人", "化妆师", "摄影师", "灯光师", "音响师"};
    private int position_all=0;

    ExampleFragmentAdapter mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(ExampleListActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_example_list);
        ButterKnife.bind(this);
        mContext=this;
        initView();
    }

    private void initView(){
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(ExampleListActivity.this));
        llBar.setLayoutParams(params);

        rbAll.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                setPop(llGroup,arrow);
            }
        });

        LinearLayoutManager manager=new LinearLayoutManager(this){
            @Override
            public boolean canScrollVertically() {
                // 直接禁止垂直滑动
                return false;
            }
        };
        hotRecycle.setLayoutManager(manager);
        mAdapter=new ExampleFragmentAdapter(this, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent=new Intent(mContext, ExampleDetailsActivity.class);
                startActivity(intent);
            }
        });
        hotRecycle.setAdapter(mAdapter);
        
    }

    private void setPop(View parent, final String[]arro) {
        final PopupWindow pop = new PopupWindow(this);
        View view = LayoutInflater.from(this).inflate(R.layout.pop_layout_arrow_list, null);
        PopView pv=new PopView(view);
        LinearLayoutManager manager=new LinearLayoutManager(this){
            @Override
            public boolean canScrollVertically() {
                // 直接禁止垂直滑动
                return false;
            }
        };
        pv.popRecycle.setLayoutManager(manager);
        PopArrowAdapter adapter=new PopArrowAdapter(this, Arrays.asList(arro), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                position_all=postion;
                rbAll.setText(arro[postion]);
                pop.dismiss();
            }
        });
        adapter.setSelect(position_all);
        pv.popRecycle.setAdapter(adapter);
        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = this.getWindowManager().getDefaultDisplay().getWidth();
        int h = (this.getWindowManager().getDefaultDisplay().getHeight());
        pop.setWidth(w);
        pop.setHeight(h-(h/3));
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0x00000000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview2);
        pop.setContentView(view);
        pop.update();
        pop.showAsDropDown(parent);
    }

    class PopView {
        @BindView(R.id.pop_recycle)
        RecyclerView popRecycle;
        @BindView(R.id.ll_bg)
        LinearLayout llBg;

        PopView(View view) {
            ButterKnife.bind(this, view);
        }
    }
}

package com.linzi.xiguwen.view;

import android.content.Context;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.scwang.smartrefresh.layout.api.RefreshFooter;
import com.scwang.smartrefresh.layout.api.RefreshKernel;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.constant.RefreshState;
import com.scwang.smartrefresh.layout.constant.SpinnerStyle;
import com.scwang.smartrefresh.layout.util.DensityUtil;

/**
 * Created by pc on 2018/3/21.
 */

public class MyRefreshFooter extends LinearLayout implements RefreshFooter {

    private TextView mHeaderText;//标题文本

    public MyRefreshFooter(Context context) {
        super(context);
        initView(context);
    }

    public MyRefreshFooter(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        initView(context);
    }

    public MyRefreshFooter(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initView(context);
    }

    @NonNull
    @Override
    public View getView() {
        return this;//真实的视图就是自己，不能返回null
    }

    @NonNull
    @Override
    public SpinnerStyle getSpinnerStyle() {
        return SpinnerStyle.Translate;//指定为平移，不能null
    }

    @Override
    public void setPrimaryColors(int... colors) {

    }

    @Override
    public void onInitialized(@NonNull RefreshKernel kernel, int height, int extendHeight) {

    }

    @Override
    public void onMoving(boolean isDragging, float percent, int offset, int height, int extendHeight) {

    }

    @Override
    public void onReleased(@NonNull RefreshLayout refreshLayout, int height, int extendHeight) {

    }

    @Override
    public void onStartAnimator(@NonNull RefreshLayout refreshLayout, int height, int extendHeight) {
    }

    @Override
    public int onFinish(@NonNull RefreshLayout refreshLayout, boolean success) {
        if (success) {
            mHeaderText.setText("加载完成");
        } else {
            mHeaderText.setText("加载失败");
        }
        return 0;//延迟200毫秒之后再弹回
    }

    @Override
    public void onHorizontalDrag(float percentX, int offsetX, int offsetMax) {

    }

    @Override
    public boolean isSupportHorizontalDrag() {
        return false;
    }

    @Override
    public void onStateChanged(@NonNull RefreshLayout refreshLayout, @NonNull RefreshState oldState, @NonNull RefreshState newState) {
        switch (newState) {
            case None:
            case PullDownToRefresh:
                mHeaderText.setText("加载更多...");
                break;
            case Refreshing:
                mHeaderText.setText("正在加载...");
                break;
        }
    }

    private void initView(Context context) {
        setGravity(Gravity.CENTER);
        mHeaderText = new TextView(context);
        addView(new View(context), DensityUtil.dp2px(20), DensityUtil.dp2px(20));
        addView(mHeaderText, LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        setMinimumHeight(DensityUtil.dp2px(60));
    }

    @Override
    public boolean setNoMoreData(boolean noMoreData) {
        mHeaderText.setText("没有更多数据了");
        return noMoreData;
    }
}

package com.linzi.xiguwen.view;

import android.content.Context;
import androidx.viewpager.widget.ViewPager;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import com.linzi.xiguwen.utils.NToast;

import java.util.HashMap;

/**
 * Created by jiang on 2017/12/21.
 */

public class CustomViewPager extends ViewPager {

    private int current;
    private int height = 0;
    /**
     * 保存position与对于的View
     */
    private HashMap<Integer, View> mChildrenViews = new HashMap<Integer, View>();
    private HashMap<Integer, Integer> mHeight = new HashMap<Integer, Integer>();

    private boolean scrollble = true;

    public CustomViewPager(Context context) {
        super(context);
    }

    public CustomViewPager(Context context, AttributeSet attrs) {
        super(context, attrs);
    }


    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        if (mChildrenViews.size() > current) {
            View child = mChildrenViews.get(current);
            child.measure(widthMeasureSpec, MeasureSpec.makeMeasureSpec(0, MeasureSpec.UNSPECIFIED));
            if(mHeight.size()!=mChildrenViews.size()) {
                mHeight.put(current,child.getMeasuredHeight());
//                heightMeasureSpec = MeasureSpec.makeMeasureSpec(height, MeasureSpec.EXACTLY);
            }
                height = mHeight.get(current);
                heightMeasureSpec = MeasureSpec.makeMeasureSpec(height, MeasureSpec.EXACTLY);

        }
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
    }

    public void resetHeight(int current) {
        this.current = current;
        NToast.log("xxxxxxxxxxx====",""+current);
        if (mChildrenViews.size() > current) {
            View child=mChildrenViews.get(current);
            ViewGroup.LayoutParams prams=child.getLayoutParams();
            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,prams.height);
            setLayoutParams(layoutParams);
        }
    }
    /**
     * 保存position与对于的View
     */
    public void setObjectForPosition(View view, int position)
    {
        mChildrenViews.put(position, view);
    }


    @Override
    public boolean onTouchEvent(MotionEvent ev) {
        if (!scrollble) {
            return true;
        }
        return super.onTouchEvent(ev);
    }


    public boolean isScrollble() {
        return scrollble;
    }

    public void setScrollble(boolean scrollble) {
        this.scrollble = scrollble;
    }
}

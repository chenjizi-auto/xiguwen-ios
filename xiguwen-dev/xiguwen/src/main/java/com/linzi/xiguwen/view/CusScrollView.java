package com.linzi.xiguwen.view;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ScrollView;

/**
 * Created by jiang on 2017/12/15.
 */

public class CusScrollView extends ScrollView {

    public interface ScrollViewListener {

        void onScrollChanged(CusScrollView scrollView, int x, int y, int oldx, int oldy);

    }

    private ScrollViewListener mListener=null;

    public CusScrollView(Context context) {
        super(context);
    }

    public CusScrollView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public CusScrollView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    public void setScrollViewListener(ScrollViewListener scrollViewListener) {
        this.mListener = scrollViewListener;
    }

    @Override
    protected void onScrollChanged(int x, int y, int oldx, int oldy) {
        super.onScrollChanged(x, y, oldx, oldy);
        if (mListener != null) {
            mListener.onScrollChanged(this, x, y, oldx, oldy);
        }
    }


}

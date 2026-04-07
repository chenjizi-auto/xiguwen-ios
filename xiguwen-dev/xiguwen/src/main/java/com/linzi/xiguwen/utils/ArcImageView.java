package com.linzi.xiguwen.utils;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PaintFlagsDrawFilter;
import android.graphics.Path;

import androidx.annotation.Nullable;
import android.util.AttributeSet;
import android.widget.ImageView;

import com.linzi.xiguwen.R;

/**
 * Created by jiang on 2018/1/2.
 */

public class ArcImageView extends ImageView {
    /*
     *弧形高度
     */
    private int mArcHeight;
    private boolean mOut_In = true;
    private static final String TAG = "ArcImageView";

    public ArcImageView(Context context) {
        this(context, null);
    }

    public ArcImageView(Context context, @Nullable AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public ArcImageView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        TypedArray typedArray = context.obtainStyledAttributes(attrs, R.styleable.ArcImageView);
        mArcHeight = typedArray.getDimensionPixelSize(R.styleable.ArcImageView_arcHeight, 0);
        mOut_In = typedArray.getBoolean(R.styleable.ArcImageView_arcOutOrIn, true);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        canvas.setDrawFilter(new PaintFlagsDrawFilter(0, Paint.ANTI_ALIAS_FLAG | Paint.FILTER_BITMAP_FLAG));
        Path path = new Path();
        path.moveTo(0, 0);
//        path.lineTo(0, getHeight());
        if (mOut_In) {
            path.lineTo(0, getHeight() - mArcHeight);
            path.quadTo(getWidth() / 2, getHeight() + mArcHeight, getWidth(), getHeight() - mArcHeight);
        } else {
            path.lineTo(0, getHeight());
            path.quadTo(getWidth() / 2, getHeight() - mArcHeight, getWidth(), getHeight());
        }
        path.lineTo(getWidth(), 0);
        path.close();

        canvas.clipPath(path);
        super.onDraw(canvas);
    }

    //将dp转换为px
    public int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

}

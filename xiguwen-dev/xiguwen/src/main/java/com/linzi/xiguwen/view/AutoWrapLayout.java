package com.linzi.xiguwen.view;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;

public class AutoWrapLayout extends ViewGroup {

    private int horizontalSpace;
    private int verticalSpace;
    private WrapAdapter adapter;

    public AutoWrapLayout(Context context) {
        this(context, null);
    }

    public AutoWrapLayout(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public AutoWrapLayout(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        int defaultHorizontalSpace = 0;
        int defaultVerticalSpace = 0;
        TypedArray typedArray = context.obtainStyledAttributes(attrs, R.styleable.autoWrap);
        horizontalSpace = typedArray.getDimensionPixelSize(
                R.styleable.autoWrap_horizontalSpace, defaultHorizontalSpace);
        verticalSpace = typedArray.getDimensionPixelSize(
                R.styleable.autoWrap_verticalSpace, defaultVerticalSpace);
        typedArray.recycle();
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int widthMode = MeasureSpec.getMode(widthMeasureSpec);
        int widthSize = MeasureSpec.getSize(widthMeasureSpec);
        int heightMode = MeasureSpec.getMode(heightMeasureSpec);
        int heightSize = MeasureSpec.getSize(heightMeasureSpec);

        int maxLineWidth = widthMode == MeasureSpec.UNSPECIFIED
                ? Integer.MAX_VALUE
                : Math.max(0, widthSize - getPaddingLeft() - getPaddingRight());

        int measuredWidth = 0;
        int measuredHeight = getPaddingTop() + getPaddingBottom();
        int lineWidth = 0;
        int lineHeight = 0;
        int childCount = getChildCount();

        for (int i = 0; i < childCount; i++) {
            View child = getChildAt(i);
            if (child.getVisibility() == GONE) {
                continue;
            }

            measureChildWithMargins(child, widthMeasureSpec, 0, heightMeasureSpec, measuredHeight);
            MarginLayoutParams lp = (MarginLayoutParams) child.getLayoutParams();
            int childWidth = child.getMeasuredWidth() + lp.leftMargin + lp.rightMargin;
            int childHeight = child.getMeasuredHeight() + lp.topMargin + lp.bottomMargin;

            boolean newLine = lineWidth > 0 && lineWidth + horizontalSpace + childWidth > maxLineWidth;
            if (newLine) {
                measuredWidth = Math.max(measuredWidth, lineWidth);
                measuredHeight += lineHeight + verticalSpace;
                lineWidth = childWidth;
                lineHeight = childHeight;
            } else {
                if (lineWidth > 0) {
                    lineWidth += horizontalSpace;
                }
                lineWidth += childWidth;
                lineHeight = Math.max(lineHeight, childHeight);
            }
        }

        if (lineWidth > 0 || childCount == 0) {
            measuredWidth = Math.max(measuredWidth, lineWidth);
            measuredHeight += lineHeight;
        }

        measuredWidth += getPaddingLeft() + getPaddingRight();

        int finalWidth = resolveSize(measuredWidth, widthMeasureSpec);
        int finalHeight = resolveSize(
                heightMode == MeasureSpec.EXACTLY ? heightSize : measuredHeight,
                heightMeasureSpec);
        setMeasuredDimension(finalWidth, finalHeight);
    }

    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        int contentWidth = r - l - getPaddingRight();
        int left = getPaddingLeft();
        int top = getPaddingTop();
        int lineHeight = 0;

        for (int i = 0; i < getChildCount(); i++) {
            View child = getChildAt(i);
            if (child.getVisibility() == GONE) {
                continue;
            }

            MarginLayoutParams lp = (MarginLayoutParams) child.getLayoutParams();
            int childWidth = child.getMeasuredWidth();
            int childHeight = child.getMeasuredHeight();
            int childTotalWidth = childWidth + lp.leftMargin + lp.rightMargin;
            int childTotalHeight = childHeight + lp.topMargin + lp.bottomMargin;

            boolean newLine = left > getPaddingLeft()
                    && left + horizontalSpace + childTotalWidth > contentWidth;
            if (newLine) {
                left = getPaddingLeft();
                top += lineHeight + verticalSpace;
                lineHeight = 0;
            }

            if (left > getPaddingLeft()) {
                left += horizontalSpace;
            }

            int childLeft = left + lp.leftMargin;
            int childTop = top + lp.topMargin;
            child.layout(childLeft, childTop, childLeft + childWidth, childTop + childHeight);

            left += childTotalWidth;
            lineHeight = Math.max(lineHeight, childTotalHeight);
        }
    }

    @Override
    protected LayoutParams generateDefaultLayoutParams() {
        return new MarginLayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
    }

    @Override
    public LayoutParams generateLayoutParams(AttributeSet attrs) {
        return new MarginLayoutParams(getContext(), attrs);
    }

    @Override
    protected LayoutParams generateLayoutParams(LayoutParams p) {
        return new MarginLayoutParams(p);
    }

    @Override
    protected boolean checkLayoutParams(LayoutParams p) {
        return p instanceof MarginLayoutParams;
    }

    public void setAdapter(WrapAdapter adapter) {
        this.adapter = adapter;
        rebuildChildren();
    }

    public void notifyDataSetChanged() {
        rebuildChildren();
    }

    private void rebuildChildren() {
        removeAllViews();
        if (adapter == null) {
            requestLayout();
            return;
        }
        int count = adapter.getItemCount();
        for (int i = 0; i < count; i++) {
            TextView child = adapter.onCreateTextView(i);
            addView(child);
        }
        requestLayout();
    }

    public interface WrapAdapter {
        int getItemCount();

        TextView onCreateTextView(int index);
    }
}

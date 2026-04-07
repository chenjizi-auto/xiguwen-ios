package com.linzi.xiguwen.utils;

import android.app.Activity;
import android.graphics.drawable.ColorDrawable;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class SharePop {
    private Activity mContext;
    private View pop_view;
    private ViewHolder vh;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener listener;

    public SharePop setListener(com.jcodecraeer.xrecyclerview.OnItemClickListener listener) {
        this.listener = listener;
        return this;
    }

    public SharePop(Activity mContext) {
        this.mContext = mContext;
    }

    public void show(View llParent) {
        final PopupWindow pop = new PopupWindow(mContext);
        if (vh == null) {
            pop_view = LayoutInflater.from(mContext).inflate(R.layout.pop_share_layout, null);
            vh = new ViewHolder(pop_view);
            pop_view.setTag(vh);
        } else {
            vh = (ViewHolder) pop_view.getTag();
        }
        vh.llClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pop.dismiss();
            }
        });
        if(listener!=null){
            vh.llShareCir.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(v,0);
                }
            });
            vh.llShareFri.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(v,1);
                }
            });
            vh.llShareQq.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(v,2);
                }
            });
            vh.llShareQzone.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(v,3);
                }
            });
            vh.llShareSina.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(v,4);
                }
            });
            vh.llShareMsg.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(v,5);
                }
            });
        }
        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = mContext.getWindowManager().getDefaultDisplay().getWidth();
//        int h = (this.getWindowManager().getDefaultDisplay().getHeight() / 2);
        pop.setWidth(w);
//        pop.setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(pop_view);
        pop.update();
        pop.showAtLocation(llParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });
    }

    private void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = mContext.getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        mContext.getWindow().setAttributes(lp);
    }

    class ViewHolder {
        @BindView(R.id.ll_share_cir)
        LinearLayout llShareCir;
        @BindView(R.id.ll_share_fri)
        LinearLayout llShareFri;
        @BindView(R.id.ll_share_qq)
        LinearLayout llShareQq;
        @BindView(R.id.ll_share_qzone)
        LinearLayout llShareQzone;
        @BindView(R.id.ll_share_sina)
        LinearLayout llShareSina;
        @BindView(R.id.ll_share_msg)
        LinearLayout llShareMsg;
        @BindView(R.id.ll_close)
        LinearLayout llClose;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}


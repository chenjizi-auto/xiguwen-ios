package com.linzi.xiguwen.utils;

import android.app.Activity;
import android.graphics.drawable.ColorDrawable;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/3.
 */

public class PopChooserUtils {
    private Activity mActivity;
    private ItemClickListener mListener;
    private String[] ChooserData;
    private PopupWindow pop;

    public interface ItemClickListener {
        public void popItemClick(View view, int position);
    }

    public PopChooserUtils(Activity mActivity) {
        this.mActivity = mActivity;
        pop = new PopupWindow(mActivity);
    }

    public PopChooserUtils setListenner(ItemClickListener listener) {
        mListener = listener;
        return this;
    }

    public PopChooserUtils setChooseData(String[] data) {
        ChooserData = data;
        return this;
    }

    public PopChooserUtils show(View llParent) {
        View view = LayoutInflater.from(mActivity).inflate(R.layout.pop_choose_util_layout, null);
        ViewHolder vh = new ViewHolder(view);
        vh.llClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pop.dismiss();
            }
        });
        LinearLayoutManager manager=new LinearLayoutManager(mActivity){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.recycle.setLayoutManager(manager);
        vh.recycle.setAdapter(new itemAdapter());

        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = mActivity.getWindowManager().getDefaultDisplay().getWidth();
        int h = (mActivity.getWindowManager().getDefaultDisplay().getHeight()/5)*2;
        pop.setWidth(w);
        pop.setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0x00000000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(view);
        pop.update();
        pop.showAtLocation(llParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });

        return this;
    }

    public void dismiss(){
        if (pop!=null) {
            pop.dismiss();
        }
    }

    class itemAdapter extends RecyclerView.Adapter<itemAdapter.VH> {

        @Override
        public itemAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mActivity).inflate(R.layout.item_pop_chooser_util_layout, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(itemAdapter.VH vh, final int position) {
            vh.tvChooseItem.setText(ChooserData[position]);
            if(mListener!=null){
                vh.llChooserItem.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        mListener.popItemClick(view,position);
                        pop.dismiss();
                    }
                });
            }
        }

        @Override
        public int getItemCount() {
            return ChooserData == null ? 0 : ChooserData.length;
        }

        class VH extends RecyclerView.ViewHolder{
            @BindView(R.id.tv_choose_item)
            TextView tvChooseItem;
            @BindView(R.id.ll_chooser_item)
            LinearLayout llChooserItem;

            VH(View view) {
                super(view);
                ButterKnife.bind(this, view);
            }
        }
    }

    private void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = mActivity.getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        mActivity.getWindow().setAttributes(lp);
    }

    class ViewHolder {
        @BindView(R.id.recycle)
        RecyclerView recycle;
        @BindView(R.id.ll_close)
        LinearLayout llClose;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}

package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.RecyclerView.Adapter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.NewIndexBean;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.location.JumpUtil;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/11/26.
 */

public class HotMallListAdapter extends Adapter<HotMallListAdapter.ViewHolder> {
    private Context mContext;
    private NewIndexBean bean;
    private CallBack.OnMenuItemClickListener itemClickListener;
    private int type;//1个人 0团队

    public HotMallListAdapter(Context mContext, NewIndexBean bean, int type, CallBack.OnMenuItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.bean = bean;
        this.itemClickListener = itemClickListener;
        this.type = type;
    }

    public HotMallListAdapter(Context mContext, NewIndexBean bean, int type) {
        this.mContext = mContext;
        this.bean = bean;
        this.type = type;
    }

    @Override
    public HotMallListAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_hot_mall_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(HotMallListAdapter.ViewHolder vh, int position) {
        if (type == 1) {
            GlideLoad.GlideLoadImg2(bean.getRemengeren().getData().get(position).getWapimg(), vh.ivMallImg);
            vh.tvMallName.setText(bean.getRemengeren().getData().get(position).getTitle());
        } else {
            GlideLoad.GlideLoadImg2(bean.getRementuandui().getData().get(position).getWapimg(), vh.ivMallImg);
            vh.tvMallName.setText(bean.getRementuandui().getData().get(position).getTitle());
        }
    }

    @Override
    public int getItemCount() {
        if (type == 1) {
            return bean.getRemengeren().getData() == null ? 0 : bean.getRemengeren().getData().size();
        } else {
            return bean.getRementuandui().getData() == null ? 0 : bean.getRementuandui().getData().size();
        }


    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_mall_img)
        ImageView ivMallImg;
        @BindView(R.id.tv_mall_name)
        TextView tvMallName;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (itemClickListener == null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        if (type == 0) {
                            JumpUtil.judgeJump(mContext, bean.getRementuandui().getData().get(getPosition()).getAptid(), bean.getRementuandui().getData().get(getPosition()).getAptype(), bean.getRementuandui().getData().get(getPosition()).getSrc());
                        }else {
                            JumpUtil.judgeJump(mContext, bean.getRemengeren().getData().get(getPosition()).getAptid(), bean.getRemengeren().getData().get(getPosition()).getAptype(), bean.getRemengeren().getData().get(getPosition()).getSrc());
                        }
                    }
                });
            }
        }
    }
}

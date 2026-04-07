package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.WhthinBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class HistoryAdapter extends RecyclerView.Adapter<HistoryAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener mListener;
    private List<WhthinBean> mlist;
    int flag = -1;

    public void setData(List<WhthinBean> mlist) {
        this.mlist = mlist;
        this.notifyDataSetChanged();
    }


    public void addMore(List<WhthinBean> bens) {
        if (bens == null)
            return;
        if (mlist == null) {
            mlist = new ArrayList<>();
        }
        mlist.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<WhthinBean> bens) {
        if (mlist == null) {
            mlist = new ArrayList<>();
        }
        mlist.clear();
        mlist.addAll(bens);
        notifyDataSetChanged();
    }

    public HistoryAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener mListener, int flag) {
        this.mContext = mContext;
        this.mListener = mListener;
        this.flag = flag;
    }


    public HistoryAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public HistoryAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_history_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(HistoryAdapter.ViewHolder vh, int position) {
        GlideLoad.GlideLoadRoundedImg(mlist.get(position).getHead(), vh.ivImg, 5);

        vh.tvName.setText("" + mlist.get(position).getNickname());
        vh.tvZhiwu.setText("" + mlist.get(position).getOccupationid());
        vh.tvPrice.setText(Constans.RMB + mlist.get(position).getZuidijia() + "起");
        vh.tvHp.setText("好评率   " + mlist.get(position).getHaopinl() + "%");
        vh.tvPl.setText("评论   " + mlist.get(position).getEvaluate());
        vh.tvFens.setText("粉丝   " + mlist.get(position).getFans());
        //是否VIP
        if (mlist.get(position).getIsshopvip() == 1) {
            vh.ivRz.setVisibility(View.VISIBLE);
        } else {
            vh.ivRz.setVisibility(View.GONE);
        }
        vh.ivRzXy.setVisibility(View.VISIBLE);
        switch (mlist.get(position).getXueyuan()) {
            case 6:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan1);
                break;
            case 7:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan2);
                break;
            case 8:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan3);
                break;
            case 9:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan4);
                break;
            case 10:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan5);
                break;
            case 11:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan6);
                break;
            case 12:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan7);
                break;
            case 13:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xing1);
                break;
            case 14:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xing2);
                break;
            case 15:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xing3);
                break;
            case 16:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xing4);
                break;
            case 17:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xing5);
                break;
            case 18:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xing6);
                break;
            case 19:
                vh.ivRzXy.setBackgroundResource(R.mipmap.icon_xing7);
                break;
            default:
                vh.ivRzXy.setVisibility(View.GONE);
                break;
        }

        if ((mlist.get(position).getShiming() == 1)) {
            vh.ivRzSm.setVisibility(View.VISIBLE);
        } else {
            vh.ivRzSm.setVisibility(View.GONE);
        }
        //是否诚信认证
        if (mlist.get(position).getSincerity() == 1) {
            vh.ivRzCx.setVisibility(View.VISIBLE);
        } else {
            vh.ivRzCx.setVisibility(View.GONE);
        }
        //是否平台认证
        if (mlist.get(position).getPlatform() == 1) {
            vh.ivRzPt.setVisibility(View.VISIBLE);
        } else {
            vh.ivRzPt.setVisibility(View.GONE);
        }
    }

    @Override
    public int getItemCount() {
        if (mlist != null) {
            return mlist.size();
        } else {
            return 0;
        }
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.iv_rz)
        ImageView ivRz;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_zhiwu)
        TextView tvZhiwu;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.iv_rz_cx)
        ImageView ivRzCx;
        @BindView(R.id.iv_rz_pt)
        ImageView ivRzPt;
        @BindView(R.id.iv_rz_xy)
        ImageView ivRzXy;
        @BindView(R.id.tv_hp)
        TextView tvHp;
        @BindView(R.id.tv_pl)
        TextView tvPl;
        @BindView(R.id.tv_fens)
        TextView tvFens;
        @BindView(R.id.iv_rz_sm)
        ImageView ivRzSm;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", mlist.get(getPosition()).getUserid());
                    mContext.startActivity(intent);
                }
            });


        }
    }

}

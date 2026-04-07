package com.linzi.xiguwen.adapter;

import android.content.Context;

import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MallXieShangHistoryBean;
import com.linzi.xiguwen.bean.WeddingXieShangHistoryBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/10.
 */

public class XieShangHistoryAdapter extends RecyclerView.Adapter<XieShangHistoryAdapter.ViewHolder> {
    private int type;
    private List<WeddingXieShangHistoryBean.DataBean> weddinglist;
    private List<MallXieShangHistoryBean.DataBean> malllist;

    public void setWeddinglist(List<WeddingXieShangHistoryBean.DataBean> weddinglist) {
        this.weddinglist = weddinglist;
        notifyDataSetChanged();
    }

    public void setMalllist(List<MallXieShangHistoryBean.DataBean> malllist) {
        this.malllist = malllist;
        notifyDataSetChanged();
    }

    private Context mContext;

    public XieShangHistoryAdapter(Context mContext, int type) {
        this.mContext = mContext;
        this.type = type;
    }

    @Override
    public XieShangHistoryAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_tuihuo_history_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(XieShangHistoryAdapter.ViewHolder vh, int position) {
        if (type == 0) {//婚庆
            GlideLoad.GlideLoadCircle(weddinglist.get(position).getHead(), vh.ivHeadImg);
            vh.tvName.setText(weddinglist.get(position).getNickname() + "");
            vh.tvTime.setText(weddinglist.get(position).getTimes() + "");
            vh.tvContext.setText(weddinglist.get(position).getText() + "");
//            vh.tvOther1.setText("物流公司：天天快递");
//            vh.tvOther2.setText("退货说明：徐发文，13600025857，广东省广州市番禺区 大石街道大石镇植村西北二路二巷14号6楼");
//            vh.tvOther3.setText("退款原因：特殊情况，暂时不需要了");

        } else {//商城
            GlideLoad.GlideLoadCircle(malllist.get(position).getHead(), vh.ivHeadImg);
            vh.tvName.setText(malllist.get(position).getNickname() + "");
            vh.tvTime.setText(malllist.get(position).getTimes() + "");
            vh.tvContext.setText(malllist.get(position).getText() + "");
//            vh.tvOther1.setText("物流公司：天天快递");
//            vh.tvOther2.setText("退货说明：徐发文，13600025857，广东省广州市番禺区 大石街道大石镇植村西北二路二巷14号6楼");
//            vh.tvOther3.setText("退款原因：特殊情况，暂时不需要了");
        }


//        MallActivitiesAdapter.ImgAdapter adapter=new MallActivitiesAdapter(mContext).new ImgAdapter();
//
//        GridLayoutManager manager=new GridLayoutManager(mContext,4){
//            @Override
//            public boolean canScrollVertically() {
//                return false;
//            }
//        };
//        vh.imgRecycle.setLayoutManager(manager);
//        vh.imgRecycle.setAdapter(adapter);
    }

    @Override
    public int getItemCount() {
        if (type == 0) {
            return weddinglist == null ? 0 : weddinglist.size();
        } else {
            return malllist == null ? 0 : malllist.size();
        }
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_head_img)
        ImageView ivHeadImg;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_context)
        TextView tvContext;
        @BindView(R.id.tv_other_1)
        TextView tvOther1;
        @BindView(R.id.tv_other_2)
        TextView tvOther2;
        @BindView(R.id.tv_other_3)
        TextView tvOther3;
        @BindView(R.id.img_recycle)
        RecyclerView imgRecycle;
        @BindView(R.id.rl_img)
        RelativeLayout rlImg;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}

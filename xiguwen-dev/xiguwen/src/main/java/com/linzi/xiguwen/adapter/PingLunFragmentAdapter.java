package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.hedgehog.ratingbar.RatingBar;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.TimeUtils;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class PingLunFragmentAdapter extends RecyclerView.Adapter<PingLunFragmentAdapter.VHRePly> {
    Context mContext;
    CallBack.PingjiaListener mPinglun;

    public void setmPinglun(CallBack.PingjiaListener mPinglun) {
        this.mPinglun = mPinglun;
    }

    public PingLunFragmentAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public PingLunFragmentAdapter.VHRePly onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_pinglun_manager_layout, parent, false);
        return new PingLunFragmentAdapter.VHRePly(view);
    }

    @Override
    public void onBindViewHolder(PingLunFragmentAdapter.VHRePly vh, final int position) {
        GlideLoad.GlideLoadCircle(mContext, "http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg", vh.ivHead);
        vh.tvName.setText("林子");
        vh.tvTime.setText(TimeUtils.getStr2Times("" + System.currentTimeMillis()));
        vh.ratingbar.setStar(4);
        vh.tvStarCount.setText(4 + "分");
        vh.tvContext.setText("婚礼前，阿柯和我沟通了很多次。对于我的想法尽量的给我建议，让我有个完美的婚礼。我和老公都不是擅长表达的人，在婚礼进行中，我俩都有瞬间的懵逼，还好阿柯在一旁适宜的主持，我俩才回过神来！(*¯︶¯*）");
        GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.ivImg1);
        GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.ivImg2);
        GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.ivImg3);
        vh.tvReply.setText("商家回复：非常高兴能为您带来优质的服务，我们准备着为你们主持的，不单单是一场婚礼，还是会是你们记忆中最珍贵，最浪漫的回忆。");

        if(mPinglun!=null){
            vh.btReply.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mPinglun.pingjia(v,position);
                }
            });
        }
    }

    @Override
    public int getItemCount() {
        return 15;
    }

    class VHRePly extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.ratingbar)
        RatingBar ratingbar;
        @BindView(R.id.tv_star_count)
        TextView tvStarCount;
        @BindView(R.id.iv_img1)
        ImageView ivImg1;
        @BindView(R.id.iv_img2)
        ImageView ivImg2;
        @BindView(R.id.iv_img3)
        ImageView ivImg3;
        @BindView(R.id.ll_pic)
        LinearLayout llPic;
        @BindView(R.id.tv_reply)
        TextView tvReply;
        @BindView(R.id.tv_context)
        TextView tvContext;
        @BindView(R.id.tv_see_num)
        TextView tvSeeNum;
        @BindView(R.id.bt_reply)
        Button btReply;

        VHRePly(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}

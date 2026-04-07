package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.graphics.Color;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.SynamicdetailsBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/29.
 */

public class PinglunAdapter extends RecyclerView.Adapter<PinglunAdapter.ViewHolder> {
    private Context mContext;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener1 listener;
    private List<SynamicdetailsBean.CommentlistBean> mBens;


    public void addMore(List<SynamicdetailsBean.CommentlistBean> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<SynamicdetailsBean.CommentlistBean> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }

    public PinglunAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void setListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 listener) {
        this.listener = listener;
    }

    @Override
    public PinglunAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_pinglun_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(PinglunAdapter.ViewHolder vh, final int position) {
        final SynamicdetailsBean.CommentlistBean bean = mBens.get(position);

        GlideLoad.GlideLoadCircle(bean.getHead(), vh.ivHead);
        vh.tvTitle.setText(bean.getNickname());
        vh.tvTime.setText(bean.getCreate_ti());
        vh.tvContext.setText(bean.getComm());

        if (bean.getXiaji() == null || bean.getXiaji().size() == 0) {
            vh.llReply.setVisibility(View.GONE);
        } else {
            vh.llReply.setVisibility(View.VISIBLE);
            vh.adapter.setChildEntities(bean.getXiaji());
//            LinearLayoutManager manager = new LinearLayoutManager(mContext);
//            vh.replyRecycle.setLayoutManager(manager);
//            ReplyAdapter adapter = new ReplyAdapter();
//            vh.replyRecycle.setAdapter(adapter);
        }

        vh.ivPingjia.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (listener != null) {
                    listener.onItemClick(view, position, bean);
                }

            }
        });
        vh.tvJuBao.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (listener != null) {
                    listener.onItemClick(view, position, bean);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return mBens == null ? 0 : mBens.size();
    }

    class ReplyAdapter extends RecyclerView.Adapter<ReplyAdapter.VH> {
        private List<SynamicdetailsBean.commentChildEntity> childEntities;

        public void setChildEntities(List<SynamicdetailsBean.commentChildEntity> childEntities) {
            this.childEntities = childEntities;
            notifyDataSetChanged();
        }

        @Override
        public ReplyAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            TextView view = new TextView(mContext);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(ReplyAdapter.VH vh, int position) {
            SynamicdetailsBean.commentChildEntity entity = childEntities.get(position);
            vh.tvPinglun.setText(entity.getNickname() + ":" + entity.getComm());
        }

        @Override
        public int getItemCount() {
            return childEntities == null ? 0 : childEntities.size();
        }

        class VH extends RecyclerView.ViewHolder {
            TextView tvPinglun;

            VH(View itemView) {
                super(itemView);
                this.tvPinglun = (TextView) itemView;
                this.tvPinglun.setTextColor(Color.parseColor("#9B9B9B"));
            }
        }
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.iv_pingjia)
        ImageView ivPingjia;
        @BindView(R.id.tv_jubao)
        TextView tvJuBao;
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_context)
        TextView tvContext;
        @BindView(R.id.reply_recycle)
        RecyclerView replyRecycle;
        @BindView(R.id.ll_reply)
        LinearLayout llReply;
        ReplyAdapter adapter;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            LinearLayoutManager manager = new LinearLayoutManager(mContext);
            replyRecycle.setLayoutManager(manager);
            adapter = new ReplyAdapter();
            replyRecycle.setAdapter(adapter);
        }
    }
}

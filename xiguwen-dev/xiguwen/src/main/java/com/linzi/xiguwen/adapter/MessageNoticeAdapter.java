package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MessageNoticeBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by PC on 2018-04-07.
 */

public class MessageNoticeAdapter extends RecyclerView.Adapter<MessageNoticeAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener1 mListener;

    private List<MessageNoticeBean.MessageNoticeEntity> mBens;


    public void addMore(List<MessageNoticeBean.MessageNoticeEntity> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<MessageNoticeBean.MessageNoticeEntity> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }


    public MessageNoticeAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener1 mListener) {
        this.mContext = mContext;
        this.mListener = mListener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_message_notice, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, int position) {
        vh.displayBean(mBens.get(position));
    }

    @Override
    public int getItemCount() {
        return mBens == null ? 0 : mBens.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {

        @BindView(R.id.notice_icon)
        ImageView imgIcon;
        @BindView(R.id.notice_image)
        ImageView imgmage;
        @BindView(R.id.notice_name)
        TextView txName;
        @BindView(R.id.notice_name_type)
        TextView txType;
        @BindView(R.id.notice_content)
        TextView txContent;
        @BindView(R.id.notice_date)
        TextView txDate;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (mListener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        int posi=getAdapterPosition();
                        mListener.onItemClick(view, posi, mBens.get(posi));
                    }
                });
            }
        }

        void displayBean(MessageNoticeBean.MessageNoticeEntity bean) {
            GlideLoad.GlideLoadImg(bean.getImg(), imgmage);
            GlideLoad.GlideLoadCircle(bean.getHead(), imgIcon);
            txName.setText(bean.getTitlea() + "");
            txType.setText(bean.getTitleb() + "");
            if (!TextUtils.isEmpty(bean.getCont())) {
                txContent.setVisibility(View.VISIBLE);
            } else {
                txContent.setVisibility(View.GONE);
            }
            txContent.setText(bean.getCont() + "");
            txDate.setText(bean.getCreatetime() + "");
        }
    }
}
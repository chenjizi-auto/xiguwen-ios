package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MessageTradeBean;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by PC on 2018-04-07.
 */

public class MessageTradeAdapter extends RecyclerView.Adapter<MessageTradeAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener1 mListener;


    private List<MessageTradeBean.MessageTradeEntity> mBens;


    public void addMore(List<MessageTradeBean.MessageTradeEntity> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<MessageTradeBean.MessageTradeEntity> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }


    public MessageTradeAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener1 mListener) {
        this.mContext = mContext;
        this.mListener = mListener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_message_trade, parent, false);
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

        @BindView(R.id.trade_icon)
        ImageView tradeIcon;
        @BindView(R.id.trade_title)
        TextView tradeTitle;
        @BindView(R.id.trade_date)
        TextView tradeDate;
        @BindView(R.id.trade_content)
        TextView tradeContent;
        @BindView(R.id.trade_order)
        TextView tradeOrder;
        @BindView(R.id.trade_red_type)
        TextView txReadType;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (mListener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        int position = getPosition();
                        mListener.onItemClick(view, position, mBens.get(getAdapterPosition()));
                        mBens.get(position).setReadType(0);
                        txReadType.setText("已读");
                        Preferences.removePushTradeId(mBens.get(position).getId() + "");

                    }
                });
            }
        }

        void displayBean(MessageTradeBean.MessageTradeEntity bean) {
            GlideLoad.GlideLoadImg(bean.getImg(), tradeIcon);
            tradeTitle.setText(bean.getTitle() + "");
            tradeContent.setText(bean.getCont() + "");
            tradeDate.setText(bean.getCreatetime() + "");
            tradeOrder.setText("订单编号：" + bean.getOrder_sn());
            if (bean.getReadType() == 1) {
                txReadType.setText("未读");
            } else {
                txReadType.setText("已读");
            }
        }
    }
}

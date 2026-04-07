package com.linzi.xiguwen.adapter;

import android.app.Activity;
import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.BankCardEntity;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/4.
 */

public class ChooseBankCardAdapter extends RecyclerView.Adapter<ChooseBankCardAdapter.ViewHolder> {
    private Activity mContext;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener mListener;
    private int choose_position = 0;

    private List<BankCardEntity.ListBean> mBeans;

    public void addFirst(List<BankCardEntity.ListBean> mBeans) {
        this.mBeans = mBeans;
        notifyDataSetChanged();
    }

    public List<BankCardEntity.ListBean> getDatas() {
        return mBeans;
    }

    public ChooseBankCardAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener mListener) {
        this.mContext = (Activity) mContext;
        this.mListener = mListener;
    }

    @Override
    public ChooseBankCardAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_bank_card_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ChooseBankCardAdapter.ViewHolder vh, int position) {
        BankCardEntity.ListBean entity = mBeans.get(position);
        if (choose_position == entity.getId()) {
            vh.ivChoose.setVisibility(View.VISIBLE);
        } else {
            vh.ivChoose.setVisibility(View.GONE);
        }
        vh.tvBankeName.setText(entity.getAli_name() + "");
        vh.tvCardDetails.setText(entity.getName() + "");
        //GlideLoad.GlideLoadCircle(entity.getIcon(), vh.ivBankImg);
        vh.ivBankImg.setBackgroundResource(R.mipmap.icon_alipay);
    }

    public void setChoose(int id) {
        choose_position = id;
        this.notifyDataSetChanged();
    }


    @Override
    public int getItemCount() {
        return mBeans == null ? 0 : mBeans.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_bank_img)
        ImageView ivBankImg;
        @BindView(R.id.tv_banke_name)
        TextView tvBankeName;
        @BindView(R.id.tv_card_details)
        TextView tvCardDetails;
        @BindView(R.id.iv_choose)
        ImageView ivChoose;
        @BindView(R.id.ll_choose_card)
        LinearLayout llChooseCard;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
//            if (mListener != null) {
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
//                        mListener.onItemClick(view, getPosition());

                    EventBusUtil.sendEvent(new Event(EventCode.BANK_CHOSE, mBeans.get(getPosition())));
//                        setChoose(getPosition());
                    mContext.finish();
                }

            });
//            }
        }
    }


}

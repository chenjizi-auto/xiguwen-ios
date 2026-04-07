package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.PriceEntity;
import com.linzi.xiguwen.ui.NewBaijiaDetailsActivity;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by PC on 2018-04-15.
 */

public class SearchPriceAdapter extends RecyclerView.Adapter<SearchPriceAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener1 mListener;
    private int width;
    private List<PriceEntity> mBens;
    private LinearLayout.LayoutParams layoutParams;

    public void addMore(List<PriceEntity> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<PriceEntity> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }


    public SearchPriceAdapter(Context mContext) {
        this.mContext = mContext;
        width = AppUtil.getWidth(mContext) / 2 - AppUtil.dip2px(mContext, 10);
        layoutParams = new LinearLayout.LayoutParams(width, width);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_search_shop, parent, false);
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

        @BindView(R.id.shop_image)
        ImageView shopImage;
        @BindView(R.id.shop_title)
        TextView shopTitle;
        @BindView(R.id.shop_price)
        TextView shopPrice;
        @BindView(R.id.shop_num)
        TextView shopNum;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, NewBaijiaDetailsActivity.class);
                    intent.putExtra("offoer_id", mBens.get(getPosition()).getQuotationid());
                    mContext.startActivity(intent);
                }
            });
        }

        void displayBean(PriceEntity bean) {
//            GlideLoad.GlideLoadImg(bean.getImg(), imgmage);
            GlideLoad.GlideLoadRoundedImg(bean.getImglist(), shopImage, 6);
            shopImage.setLayoutParams(layoutParams);
//            if (getPosition() % 2 == 1) {
//                layoutParams.leftMargin = AppUtil.dip2px(mContext, 6);
//            } else {
//                layoutParams.leftMargin = AppUtil.dip2px(mContext, 10);
//            }
            shopTitle.setText(bean.getName() + "");
            shopNum.setText("已售" + bean.getNum());
            shopPrice.setText("￥" + bean.getPrice());

        }
    }
}

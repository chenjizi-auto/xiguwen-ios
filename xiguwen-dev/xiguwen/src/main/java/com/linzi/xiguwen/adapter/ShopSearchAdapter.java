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

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ShopEntity;
import com.linzi.xiguwen.ui.NewGoodsDetailsActivity;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by PC on 2018-04-15.
 */

public class ShopSearchAdapter extends RecyclerView.Adapter<ShopSearchAdapter.ViewHolder> {
    Context mContext;
    private int width;
    private List<ShopEntity> mBens;
    private LinearLayout.LayoutParams layoutParams;

    public void addMore(List<ShopEntity> bens) {
        if (bens == null || bens.isEmpty())
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<ShopEntity> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        if (bens != null && !bens.isEmpty()) {
            mBens.addAll(bens);
        }
        notifyDataSetChanged();
    }


    public ShopSearchAdapter(Context mContext) {
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
                    Intent intent = new Intent(mContext, NewGoodsDetailsActivity.class);
                    intent.putExtra("goods_id", mBens.get(getPosition()).getShopid());
                    mContext.startActivity(intent);
                }
            });
        }

        void displayBean(ShopEntity bean) {
//            GlideLoad.GlideLoadImg(bean.getImg(), imgmage);
            if (!AppUtil.isEmpty(bean.getShopimg())) {
                GlideLoad.GlideLoadRoundedImg(bean.getShopimg().get(0), shopImage, 6);
            } else {
                GlideLoad.GlideLoadImg(mContext, R.mipmap.icon_placeholder, shopImage);
            }
            shopImage.setLayoutParams(layoutParams);
//            if (getPosition() % 2 == 1) {
//                layoutParams.leftMargin = AppUtil.dip2px(mContext, 6);
//            } else {
//                layoutParams.leftMargin = AppUtil.dip2px(mContext, 10);
//            }
            shopTitle.setText(bean.getShopname() + "");
            shopNum.setText("已售" +bean.getNum());
            shopPrice.setText("￥" + bean.getPrice());

        }
    }
}

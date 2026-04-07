package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ShopUserDetailsBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.BaijiaDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/3/24.
 */

public class MallBaojiaAdapter extends RecyclerView.Adapter<MallBaojiaAdapter.VH> {
    private List<ShopUserDetailsBean.BaojiaBeanX.BaojiaBean> baojiaBeanList;
    private Context mContext;

    public void setbaojiaBeanList(List<ShopUserDetailsBean.BaojiaBeanX.BaojiaBean> baojiaBeanList) {
        this.baojiaBeanList = baojiaBeanList;
        this.mContext = mContext;
        this.notifyDataSetChanged();
    }

    public MallBaojiaAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public MallBaojiaAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_mall_index_works_layout, parent, false);
        return new MallBaojiaAdapter.VH(view);
    }

    @Override
    public void onBindViewHolder(MallBaojiaAdapter.VH vh, int position) {

        vh.tvContext.setVisibility(View.GONE);
        vh.tvSaleCount.setVisibility(View.VISIBLE);
        vh.tvSeeCount.setVisibility(View.GONE);
        vh.tvSaleCount.setText("已售 " + baojiaBeanList.get(position).getNum());
        vh.tvPrice.setText(Constans.RMB + baojiaBeanList.get(position).getPrice());
        vh.tvTitle.setText("" + baojiaBeanList.get(position).getName());
        GlideLoad.GlideLoadImg(mContext, baojiaBeanList.get(position).getImglist(), vh.ivImg);
        vh.tvTitle.setText("" + baojiaBeanList.get(position).getName());
        vh.tvPrice.setText(Constans.RMB + baojiaBeanList.get(position).getPrice() + "");
    }

    @Override
    public int getItemCount() {
        if (baojiaBeanList == null) {
            return 0;
        } else {
            return baojiaBeanList.size();
        }
    }

    class VH extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_context)
        TextView tvContext;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_sale_count)
        TextView tvSaleCount;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;

        VH(View view) {
            super(view);
            ButterKnife.bind(this, view);

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    mContext.startActivity(new Intent(mContext, BaijiaDetailsActivity.class));
                }
            });
        }
    }
}

package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.GoodsDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/11/27.
 */

public class HotGoodsAdapter extends RecyclerView.Adapter<HotGoodsAdapter.ViewHolder> {
    private Context mContext;

    public HotGoodsAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_hot_goods_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, int position) {
        GlideLoad.GlideLoadCircle(mContext, "http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg", vh.ivHeadImg);
        vh.tvMallName.setText("水晶石婚礼");
        vh.tvMallSign.setText("婚礼策划");
        GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.ivImg1);
        vh.llMuchImg.setVisibility(View.VISIBLE);
//        vh.tvImgMore.setVisibility(View.VISIBLE);
//        vh.tvImgMore.setText("+" + 5);
        GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.ivImg2);
        GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.ivImg3);
        vh.tvGoodsName.setText("【水晶石婚礼】婚戒");
        vh.tvGoodsPrice.setText(Constans.RMB + "16800");
        vh.tvNumLove.setText(200+"人喜欢");
    }

    @Override
    public int getItemCount() {
        return 3;
    }

    class ViewHolder  extends RecyclerView.ViewHolder{
        @BindView(R.id.iv_head_img)
        ImageView ivHeadImg;
        @BindView(R.id.tv_mall_name)
        TextView tvMallName;
        @BindView(R.id.tv_mall_sign)
        TextView tvMallSign;
        @BindView(R.id.bt_care)
        Button btCare;
        @BindView(R.id.iv_img_1)
        ImageView ivImg1;
        @BindView(R.id.ll_is_video)
        LinearLayout llIsVideo;
        @BindView(R.id.iv_img_2)
        ImageView ivImg2;
        @BindView(R.id.iv_img_3)
        ImageView ivImg3;
        @BindView(R.id.tv_img_more)
        TextView tvImgMore;
        @BindView(R.id.ll_much_img)
        LinearLayout llMuchImg;
        @BindView(R.id.tv_goods_name)
        TextView tvGoodsName;
        @BindView(R.id.tv_goods_price)
        TextView tvGoodsPrice;
        @BindView(R.id.tv_num_love)
        TextView tvNumLove;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent=new Intent(mContext, GoodsDetailsActivity.class);
                    mContext.startActivity(intent);
                }
            });
        }
    }
}

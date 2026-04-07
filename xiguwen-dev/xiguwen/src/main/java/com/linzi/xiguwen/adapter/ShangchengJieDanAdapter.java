package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.RecyclerView.Adapter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.TimeUtils;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/5.
 */

public class ShangchengJieDanAdapter extends Adapter<ShangchengJieDanAdapter.ViewHolder> {
    Context mContext;
    private int type = 0;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    private CallBack.PingjiaListener mPingjia;
    private CallBack.EditPriceListener mEditPrice;
    private CallBack.FahuoListener mFahuo;

    private String[] CHANNELS = new String[]{"全部", "待付款", "代发货", "代收货", "待评价"};
    private int[] IMG_TYPE = new int[]{R.mipmap.icon_daifukuan, R.mipmap.ivon_daifahuo, R.mipmap.icon_daishouhuo, R.mipmap.icon_jiaoyichenggong, R.mipmap.icon_jiaoyiguanbi};


    public ShangchengJieDanAdapter(Context mContext, int type) {
        this.mContext = mContext;
        this.type = type;
    }

    public ShangchengJieDanAdapter(Context mContext, int type, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.type = type;
        this.itemClickListener = itemClickListener;
    }

    public ShangchengJieDanAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void setmPingjia(CallBack.PingjiaListener mPingjia) {
        this.mPingjia = mPingjia;
    }

    public void setmEditPrice(CallBack.EditPriceListener mEditPrice) {
        this.mEditPrice = mEditPrice;
    }

    public void setmFahuo(CallBack.FahuoListener mFahuo) {
        this.mFahuo = mFahuo;
    }

    @Override
    public ShangchengJieDanAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_hunqing_order_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ShangchengJieDanAdapter.ViewHolder vh, final int position) {
        if (type == 0) {
            vh.ivZhuangtai.setBackgroundDrawable(mContext.getResources().getDrawable(IMG_TYPE[position % IMG_TYPE.length]));
        } else {
            vh.ivZhuangtai.setBackgroundDrawable(mContext.getResources().getDrawable(IMG_TYPE[type - 1]));
        }

        vh.llShengyushijian.setVisibility(View.GONE);
        switch (type) {
            case 0:
                vh.llAll.setVisibility(View.VISIBLE);
                vh.orderBt1.setVisibility(View.VISIBLE);
                vh.orderBt2.setVisibility(View.VISIBLE);
                vh.orderBt1.setText("按钮1");
                vh.orderBt2.setText("按钮2");

                vh.llShengyushijian.setVisibility(View.VISIBLE);
                TimeUtils.getReturnTime("00:30:00",vh.time);
                break;
            case 1:
                vh.llAll.setVisibility(View.VISIBLE);
                vh.orderBt1.setVisibility(View.GONE);
                vh.orderBt2.setVisibility(View.VISIBLE);
                vh.orderBt2.setText("修改价格");

                vh.llShengyushijian.setVisibility(View.VISIBLE);
                vh.tvShengyushijian.setText("剩余支付时间：");
                TimeUtils.getReturnTime("00:30:00",vh.time);

                if(mEditPrice!=null){
                    vh.orderBt2.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            mEditPrice.editPrice(v,position);
                        }
                    });
                }

                break;
            case 2:
                vh.llAll.setVisibility(View.VISIBLE);
                vh.orderBt1.setVisibility(View.VISIBLE);
                vh.orderBt2.setVisibility(View.GONE);
                vh.orderBt1.setText("发货");

                vh.llShengyushijian.setVisibility(View.GONE);

                if(mFahuo!=null){
                    vh.orderBt1.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            mFahuo.fahuo(position);
                        }
                    });
                }

                break;
            case 3:
                vh.llAll.setVisibility(View.GONE);

                break;
            case 4:
                vh.llAll.setVisibility(View.VISIBLE);
                vh.orderBt1.setVisibility(View.GONE);
                vh.orderBt2.setVisibility(View.VISIBLE);
                vh.orderBt2.setText("立即评价");
                vh.llShengyushijian.setVisibility(View.GONE);

                if(mPingjia!=null){
                    vh.orderBt2.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            mPingjia.pingjia(v,position);
                        }
                    });
                }
                break;
            case 5:
                vh.llAll.setVisibility(View.VISIBLE);
                vh.orderBt1.setVisibility(View.GONE);
                vh.orderBt2.setVisibility(View.VISIBLE);
//                vh.orderBt1.setText("取消订单");
                vh.orderBt2.setText("删除订单");
                vh.llShengyushijian.setVisibility(View.GONE);
                break;
        }
        GoodsAdapter adapter = new GoodsAdapter();
        LinearLayoutManager manager = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.recycle.setLayoutManager(manager);
        vh.recycle.setAdapter(adapter);
    }

    @Override
    public int getItemCount() {
        return 10;
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.iv_zhuangtai)
        ImageView ivZhuangtai;
        @BindView(R.id.recycle)
        RecyclerView recycle;
        @BindView(R.id.tv_goods_num)
        TextView tvGoodsNum;
        @BindView(R.id.tv_xiaoji)
        TextView tvXiaoji;
        @BindView(R.id.tv_shifukuan)
        TextView tvShifukuan;
        @BindView(R.id.time)
        TextView time;
        @BindView(R.id.tv_shengyushijian)
        TextView tvShengyushijian;
        @BindView(R.id.ll_shengyushijian)
        LinearLayout llShengyushijian;
        @BindView(R.id.ll_all)
        LinearLayout llAll;
        @BindView(R.id.order_bt_1)
        Button orderBt1;
        @BindView(R.id.order_bt_2)
        Button orderBt2;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (itemClickListener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        itemClickListener.onItemClick(view, getPosition());
                    }
                });
            }
        }
    }

    public class GoodsAdapter extends Adapter<GoodsAdapter.VH> {

        @Override
        public VH onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_shangcheng_goods_item_layout, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(VH vh, int position) {
            GlideLoad.GlideLoadImg(mContext, "http://pic41.nipic.com/20140503/18641501_163214498000_2.jpg", vh.ivImg);
            vh.tvTitle.setText("酒店室内浪漫婚礼");
            vh.tvNum.setText("" + 1);
        }

        @Override
        public int getItemCount() {
            return 3;
        }

        class VH extends RecyclerView.ViewHolder {
            @BindView(R.id.iv_img)
            ImageView ivImg;
            @BindView(R.id.tv_title)
            TextView tvTitle;
            @BindView(R.id.tv_color_size)
            TextView tvColorSize;
            @BindView(R.id.tv_guige)
            TextView tvGuige;
            @BindView(R.id.tv_pay_price)
            TextView tvPayPrice;
            @BindView(R.id.tv_num)
            TextView tvNum;

            VH(View view) {
                super(view);
                ButterKnife.bind(this, view);
            }
        }

    }

}

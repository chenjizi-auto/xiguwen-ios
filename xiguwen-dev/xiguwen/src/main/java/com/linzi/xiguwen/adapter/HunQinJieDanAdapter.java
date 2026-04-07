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
import com.linzi.xiguwen.utils.TimeUtils;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/5.
 */

public class HunQinJieDanAdapter extends Adapter<HunQinJieDanAdapter.ViewHolder> {
    Context mContext;
    private int type=0;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    private CallBack.PingjiaListener mPingjia;
    private CallBack.EditPriceListener mEditPrice;
    private CallBack.JiedanListener mJiedan;
    private CallBack.ComleteListener mComlete;
    private CallBack.TuikuanClickListener mTuikuan;
    private  String[] CHANNELS = new String[]{"全部", "待付款", "待接单", "待服务", "已服务", "已成功","退款单"};
    private  int[]IMG_TYPE=new int[]{R.mipmap.icon_daifukuan,R.mipmap.icon_daijiedan,R.mipmap.icon_daifuwu,R.mipmap.icon_yifuwu,R.mipmap.icon_jiaoyichenggong,R.mipmap.icon_tuikuanzhong};


    public HunQinJieDanAdapter(Context mContext, int type) {
        this.mContext = mContext;
        this.type = type;
    }

    public HunQinJieDanAdapter(Context mContext, int type, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.type = type;
        this.itemClickListener = itemClickListener;
    }

    public HunQinJieDanAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void setmPingjia(CallBack.PingjiaListener mPingjia){
        this.mPingjia=mPingjia;
    }

    public void setmEditPrice(CallBack.EditPriceListener mEditPrice) {
        this.mEditPrice = mEditPrice;
    }

    public void setmJiedan(CallBack.JiedanListener mJiedan) {
        this.mJiedan = mJiedan;
    }

    public void setmComlete(CallBack.ComleteListener mComlete) {
        this.mComlete = mComlete;
    }

    public void setmTuikuan(CallBack.TuikuanClickListener mTuikuan) {
        this.mTuikuan = mTuikuan;
    }

    @Override
    public HunQinJieDanAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_hunqing_order_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(HunQinJieDanAdapter.ViewHolder vh, final int position) {
        if(type==0){
            vh.ivZhuangtai.setBackgroundDrawable(mContext.getResources().getDrawable(IMG_TYPE[position%IMG_TYPE.length]));
        }else{
            vh.ivZhuangtai.setBackgroundDrawable(mContext.getResources().getDrawable(IMG_TYPE[type-1]));
        }
        switch(type){
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
                vh.orderBt1.setVisibility(View.GONE);
                vh.orderBt2.setVisibility(View.VISIBLE);
                vh.orderBt2.setText("确认接单");
                vh.llShengyushijian.setVisibility(View.VISIBLE);
                vh.tvShengyushijian.setText("剩余接单时间：");
                TimeUtils.getReturnTime("00:30:00",vh.time);

                if(mJiedan!=null){
                    vh.orderBt2.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            mJiedan.jiedan(v,position);
                        }
                    });
                }
                break;
            case 3:
                vh.llAll.setVisibility(View.GONE);


                break;
            case 4:
                vh.orderBt1.setVisibility(View.GONE);
                vh.orderBt2.setVisibility(View.VISIBLE);
//                vh.orderBt1.setText("取消订单");
                vh.orderBt2.setText("订单完成");

                vh.llShengyushijian.setVisibility(View.VISIBLE);
                vh.tvShengyushijian.setText("剩余确认时间：");
                TimeUtils.getReturnTime("00:30:00",vh.time);

                if(mComlete!=null){
                    vh.orderBt2.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            mComlete.complete(v,position);
                        }
                    });
                }
                break;
            case 5:
                vh.llAll.setVisibility(View.VISIBLE);
                vh.orderBt1.setVisibility(View.GONE);
                vh.orderBt2.setVisibility(View.VISIBLE);
//                vh.orderBt1.setText("取消订单");
                vh.orderBt2.setText("立即评价");

                if(mPingjia!=null){
                    vh.orderBt2.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            mPingjia.pingjia(view,position);
                        }
                    });
                }

                vh.llShengyushijian.setVisibility(View.GONE);
                break;
            case 6:
                vh.llAll.setVisibility(View.GONE);

                break;
        }

        SureOrderAdapter.GoodsAdapter adapter=new SureOrderAdapter(mContext).new GoodsAdapter();
        LinearLayoutManager manager=new LinearLayoutManager(mContext){
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

    class ViewHolder extends RecyclerView.ViewHolder{
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

            if(type==6){
                if(mTuikuan!=null){
                    view.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            mTuikuan.TuikuanClick(getPosition());
                        }
                    });
                }
            }else{
                if(itemClickListener!=null){
                    view.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            itemClickListener.onItemClick(view,getPosition());
                        }
                    });
                }
            }
        }
    }
}

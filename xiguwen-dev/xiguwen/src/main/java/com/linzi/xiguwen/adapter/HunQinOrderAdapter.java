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

public class HunQinOrderAdapter extends Adapter<HunQinOrderAdapter.ViewHolder> {
    Context mContext;
    private int type=0;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    private CallBack.PingjiaListener mPingjia;
    private CallBack.TuikuanListener mTuikuan;
    private CallBack.TuikuanDetailsListener mTuikuanDetails;
    private  String[] CHANNELS = new String[]{"全部", "待付款", "待接单", "待服务", "已服务", "成功"};
    private  int[]IMG_TYPE=new int[]{R.mipmap.icon_daifukuan,R.mipmap.icon_daijiedan,R.mipmap.icon_daifuwu,R.mipmap.icon_yifuwu,R.mipmap.icon_jiaoyichenggong};


    public HunQinOrderAdapter(Context mContext, int type) {
        this.mContext = mContext;
        this.type = type;
    }

    public HunQinOrderAdapter(Context mContext, int type, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.type = type;
        this.itemClickListener = itemClickListener;
    }

    public HunQinOrderAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void setmPingjia(CallBack.PingjiaListener mPingjia){
        this.mPingjia=mPingjia;
    }

    public void setmTuikuan(CallBack.TuikuanListener mTuikuan) {
        this.mTuikuan = mTuikuan;
    }

    public void setmTuikuanDetails(CallBack.TuikuanDetailsListener mTuikuanDetails) {
        this.mTuikuanDetails = mTuikuanDetails;
    }

    @Override
    public HunQinOrderAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_hunqing_order_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(HunQinOrderAdapter.ViewHolder vh, final int position) {
        if(type==0){
            vh.ivZhuangtai.setBackgroundDrawable(mContext.getResources().getDrawable(IMG_TYPE[position%IMG_TYPE.length]));
        }else{
            vh.ivZhuangtai.setBackgroundDrawable(mContext.getResources().getDrawable(IMG_TYPE[type-1]));
        }
        switch(type){
            case 0:
                vh.orderBt1.setVisibility(View.VISIBLE);
                vh.orderBt2.setVisibility(View.VISIBLE);
                vh.orderBt1.setText("按钮1");
                vh.orderBt2.setText("按钮2");
                vh.llShengyushijian.setVisibility(View.VISIBLE);
                TimeUtils.getReturnTime("00:30:00",vh.time);
                break;
            case 1:
                vh.orderBt1.setVisibility(View.VISIBLE);
                vh.orderBt2.setVisibility(View.VISIBLE);
                vh.orderBt1.setText("取消订单");
                vh.orderBt2.setText("立即支付");

                vh.llShengyushijian.setVisibility(View.VISIBLE);
                vh.tvShengyushijian.setText("剩余支付时间：");
                TimeUtils.getReturnTime("00:30:00",vh.time);
                break;
            case 2:
                vh.orderBt1.setVisibility(View.VISIBLE);
                vh.orderBt2.setVisibility(View.VISIBLE);
                vh.orderBt1.setText("取消订单");
                vh.orderBt2.setText("确认订单");
                vh.llShengyushijian.setVisibility(View.VISIBLE);
                vh.tvShengyushijian.setText("剩余接单时间：");
                TimeUtils.getReturnTime("00:30:00",vh.time);

                if(mTuikuan!=null){
                    vh.orderBt1.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            mTuikuan.tuikuan(v,position);
                        }
                    });
                }

                break;
            case 3:
                vh.orderBt1.setVisibility(View.GONE);
                vh.orderBt2.setVisibility(View.VISIBLE);
//                vh.orderBt1.setText("取消订单");
                vh.orderBt2.setText("订单完成");

                vh.llShengyushijian.setVisibility(View.GONE);

                if(mTuikuanDetails!=null){
                    vh.orderBt2.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            mTuikuanDetails.tuikuanDetails(v,position);
                        }
                    });
                }

                break;
            case 4:
                vh.orderBt1.setVisibility(View.GONE);
                vh.orderBt2.setVisibility(View.VISIBLE);
//                vh.orderBt1.setText("取消订单");
                vh.orderBt2.setText("订单完成");

                vh.llShengyushijian.setVisibility(View.VISIBLE);
                vh.tvShengyushijian.setText("剩余确认时间：");
                TimeUtils.getReturnTime("00:30:00",vh.time);
                break;
            case 5:
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
        @BindView(R.id.order_bt_1)
        Button orderBt1;
        @BindView(R.id.order_bt_2)
        Button orderBt2;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
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

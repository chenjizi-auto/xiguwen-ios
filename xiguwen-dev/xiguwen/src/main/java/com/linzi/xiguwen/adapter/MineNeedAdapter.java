package com.linzi.xiguwen.adapter;

import android.content.Context;
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
import com.linzi.xiguwen.bean.MineNeedBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.CallBack;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/5.
 */

public class MineNeedAdapter extends Adapter<MineNeedAdapter.ViewHolder> {
    Context mContext;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    private CallBack.EditListener mEdit;
    private CallBack.CloseListener mClose;
    private CallBack.DelListener mDel;

    private boolean mIsMine; //是否是我的需求
    private List<MineNeedBean> mDatas;
    private SimpleDateFormat dateFormat;

    public MineNeedAdapter(Context mContext, List<MineNeedBean> datas, boolean isMine) {
        this.mContext = mContext;
        this.mDatas = datas;
        this.mIsMine = isMine;
        dateFormat = new SimpleDateFormat("HH:mm");
        dateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
    }

    public MineNeedAdapter(Context mContext, List<MineNeedBean> datas, boolean isMine,  com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.itemClickListener = itemClickListener;
        this.mDatas = datas;
        this.mIsMine = isMine;
        dateFormat = new SimpleDateFormat("HH:mm");
        dateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
    }

    public MineNeedAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void setmEdit(CallBack.EditListener mEdit) {
        this.mEdit = mEdit;
    }

    public void setmClose(CallBack.CloseListener mClose) {
        this.mClose = mClose;
    }

    public void setmDel(CallBack.DelListener mDel) {
        this.mDel = mDel;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_fragment_need_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, final int position) {
        MineNeedBean needBean = mDatas.get(position);
        if(mIsMine){
            switch (needBean.getStatus()){
                case MineNeedBean.STATUS_HAND: // 进行中
                    vh.ivStatus.setBackgroundResource(R.mipmap.icon_jinxingzhong);
                    vh.llShengyushijian.setVisibility(View.VISIBLE);
                    vh.time.setVisibility(View.VISIBLE);
    //                vh.tvShengyushijian.setText("剩余时间：");
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTimeInMillis(needBean.getCountdown() * 1000);
                    //加1分钟，为了保证剩余几十秒时应该显示一分钟才对
                    calendar.add(Calendar.MINUTE, 1);
                    vh.time.setText(dateFormat.format(calendar.getTime()));
                    vh.orderBt1.setVisibility(View.VISIBLE);
                    vh.orderBt2.setVisibility(View.VISIBLE);
                    vh.orderBt1.setText("编辑");
                    vh.orderBt2.setText("关闭");
                    if(mEdit!=null){
                        vh.orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View v) {
                                mEdit.edit(position);
                            }
                        });
                    }
                    if(mClose!=null){
                        vh.orderBt2.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View v) {
                                mClose.close(position);
                            }
                        });
                    }
                    break;
                case MineNeedBean.STATUS_END: // 已经结束
                    vh.ivStatus.setBackgroundResource(R.mipmap.icon_yijiesu);
                    vh.llShengyushijian.setVisibility(View.GONE);
                    vh.time.setVisibility(View.GONE);
                    vh.orderBt1.setVisibility(View.GONE);
                    vh.orderBt2.setVisibility(View.VISIBLE);
                    vh.orderBt2.setText("删除");
                    if(mDel != null){
                        vh.orderBt2.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View v) {
                                mDel.del(position);
                            }
                        });
                    }
                    break;
            }
        }else{
            if(needBean.getStatus() == MineNeedBean.STATUS_HAND){
                vh.ivStatus.setBackgroundResource(R.mipmap.icon_jinxingzhong);
            }else{
                vh.ivStatus.setBackgroundResource(R.mipmap.icon_yijiesu);
            }
            vh.orderBt1.setVisibility(View.GONE);
            vh.orderBt2.setVisibility(View.GONE);
            vh.mTvAddress.setVisibility(View.VISIBLE);
            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis(needBean.getCountdown() * 1000);
            //加59秒，为了保证剩余几十秒时应该显示一分钟才对
            calendar.add(Calendar.SECOND, 59);
            vh.time.setText(dateFormat.format(calendar.getTime()));
            vh.mTvAddress.setText(needBean.getDizhi());
        }
        vh.tvTitle.setText(needBean.getTypeString() + needBean.getTitle());
        vh.tvPrice.setText(Constans.RMB + needBean.getPrice());
        int length = needBean.getCreate_ti().length();
        vh.tvDate.setText(String.format("发布时间：%s",needBean.getCreate_ti().substring(0, length == 19 ? 16: length)));
        vh.tvSeeNum.setText(String.format("浏览：%d", needBean.getBrowsingvolume()));
        vh.tvJionNum.setText(String.format("参与：%d", needBean.getRenshu()));

        // 隐藏倒计时
        vh.llShengyushijian.setVisibility(View.GONE);
        vh.time.setVisibility(View.GONE);
    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_date)
        TextView tvDate;
        @BindView(R.id.tv_see_num)
        TextView tvSeeNum;
        @BindView(R.id.tv_jion_num)
        TextView tvJionNum;
        @BindView(R.id.iv_status)
        ImageView ivStatus;
        @BindView(R.id.tv_shengyushijian)
        TextView tvShengyushijian;
        @BindView(R.id.time)
        TextView time;
        @BindView(R.id.ll_shengyushijian)
        LinearLayout llShengyushijian;
        @BindView(R.id.order_bt_1)
        Button orderBt1;
        @BindView(R.id.order_bt_2)
        Button orderBt2;
        @BindView(R.id.ll_all)
        LinearLayout llAll;
        @BindView(R.id.tv_address)
        TextView mTvAddress;

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

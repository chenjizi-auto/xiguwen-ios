package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.graphics.Color;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MyScheduleBean;

import java.util.List;

/**
 * Created by jiang on 2018/1/25.
 */

public class RichengAdapter extends RecyclerView.Adapter<RichengAdapter.ViewHolder> {
    Context mContext;
    int type = 0;


    private List<MyScheduleBean> mDatas;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener1 mListener;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener1 mDeleteListener;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener1 mCompileListener;

    public void setmListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 mListener) {
        this.mListener = mListener;
    }

    public com.jcodecraeer.xrecyclerview.OnItemClickListener1 getmDeleteListener() {
        return mDeleteListener;
    }

    public void setmDeleteListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 mDeleteListener) {
        this.mDeleteListener = mDeleteListener;
    }

    public com.jcodecraeer.xrecyclerview.OnItemClickListener1 getmCompileListener() {
        return mCompileListener;
    }

    public void setmCompileListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 mCompileListener) {
        this.mCompileListener = mCompileListener;
    }

    public RichengAdapter(Context mContext, int type) {
        this.mContext = mContext;
        this.type = type;
    }

    public void setDatas(List<MyScheduleBean> datas) {
        mDatas = datas;
        notifyDataSetChanged();
    }

    public List<MyScheduleBean> getDatas() {
        return mDatas;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_richeng_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder vh, final int position) {
        MyScheduleBean bean = mDatas.get(position);
        if (bean.getIsend() == MyScheduleBean.STATE_UNFINISHED) {
            vh.tvTitle.setTextColor(Color.parseColor("#535353"));
            vh.tvTime.setTextColor(Color.parseColor("#FC5887"));
            vh.cbBox.setImageResource(R.mipmap.richeng_select_un);
        } else {
            vh.tvTitle.setTextColor(Color.parseColor("#898989"));
            vh.tvTime.setTextColor(Color.parseColor("#b3b3b3"));
//            vh.cbBox.setChecked(true);
            vh.cbBox.setImageResource(R.mipmap.richeng_select);
        }
        MyScheduleBean data = mDatas.get(position);
        vh.tvTitle.setText(data.getConn());
        vh.tvTime.setText(data.getStatime() + " - " + data.getEndtime());
        vh.cbBox.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mListener != null) {
                    mListener.onItemClick(v, position, mDatas.get(position));
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        //        @BindView(R.id.tv_title)
        TextView tvTitle;
        //        @BindView(R.id.tv_time)
        TextView tvTime;
        //        @BindView(R.id.cb_chexk)
        ImageView cbBox;

        ViewHolder(View view) {
            super(view);
//            ButterKnife.bind(this, view);
            tvTitle = view.findViewById(R.id.tv_title);
            tvTime = view.findViewById(R.id.tv_time);
            cbBox = view.findViewById(R.id.cb_chexk);
        }
    }
}

package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MyGradeBean;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class MineDangqi2Adapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private final int TYPE_GROUP = 0x100;
    private final int TYPE_CHILD = 0x101;

    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;

    private List<MyGradeBean> mDatas;

    public void setItemClickListener(com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }

    public MineDangqi2Adapter(Context mContext) {
        this.mContext = mContext;
        mDatas = new ArrayList<>();
    }

    public void setDatas(List<MyGradeBean> datas){
        mDatas.clear();
        if(datas != null){
            mDatas.addAll(datas);
        }
        notifyDataSetChanged();
    }

    public void addDatas(List<MyGradeBean> datas){
        if(datas != null){
            for (MyGradeBean bean : mDatas) {
                for (MyGradeBean data : datas) {
                    if(bean.getDateye().equals(data.getDateye())){  // 如果时间属于同一区域，那么就添加到原有数据上，否则作为新数据添加
                        bean.getA().addAll(data.getA());
                        datas.remove(data);
                        break;
                    }
                }
            }
            mDatas.addAll(datas);
            notifyDataSetChanged();
        }
    }

    @Override
    public int getItemViewType(int position) {    //[0:[3] ,1:[2]  2:[1] 3:[3]]    0:g    1-3:c  4:g  5-6:c 7:g
        int cache = 0;
        for (MyGradeBean bean : mDatas) {
            if(position == cache){
                return TYPE_GROUP;
            }else if(position > cache && position <= cache + bean.getA().size()){
                return TYPE_CHILD;
            }
            cache ++;
            cache += bean.getA().size();
        }
        return TYPE_CHILD;
    }

    public MyGradeBean getGroup(int position){
        int cache = 0;
        for (MyGradeBean mData : mDatas) {
            cache ++;
            cache += mData.getA().size();
            if(position < cache){
                return mData;
            }
        }
        return null;
    }

    public MyGradeBean.Grade getChild(int position){
        for (MyGradeBean mData : mDatas) {
            position --;
            if(position < mData.getA().size()){
                return mData.getA().get(position);
            }else{
                position -= mData.getA().size();
            }
        }
        return null;
    }

    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        if(viewType == TYPE_GROUP){
            return new GroupViewHolder(LayoutInflater.from(mContext).inflate(R.layout.item_dangqi_layout, parent, false));
        }else{
            return new ChildViewHolder(LayoutInflater.from(mContext).inflate(R.layout.item_dangqi_item_layout, parent, false));
        }
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder vh, int position) {
        if(vh instanceof GroupViewHolder){
            MyGradeBean group = getGroup(position);
            if(group != null){
                ((GroupViewHolder) vh).tvData.setText(group.getDateye());
                ((GroupViewHolder) vh).tvOrderNum.setText(String.format("共 %d 单", group.getDanshu()));
            }
        }else{
            MyGradeBean.Grade child = getChild(position);
            if(child != null){
                ChildViewHolder cv = (ChildViewHolder) vh;
                String[] date = null;
                String day = "-";
                try {
                    date = child.getDate().split("-");
                } catch (Exception e) {
                    com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                }
                if(date != null && date.length == 3){
                    day = date[2];
                }
                cv.tvWhenName.setText(String.format("%s日(%s) %s", day, child.getTimeslot(), child.getContacts()));
                cv.tvNumber.setText(child.getContactnumber());
                cv.ivIsShengcheng.setVisibility(child.isXiTong() ? View.VISIBLE : View.GONE);
                cv.ivIsTixing.setVisibility(child.isRemind() ? View.VISIBLE : View.GONE);
            }
        }
    }

    @Override
    public int getItemCount() {
        int count;
        if(mDatas == null){
            return 0;
        }else{
            count = mDatas.size();
            for (MyGradeBean mData : mDatas) {
                count += mData.getA().size();
            }
        }
        return count;
    }

    class GroupViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_data)
        TextView tvData;
        @BindView(R.id.tv_order_num)
        TextView tvOrderNum;
        @BindView(R.id.recycle)
        RecyclerView recycle;

        GroupViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }


    class ChildViewHolder  extends RecyclerView.ViewHolder{
        @BindView(R.id.tv_when_name)
        TextView tvWhenName;
        @BindView(R.id.tv_number)
        TextView tvNumber;
        @BindView(R.id.iv_is_tixing)
        ImageView ivIsTixing;
        @BindView(R.id.iv_is_shengcheng)
        ImageView ivIsShengcheng;

        ChildViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if(itemClickListener!=null){
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        itemClickListener.onItemClick(v,getPosition());
                    }
                });
            }
        }
    }
}

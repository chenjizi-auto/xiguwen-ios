package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RadioButton;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/22.
 */

public class GoodsTypeAdapter extends RecyclerView.Adapter<GoodsTypeAdapter.ViewHolder> {
    private List<String> mList;
    private Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener listener;
    private int mClick_num=-1;

    public GoodsTypeAdapter(List<String> mList, Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener listener) {
        this.mList = mList;
        this.mContext = mContext;
        this.listener=listener;
    }

    public GoodsTypeAdapter(List<String> mList, Context mContext) {
        this.mList = mList;
        this.mContext = mContext;
    }

    @Override
    public GoodsTypeAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_pop_cart_type_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(GoodsTypeAdapter.ViewHolder vh, int position) {
        vh.rbPayAll.setText(mList.get(position));
        if(mClick_num==position){
            vh.rbPayAll.setChecked(true);
        }else{
            vh.rbPayAll.setChecked(false);
        }
    }

    private void setChoose(int position){
        mClick_num=position;
        this.notifyDataSetChanged();
    }

    @Override
    public int getItemCount() {
        return mList == null ? 0 : mList.size();
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.rb_pay_all)
        RadioButton rbPayAll;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if(listener!=null){
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        listener.onItemClick(view,getPosition());
                        setChoose(getPosition());
                    }
                });
            }
        }
    }
}

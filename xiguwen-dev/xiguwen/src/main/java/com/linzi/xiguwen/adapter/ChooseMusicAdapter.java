package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.graphics.drawable.AnimationDrawable;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MusicBean;
import com.linzi.xiguwen.ui.ChooseMusicActivity;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/15.
 */

public class ChooseMusicAdapter extends RecyclerView.Adapter<ChooseMusicAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    private List<MusicBean.DataBean> mList;
    private AnimationDrawable frameAnim;

    public ChooseMusicAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.itemClickListener = itemClickListener;
        frameAnim = (AnimationDrawable) mContext.getResources().getDrawable(R.drawable.bofang_list);
    }

    @Override
    public ChooseMusicAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.pop_item_arrow_list, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ChooseMusicAdapter.ViewHolder vh, int position) {
        MusicBean.DataBean musicBean = mList.get(position);
        vh.iv_bofang_icon.setBackgroundDrawable(frameAnim);
        if (musicBean == ChooseMusicActivity.getChooseMusic()) {
            frameAnim.start();
            vh.ivSelect.setVisibility(View.VISIBLE);
            vh.iv_bofang_icon.setVisibility(View.VISIBLE);
            vh.tvSelectTxt.setTextColor(mContext.getResources().getColor(R.color.colorTitleRed));
        } else {
            frameAnim.stop();
            vh.ivSelect.setVisibility(View.GONE);
            vh.iv_bofang_icon.setVisibility(View.GONE);
            vh.tvSelectTxt.setTextColor(mContext.getResources().getColor(R.color.title_sign));
        }
        vh.tvSelectTxt.setText(musicBean.getTitile());
//        if(position<=3){
//            vh.ivIsHot.setVisibility(View.VISIBLE);
//        }else{
//            vh.ivIsHot.setVisibility(View.GONE);
//        }
    }

    @Override
    public int getItemCount() {
        return mList == null ? 0 : mList.size();
    }

    public void setList(List<MusicBean.DataBean> datas) {
        mList = datas;
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_select_txt)
        TextView tvSelectTxt;
        @BindView(R.id.iv_select)
        ImageView ivSelect;
        @BindView(R.id.iv_is_hot)
        ImageView ivIsHot;
        @BindView(R.id.iv_bofang_icon)
        ImageView iv_bofang_icon;

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
}

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
import com.linzi.xiguwen.bean.WeddingNewsBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class MineNewsAdapter extends RecyclerView.Adapter<MineNewsAdapter.ViewHolder> {
    private final List<WeddingNewsBean> mDatas;
    private final com.jcodecraeer.xrecyclerview.OnItemClickListener clickListener;
    private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    Context mContext;

    public MineNewsAdapter(Context mContext, List<WeddingNewsBean> datas,  com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.mDatas = datas;
        this.clickListener = itemClickListener;
    }

    @Override
    public MineNewsAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_news_adapter, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MineNewsAdapter.ViewHolder vh, int position) {
        WeddingNewsBean newsBean = mDatas.get(position);
        vh.tvTitle.setText(newsBean.getTitle());
        Date date = new Date(newsBean.getCreatetime() * 1000L);
        vh.tvTime.setText(format.format(date));
        GlideLoad.GlideLoadImg(mContext, newsBean.getImg(), vh.tvIvNew);
    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

     class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_iv_new)
        ImageView tvIvNew;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            view.setOnClickListener(this);
        }

         @Override
         public void onClick(View v) {
             if(clickListener != null){
                 clickListener.onItemClick(v, getAdapterPosition());
             }
         }
     }
}

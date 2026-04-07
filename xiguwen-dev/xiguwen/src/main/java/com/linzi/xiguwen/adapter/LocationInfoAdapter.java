package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.baidu.mapapi.search.sug.SuggestionResult;
import com.jcodecraeer.xrecyclerview.XRecyclerView;

import java.util.List;

/**
 * Created by jiang on 2018/1/24.
 */

public class LocationInfoAdapter extends RecyclerView.Adapter<LocationInfoAdapter.ViewHolder>{
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener listener;
    List<SuggestionResult.SuggestionInfo> mInfo;

    public LocationInfoAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener listener, List<SuggestionResult.SuggestionInfo> mInfo) {
        this.mContext = mContext;
        this.listener = listener;
        this.mInfo = mInfo;
    }

    @Override
    public LocationInfoAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        TextView tv_location=new TextView(mContext);
        return new ViewHolder(tv_location);
    }

    @Override
    public void onBindViewHolder(LocationInfoAdapter.ViewHolder vh, int position) {

        vh.tv_location.setText(mInfo.get(position).key);
    }

    @Override
    public int getItemCount() {
        return mInfo==null?0:mInfo.size();
    }
    class ViewHolder extends RecyclerView.ViewHolder{
        TextView tv_location;
        LinearLayout.LayoutParams params=new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,dip2px(mContext,30));
        public ViewHolder(View itemView) {
            super(itemView);
            tv_location= (TextView) itemView;
            params.gravity= Gravity.CENTER;
            tv_location.setLayoutParams(params);
            if(listener!=null){
                itemView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        listener.onItemClick(view,getPosition());
                    }
                });
            }
        }
    }

    //将dp转换为px
    public  int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }
}

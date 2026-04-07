package com.linzi.xiguwen.adapter.discover;

import android.content.Context;
import android.graphics.Color;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ClassificationBean;

import java.util.List;

/**
 * Created by devin on 2018/4/11 14:01
 * Description
 */

public class JobSerachAdapter extends RecyclerView.Adapter<JobSerachAdapter.ViewHolder> {
    private List<ClassificationBean> list;
    private int index;
    private Context context;

    public JobSerachAdapter(Context context){
        this.context=context;
    }

    private void setIndex(int index) {
        this.index = index;
        notifyDataSetChanged();
    }

    public void setData(List<ClassificationBean> list) {
        this.list = list;
        notifyDataSetChanged();
    }

    @Override
    public JobSerachAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.find_text_item, parent, false);
        return new JobSerachAdapter.ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(JobSerachAdapter.ViewHolder holder, int position) {
        holder.textView.setTextColor(position == index ? Color.parseColor("#FFFC5888") : Color.parseColor("#FF262626"));
        holder.textView.setText(list.get(position).getProname());
    }

    @Override
    public int getItemCount() {
        return list == null ? 0 : list.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        TextView textView;

        public ViewHolder(View itemView) {
            super(itemView);
            textView = (TextView) itemView.findViewById(R.id.tv_title);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    int position=getAdapterPosition();
                    setIndex(position);
                    if (listener!=null){
                        listener.jobSecector(list.get(position));
                    }
                }
            });

        }
    }
    private JobSearchListener listener;

    public void setListener(JobSearchListener listener) {
        this.listener = listener;
    }

    public interface  JobSearchListener{
        void jobSecector(ClassificationBean bean);
    }

}

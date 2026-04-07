package com.linzi.xiguwen.adapter;

import android.content.Context;

import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.SpecialRecommendBean;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.location.JumpUtil;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/5.
 */

public class SpecialRecommendedAdapter extends RecyclerView.Adapter<SpecialRecommendedAdapter.ViewHolder> {

    private List<SpecialRecommendBean> list;
    private Context context;
    private String color;

    public SpecialRecommendedAdapter(Context context, String color) {
        this.context = context;
        this.color = color;
    }

    public void setList(List<SpecialRecommendBean> list) {
        this.list = list;
        notifyDataSetChanged();
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.specialrecommended_item_layout, null);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        GlideLoad.GlideLoadImg2(list.get(position).getWapimg(), holder.ivImg);
//        if (color != null && !color.equals("")) {
//            holder.tvTitle.setTextColor(Color.parseColor(color));
//            holder.tvContent.setTextColor(Color.parseColor(color));
//        }
        holder.tvTitle.setText(list.get(position).getTitle() + "");
        holder.tvContent.setText(list.get(position).getText() + "");
    }

    @Override
    public int getItemCount() {
        return list == null ? 0 : list.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_content)
        TextView tvContent;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    JumpUtil.judgeJump(context, list.get(getPosition()).getAptid(), list.get(getPosition()).getAptype(), list.get(getPosition()).getSrc());
                }
            });
        }
    }
}

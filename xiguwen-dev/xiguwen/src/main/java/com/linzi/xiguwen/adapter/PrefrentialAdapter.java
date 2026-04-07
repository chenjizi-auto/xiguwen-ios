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
import com.linzi.xiguwen.bean.MessagePrefrentialBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by PC on 2018-04-06.
 */

public class PrefrentialAdapter extends RecyclerView.Adapter<PrefrentialAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener1 mListener;

    private List<MessagePrefrentialBean.PrefrentialList> mBens;


    public void addMore(List<MessagePrefrentialBean.PrefrentialList> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<MessagePrefrentialBean.PrefrentialList> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }


    public PrefrentialAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener1 mListener) {
        this.mContext = mContext;
        this.mListener = mListener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_message_prefrential, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, int position) {
        vh.displayBean(mBens.get(position));
    }

    @Override
    public int getItemCount() {
        return mBens == null ? 0 : mBens.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {

        @BindView(R.id.pre_createtime)
        TextView preCreatetime;
        @BindView(R.id.pre_title)
        TextView preTitle;
        @BindView(R.id.pre_image)
        ImageView preImage;
        @BindView(R.id.pre_content)
        TextView preContent;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (mListener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        mListener.onItemClick(view, getPosition(),mBens.get(getAdapterPosition()));
                    }
                });
            }
        }

        void displayBean(MessagePrefrentialBean.PrefrentialList bean) {
            GlideLoad.GlideLoadImg(bean.getImg(), preImage);
            preTitle.setText(bean.getTitle()+"");
            preContent.setText(bean.getContent()+"");
            preCreatetime.setText(bean.getCreatetime());

        }
    }
}

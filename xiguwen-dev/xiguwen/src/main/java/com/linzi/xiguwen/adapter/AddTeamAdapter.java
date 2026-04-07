package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.RecyclerView.Adapter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.communityAddEntity;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class AddTeamAdapter extends Adapter<AddTeamAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    private List<communityAddEntity> mBens;

    public void addMore(List<communityAddEntity> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<communityAddEntity> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }


    public void setItemClickListener(com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }

    public AddTeamAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public List<communityAddEntity> getmBens() {
        return mBens;
    }

    @Override
    public AddTeamAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_add_team_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(AddTeamAdapter.ViewHolder vh, int position) {
        communityAddEntity entity = mBens.get(position);
        GlideLoad.GlideLoadImg(entity.getLogourl(), vh.ivHead);
        vh.tvName.setText(entity.getName() + "");
        vh.tvZhiye.setText(entity.getType() + "");
        vh.tvLocation.setText(entity.getAddressd() + "");
        vh.tvPeoNum.setText("成员 " + entity.getRenshu() + "");
        if (entity.getStatus() == 1) {
            vh.btIn.setText("退出");
        } else if (entity.getStatus() == 3) {
            vh.btIn.setText("同意加入");
        } else if (entity.getStatus() == 4) {
            vh.btIn.setText("等待同意");
        } else {
            vh.btIn.setText("申请加入");
        }
    }

    @Override
    public int getItemCount() {
        return mBens == null ? 0 : mBens.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_zhiye)
        TextView tvZhiye;
        @BindView(R.id.tv_peo_num)
        TextView tvPeoNum;
        @BindView(R.id.tv_location)
        TextView tvLocation;
        @BindView(R.id.bt_in)
        Button btIn;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (itemClickListener != null) {
                btIn.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        itemClickListener.onItemClick(v, getPosition());
                    }
                });
            }
        }
    }
}

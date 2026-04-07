package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CommunityUserEntity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class ChengyuanManagerAdapter extends RecyclerView.Adapter<ChengyuanManagerAdapter.ViewHolder> {
    Context mContext;

    com.jcodecraeer.xrecyclerview.OnItemClickListener1 closeListener;
    com.jcodecraeer.xrecyclerview.OnItemClickListener1 chooseGoodsListener;
    private List<CommunityUserEntity> mBens;
    private int myjiaose;

    public void setMyjiaose(int myjiaose) {
        this.myjiaose = myjiaose;
    }

    public void addMore(List<CommunityUserEntity> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<CommunityUserEntity> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }


    public List<CommunityUserEntity> getDatas() {
        return mBens;
    }

    public void setCloseListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 closeListener) {
        this.closeListener = closeListener;
    }

    public void setChooseGoodsListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 chooseGoodsListener) {
        this.chooseGoodsListener = chooseGoodsListener;
    }

    public ChengyuanManagerAdapter(Context mContext) {
        this.mContext = mContext;
    }


    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_cheng_yuan_manager, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, final int position) {
        final CommunityUserEntity entity = mBens.get(position);
        vh.tvName.setText(entity.getNickname() + "");
        vh.tvZhiwei.setText(entity.getOccupationid());
        GlideLoad.GlideLoadCircle(entity.getHead(), vh.ivHead);
        vh.tvAddress.setText(entity.getDizhi() + "");
        int type = entity.getJiaose();

        if (myjiaose == 1) {
            if (type == 1) {
                vh.btQuxiaoAdmin.setVisibility(View.GONE);
                vh.btAddAdmin.setVisibility(View.GONE);
            } else if (type == 2) {
                vh.btQuxiaoAdmin.setVisibility(View.VISIBLE);
                vh.btAddAdmin.setVisibility(View.GONE);
                if (closeListener != null) {
                    vh.btQuxiaoAdmin.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            closeListener.onItemClick(v, position, entity);
                        }
                    });
                }
            } else {
                vh.btQuxiaoAdmin.setVisibility(View.GONE);
                vh.btAddAdmin.setVisibility(View.VISIBLE);
                if (chooseGoodsListener != null) {
                    vh.btAddAdmin.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            chooseGoodsListener.onItemClick(v, position, entity);
                        }
                    });

                }
            }
        } else {
            vh.btQuxiaoAdmin.setVisibility(View.GONE);
            vh.btAddAdmin.setVisibility(View.GONE);
        }

        if (type == 1) {
            vh.ivIsAdmin.setVisibility(View.VISIBLE);
        } else {
            vh.ivIsAdmin.setVisibility(View.GONE);
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
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.iv_is_admin)
        ImageView ivIsAdmin;
        @BindView(R.id.tv_phone)
        TextView tvAddress;
        @BindView(R.id.bt_quxiao_admin)
        Button btQuxiaoAdmin;
        @BindView(R.id.bt_add_admin)
        Button btAddAdmin;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            ivHead.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(mContext, NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", mBens.get(getPosition()).getUserid());
                    mContext.startActivity(intent);
                }
            });
        }
    }
}

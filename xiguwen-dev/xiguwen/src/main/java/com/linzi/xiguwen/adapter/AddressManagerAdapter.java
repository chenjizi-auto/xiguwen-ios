package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.AddressEntity;
import com.linzi.xiguwen.ui.AddressManagerActivity;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/30.
 */

public class AddressManagerAdapter extends RecyclerView.Adapter<AddressManagerAdapter.ViewHolder> {
    private Context mContext;
    private int tag = 0;

    private List<AddressEntity> mBeans;
    private int defaultPosition;

    com.jcodecraeer.xrecyclerview.OnItemClickListener1 mDeleteListener;
    com.jcodecraeer.xrecyclerview.OnItemClickListener1 mDefaultListener;
    com.jcodecraeer.xrecyclerview.OnItemClickListener1 mUpdateListener;

    public AddressManagerAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void addFirst(List<AddressEntity> mBeans) {
        this.mBeans = mBeans;
        notifyDataSetChanged();

    }

    public List<AddressEntity> getDatas() {
        return mBeans;
    }

    public int getDefaultPosition() {
        return defaultPosition;
    }


    public void setmDeleteListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 mDeleteListener) {
        this.mDeleteListener = mDeleteListener;
    }

    public void setmDefaultListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 mDefaultListener) {
        this.mDefaultListener = mDefaultListener;
    }

    public void setmUpdateListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 mUpdateListener) {
        this.mUpdateListener = mUpdateListener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_address_manager_layout, parent, false);
        return new ViewHolder(view);
    }

    public void setTag(int tag) {
        this.tag = tag;
        this.notifyDataSetChanged();
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, final int position) {
        final AddressEntity entity = mBeans.get(position);
        vh.tvName.setText(entity.getUsername() + "");
        vh.tvPhone.setText(entity.getMobile() + "");
        vh.tvAddress.setText(entity.getSite() + "");
        if (entity.getHot() == 1) {
            vh.tvIsDef.setVisibility(View.VISIBLE);
            defaultPosition = position;
            vh.cbChoose.setImageResource(R.drawable.icon_check_red);
        } else {
            vh.tvIsDef.setVisibility(View.GONE);
            vh.cbChoose.setImageResource(R.drawable.icon_check_un_red);
        }
        if (tag == 0) {
            vh.llManager.setVisibility(View.GONE);
        } else {
            vh.llManager.setVisibility(View.VISIBLE);
        }

        vh.tvDel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mDeleteListener != null) {
                    mDeleteListener.onItemClick(v, position, entity.getId());
                }
            }
        });

        vh.tvMoren.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mDefaultListener != null && entity.getHot() != 1) {
                    mDefaultListener.onItemClick(v, position, entity.getId());
                }
            }
        });
        vh.tvEdit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mUpdateListener != null) {
                    mUpdateListener.onItemClick(v, position, entity);
                }
            }
        });
        vh.cbChoose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mDefaultListener != null && entity.getHot() != 1) {
                    mDefaultListener.onItemClick(v, position, entity.getId());
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return mBeans == null ? 0 : mBeans.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_phone)
        TextView tvPhone;
        @BindView(R.id.tv_is_def)
        TextView tvIsDef;
        @BindView(R.id.tv_address)
        TextView tvAddress;
        @BindView(R.id.cb_choose)
        ImageView cbChoose;
        @BindView(R.id.tv_moren)
        TextView tvMoren;
        @BindView(R.id.tv_edit)
        TextView tvEdit;
        @BindView(R.id.tv_del)
        TextView tvDel;
        @BindView(R.id.ll_manager)
        LinearLayout llManager;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    EventBusUtil.sendEvent(new Event(EventCode.SELECT_ADDRESS, mBeans.get(getPosition())));
                    ((AddressManagerActivity) mContext).finish();
                }
            });
        }
    }

}

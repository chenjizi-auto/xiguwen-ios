package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CaseListBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/25.
 */

public class NewExampleFragmentAdapter extends RecyclerView.Adapter<NewExampleFragmentAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener listener;
    private List<CaseListBean.DataBean> mlist;
    private CallBack.CaseCareClikListener caseCareClikListener;
    private CallBack.CaseUserClikListener caseUserClikListener;

    public void clearList() {
        mlist.clear();
        notifyDataSetChanged();
    }

    public void setListener(com.jcodecraeer.xrecyclerview.OnItemClickListener listener) {
        this.listener = listener;
        this.notifyDataSetChanged();
    }

    public void setListener(CallBack.CaseCareClikListener caseCareClikListener) {
        this.caseCareClikListener = caseCareClikListener;
        this.notifyDataSetChanged();
    }

    public void setListener(CallBack.CaseUserClikListener caseUserClikListener) {
        this.caseUserClikListener = caseUserClikListener;
        this.notifyDataSetChanged();
    }

    public NewExampleFragmentAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.listener = itemClickListener;
    }

    @Override
    public NewExampleFragmentAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_example_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(NewExampleFragmentAdapter.ViewHolder vh, final int position) {
        GlideLoad.GlideLoadImg(mContext, mlist.get(position).getWeddingcover(), vh.ivImg);
        GlideLoad.GlideLoadCircle(mContext, mlist.get(position).getHead(), vh.ivHeader);
        vh.tvName.setText(mlist.get(position).getNickname());
        vh.tvTitle.setText(mlist.get(position).getTitle());
        vh.tvPrice.setText(Constans.RMB + mlist.get(position).getWeddingexpenses());
        vh.tvSign.setText(mlist.get(position).getWeddingdescribe());
        vh.tvSeeCount.setText(mlist.get(position).getClicked() + "");
        vh.tvCareCount.setText(mlist.get(position).getGoodscore() + "");
        vh.tvPingjiaCount.setText(mlist.get(position).getCommented() + "");
        if (mlist.get(position).getAfollow() == 1) {
            vh.btCare.setBackgroundResource(R.mipmap.icon_close_care);
        } else if (mlist.get(position).getAfollow() == 0) {
            vh.btCare.setBackgroundResource(R.mipmap.icon_add_care);
        }
        if (listener != null) {
            vh.btCare.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    listener.onItemClick(view, position);
                }
            });
        }
        if (caseCareClikListener != null) {
            vh.btCare.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    caseCareClikListener.CaseCareClik(position);
                }
            });
        }
        if (caseUserClikListener != null) {
            vh.ivHeader.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    caseUserClikListener.CaseUserClik(position);
                }
            });
            vh.tvName.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    caseUserClikListener.CaseUserClik(position);
                }
            });
        }
    }

    @Override
    public int getItemCount() {
        if (mlist == null) {
            return 0;
        } else {
            return mlist.size();
        }
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.iv_header)
        ImageView ivHeader;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.bt_care)
        Button btCare;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_sign)
        TextView tvSign;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;
        @BindView(R.id.tv_care_count)
        TextView tvCareCount;
        @BindView(R.id.tv_pingjia_count)
        TextView tvPingjiaCount;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (listener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        listener.onItemClick(view, getPosition());
                    }
                });
            }
        }
    }

    public void setData(List<CaseListBean.DataBean> mList) {
        this.mlist = mList;
        this.notifyDataSetChanged();
    }

    public void addData(List<CaseListBean.DataBean> mlist) {
        this.mlist.addAll(mlist);
        this.notifyDataSetChanged();
    }

    public void addMore(List<CaseListBean.DataBean> bens) {
        if (bens == null)
            return;
        if (mlist == null) {
            mlist = new ArrayList<>();
        }
        mlist.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<CaseListBean.DataBean> bens) {
        if (mlist == null) {
            mlist = new ArrayList<>();
        }
        mlist.clear();
        mlist.addAll(bens);
        notifyDataSetChanged();
    }

    public List<CaseListBean.DataBean> getData() {
        return this.mlist;
    }

    //刷新关注按钮
    public void refreshCare(int position, int type) {
        //type 1关注，0关注
        mlist.get(position).setAfollow(type);
        this.notifyDataSetChanged();
    }

}

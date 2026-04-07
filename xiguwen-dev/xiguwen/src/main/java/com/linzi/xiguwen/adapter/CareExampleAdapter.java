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

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CaseBean;
import com.linzi.xiguwen.ui.NewExampleDetailsActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/3.
 */

public class CareExampleAdapter extends RecyclerView.Adapter<CareExampleAdapter.ViewHolder> {
    private Context mContext;
    private List<CaseBean.DataBean> mBens;
    private CallBack.CaseCareClikListener careClikListener;

    public CareExampleAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void setCareClikListener(CallBack.CaseCareClikListener careClikListener) {
        this.careClikListener = careClikListener;
    }

    public void addMore(List<CaseBean.DataBean> bens) {
        if (bens == null || bens.isEmpty())
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<CaseBean.DataBean> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        if (bens != null && !bens.isEmpty()) {
            mBens.addAll(bens);
        }
        notifyDataSetChanged();
    }

    public List<CaseBean.DataBean> getDatas() {
        return mBens;
    }

    @Override
    public CareExampleAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.fragment_care_example, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CareExampleAdapter.ViewHolder vh, final int position) {
        CaseBean.DataBean entity = mBens.get(position);
        GlideLoad.GlideLoadImg(mContext, entity.getWeddingcover(), vh.ivHeadImg);
        vh.tvTitle.setText(entity.getTitle() + "");
        vh.tvCareNum.setText("关注" + entity.getFollowed());
        vh.tvPrice.setText("￥" + entity.getWeddingexpenses());
        vh.tvContent.setText(entity.getWeddingdescribea() + "");
        vh.btnCare.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (careClikListener != null) {
                    careClikListener.CaseCareClik(position);
                }
            }
        });

    }

    @Override
    public int getItemCount() {
        return mBens == null ? 0 : mBens.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_head_img)
        ImageView ivHeadImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_content)
        TextView tvContent;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_care_num)
        TextView tvCareNum;
        @BindView(R.id.expanded_attention)
        Button btnCare;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(mContext, NewExampleDetailsActivity.class);
                    intent.putExtra("caseid", mBens.get(getPosition()).getId());
                    mContext.startActivity(intent);
                }
            });
        }
    }

    public void remove(int position) {
        if (mBens != null && position < mBens.size()) {
            mBens.remove(position);
            notifyDataSetChanged();
        }
    }
}

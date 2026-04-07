package com.linzi.xiguwen.base.adapter;

import androidx.recyclerview.widget.RecyclerView;
import android.view.View;

import butterknife.ButterKnife;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  18:58
 *
 * @author luyongjiang
 * @version 1.0
 */
public abstract class BaseViewHolder<DATA> extends RecyclerView.ViewHolder {


    public BaseViewHolder(View itemView) {
        super(itemView);
        ButterKnife.bind(this, itemView);
    }


    public void dispatchData(DATA data) {
        bindView(data);
    }

    protected abstract void bindView(DATA data);
}
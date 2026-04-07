package com.linzi.xiguwen.fragment.club.dele;

import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;

import butterknife.BindView;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/29  10:39
 *
 * @author luyongjiang
 * @version 1.0
 */
public class AllActionNumberHolder extends BaseViewHolder<String> {
    @BindView(R.id.tv_name)
    TextView tvName;

    public AllActionNumberHolder(View itemView) {
        super(itemView);
    }

    @Override
    protected void bindView(String s) {
        tvName.setText(s);
    }
}

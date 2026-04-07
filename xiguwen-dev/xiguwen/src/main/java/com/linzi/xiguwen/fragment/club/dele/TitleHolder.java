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
 * CreateTime:2018/3/29  10:46
 *
 * @author luyongjiang
 * @version 1.0
 */
public class TitleHolder extends BaseViewHolder<String> {

    public TitleHolder(View itemView) {
        super(itemView);
    }

    @BindView(R.id.tv_name)
    TextView tvName;

    @Override
    protected void bindView(String s) {
        tvName.setText(s);
    }
}

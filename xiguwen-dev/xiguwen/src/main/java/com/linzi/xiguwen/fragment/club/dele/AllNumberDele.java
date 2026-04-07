package com.linzi.xiguwen.fragment.club.dele;

import android.view.View;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/29  10:38
 *
 * @author luyongjiang
 * @version 1.0
 */
public class AllNumberDele extends CreateHolderDelegate<String> {

    @Override
    protected int getLayoutRes() {
        return R.layout.item_tv;
    }

    @Override
    protected BaseViewHolder onCreateHolder(View itemView) {
        return new AllActionNumberHolder(itemView);
    }
}

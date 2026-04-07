package com.linzi.xiguwen.fragment.club.clubperson;

import android.os.Bundle;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.NewBaseFragment;
import com.linzi.xiguwen.bean.SynamicdetailsBean;
import com.linzi.xiguwen.dele.ActionDelegate;

/**
 * Title:
 * Description:跳转到个人详情之后的页面
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/28  09:07
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ClubPersonHeadFragment extends NewBaseFragment {

    private ActionDelegate.ActionHolder mHolder;
    public static final String BEAN_KEY = "bean";


    public static ClubPersonHeadFragment createFragment(SynamicdetailsBean dynamiclistBean) {
        ClubPersonHeadFragment fragment = new ClubPersonHeadFragment();
        Bundle args = new Bundle();
        args.putParcelable(BEAN_KEY, dynamiclistBean);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public int onLayoutId() {
        return R.layout.item_news_club_person_head_activities_layout;
    }

    @Override
    public void initView() {
        mHolder = new ActionDelegate.ActionHolder(mView);
        mHolder.bindValue((SynamicdetailsBean) getArguments().getParcelable(BEAN_KEY));
    }


}

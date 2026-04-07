package com.linzi.xiguwen.fragment.club;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.NewBaseFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.ShetuanIndexBean;
import com.linzi.xiguwen.dele.ActionDelegate;
import com.linzi.xiguwen.fragment.club.dele.AllNumberDele;
import com.linzi.xiguwen.ui.NewClubDetailsModel;

import butterknife.BindView;

/**
 * Title:动态
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  12:06
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ActionFragment extends NewBaseFragment {


    public static Fragment create() {
        return new ActionFragment();
    }


    @Override
    public int onLayoutId() {
        return R.layout.fr_action;
    }

    @BindView(R.id.rv_list)
    RecyclerView mRecyclerView;

    @Override
    public void initView() {
        CreateHolderDelegate<ShetuanIndexBean.DynamiclistBean> delegate = ActionDelegate.create();
        BaseAdapter newsAdapter = BaseAdapter.createBaseAdapter()
                .injectHolderDelegate(allNumberDele)
                .injectHolderDelegate(delegate);
        delegate.setData(((NewClubDetailsModel) getActivity()).getActionList());
        allNumberDele.cleanAfterAddData("全部动态 (" + ((NewClubDetailsModel) getActivity()).getActionList().size() + ")");
        mRecyclerView.setLayoutManager(newsAdapter.createLayoutManager(getContext()));
        mRecyclerView.setAdapter(newsAdapter);

    }


    CreateHolderDelegate<String> allNumberDele = new AllNumberDele();

}

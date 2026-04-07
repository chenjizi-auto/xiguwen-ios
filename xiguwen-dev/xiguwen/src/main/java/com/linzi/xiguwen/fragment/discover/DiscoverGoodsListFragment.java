package com.linzi.xiguwen.fragment.discover;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.DianzanAdapter;
import com.linzi.xiguwen.bean.SynamicdetailsBean;

import java.util.List;

import butterknife.BindView;

/**
 * Created by devin on 2018/4/12 10:53
 * Description
 */

/**
 * 动态详情点赞列表
 */
public class DiscoverGoodsListFragment extends BaseFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;

    DianzanAdapter mAdapter;

    public static DiscoverGoodsListFragment newInstance() {
        DiscoverGoodsListFragment fragment = new DiscoverGoodsListFragment();
        return fragment;
    }

    @Override
    public int setlayoutResID() {
        return R.layout.fragment_discover_recycle_layout;
    }

    @Override
    public void initView() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        recycle.setLayoutManager(manager);
        mAdapter = new DianzanAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {

            }
        });
        recycle.setAdapter(mAdapter);
    }

    @Override
    protected void initEvents() {

    }

    @Override
    public void initData() {

    }

    public void setData(List<SynamicdetailsBean.ZanlistBean> datas) {
        if (mAdapter != null) {
            mAdapter.addFirst(datas);
        }
    }
}

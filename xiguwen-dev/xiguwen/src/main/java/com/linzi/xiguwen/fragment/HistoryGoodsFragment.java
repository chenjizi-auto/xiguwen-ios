package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.GoodsAdapter;
import com.linzi.xiguwen.base.BaseFragment;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class HistoryGoodsFragment extends BaseFragment {


    @BindView(R.id.recycle)
    RecyclerView recycle;

    private int flag = -1;

    private boolean isPrepare = false;

    private GoodsAdapter mAdapter;

    public static HistoryGoodsFragment newInstance(int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        HistoryGoodsFragment fragment = new HistoryGoodsFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_mall_index_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initViews();
    }

    private void initViews() {
        Bundle bu = getArguments();
        flag = bu.getInt("type");

        GridLayoutManager manager = new GridLayoutManager(getActivity(),2);
        recycle.setLayoutManager(manager);
        mAdapter = new GoodsAdapter(flag, getActivity());
        recycle.setAdapter(mAdapter);
    }

    @Override
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }
}

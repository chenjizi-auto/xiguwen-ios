package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MallActivitiesAdapter;
import com.linzi.xiguwen.view.CustomViewPager;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/21.
 */

public class MallActivitiesFragment extends Fragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;

    MallActivitiesAdapter mAdapter;

    View view;

    CustomViewPager vp;
    private int shop_id;

    public static MallActivitiesFragment newInstance(int shop_id) {
        MallActivitiesFragment fragment = new MallActivitiesFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("shop_id", shop_id);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_mall_index_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        vp = (CustomViewPager) getActivity().findViewById(R.id.view_pager);
        vp.setObjectForPosition(view, 4);
        initView();
        shop_id = getArguments().getInt("shop_id");
    }

    private void initView() {
        recycle.setFocusable(false);
        LinearLayoutManager manager = new LinearLayoutManager(getActivity()) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter = new MallActivitiesAdapter(getActivity());
        recycle.setAdapter(mAdapter);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

}

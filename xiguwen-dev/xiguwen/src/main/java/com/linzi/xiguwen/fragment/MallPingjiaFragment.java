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
import com.linzi.xiguwen.adapter.MallIndexAdapter;
import com.linzi.xiguwen.view.CustomViewPager;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/4.
 */

public class MallPingjiaFragment extends Fragment {
    CustomViewPager vp;
    View view;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    private int shop_id;

    public static MallPingjiaFragment newInstance(int shop_id) {
        MallPingjiaFragment fragment = new MallPingjiaFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("shop_id", shop_id);
        fragment.setArguments(bundle);
        return fragment;
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_mall_index_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        vp = (CustomViewPager) getActivity().findViewById(R.id.view_pager);
        vp.setObjectForPosition(view, 3);
        initViews();
        shop_id = getArguments().getInt("shop_id");
    }

    private void initViews() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity()) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        MallIndexAdapter.PingjiaAdapter adapter = new MallIndexAdapter(getActivity()).new PingjiaAdapter();
        recycle.setAdapter(adapter);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

}

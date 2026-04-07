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
import com.linzi.xiguwen.adapter.ClubSomeOneAdapter;
import com.linzi.xiguwen.view.CustomViewPager;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/21.
 */

public class ClubSomeOneFragment extends Fragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;

    ClubSomeOneAdapter mAdapter;

    View view;
    CustomViewPager vp;

    public ClubSomeOneFragment(CustomViewPager vp) {
        this.vp = vp;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_club_detail_activity_layout, null);
        ButterKnife.bind(this, view);
        vp.setObjectForPosition(view,1);
        initView();
        return view;
    }

    private void initView(){
        recycle.setFocusable(false);
        LinearLayoutManager manager=new LinearLayoutManager(getActivity()){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter=new ClubSomeOneAdapter(getActivity());
        recycle.setAdapter(mAdapter);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }
}

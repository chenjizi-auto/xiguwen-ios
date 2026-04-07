package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RadioButton;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.BYXYVideoFragmentAdapter;
import com.linzi.xiguwen.ui.VideoMoreActivity;
import com.linzi.xiguwen.utils.CallBack;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class BYXYVideoFragment extends Fragment {
    @BindView(R.id.rb_all)
    RadioButton rbAll;
    @BindView(R.id.rb_5)
    RadioButton rb5;
    @BindView(R.id.rb_4)
    RadioButton rb4;
    @BindView(R.id.rb_3)
    RadioButton rb3;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    BYXYVideoFragmentAdapter mAdapter;
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_byxy_video_layout, null);
        ButterKnife.bind(this, view);
        initViews();
        return view;
    }

    private void initViews(){

        LinearLayoutManager manager=new LinearLayoutManager(getActivity());
        recycle.setLayoutManager(manager);
        mAdapter=new BYXYVideoFragmentAdapter(getActivity());
        mAdapter.setMoreListener(new CallBack.MoreListener() {
            @Override
            public void more(int in) {
                Intent intent=new Intent(getActivity(),VideoMoreActivity.class);
                startActivity(intent);
            }
        });
        recycle.setAdapter(mAdapter);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }
}

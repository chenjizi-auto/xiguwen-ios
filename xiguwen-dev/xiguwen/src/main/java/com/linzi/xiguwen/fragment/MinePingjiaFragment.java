package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RadioButton;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PingLunFragmentAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.ui.MineReplyActivity;
import com.linzi.xiguwen.utils.CallBack;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by jiang on 2017/12/11.
 */

public class MinePingjiaFragment extends BaseFragment {

    @BindView(R.id.rb_all)
    RadioButton rbAll;
    @BindView(R.id.rb_5)
    RadioButton rb5;
    @BindView(R.id.rb_4)
    RadioButton rb4;
    @BindView(R.id.rb_3)
    RadioButton rb3;
    @BindView(R.id.rb_2)
    RadioButton rb2;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    private int flag = -1;

    private boolean isPrepare = false;

    PingLunFragmentAdapter mAdapter;

    public static MinePingjiaFragment newInstance(int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        MinePingjiaFragment fragment = new MinePingjiaFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_pingjia_manager_layout, null);
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

        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        recycle.setLayoutManager(manager);
        mAdapter = new PingLunFragmentAdapter(getActivity());
        mAdapter.setmPinglun(new CallBack.PingjiaListener() {
            @Override
            public void pingjia(View view, int in) {
                Intent intent=new Intent(getActivity(),MineReplyActivity.class);
                startActivity(intent);
            }
        });
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

    @OnClick({R.id.rb_all, R.id.rb_5, R.id.rb_4, R.id.rb_3, R.id.rb_2})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.rb_all:
                break;
            case R.id.rb_5:
                break;
            case R.id.rb_4:
                break;
            case R.id.rb_3:
                break;
            case R.id.rb_2:
                break;
        }
    }
}

package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.jcodecraeer.xrecyclerview.ProgressStyle;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ShangchengJieDanAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.ui.EditPriceActivity;
import com.linzi.xiguwen.ui.OrderDetailsActivity;
import com.linzi.xiguwen.ui.PingjiaAdapterActivity;
import com.linzi.xiguwen.ui.SCJieDanTuikuanDetailsActivity;
import com.linzi.xiguwen.utils.CallBack;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class ShangChengJieDanFragment extends BaseFragment {
    @BindView(R.id.recycle_view)
    XRecyclerView recycleView;

    private int flag=-1;

    private boolean isPrepare = false;

    ShangchengJieDanAdapter mAdapter;

    public static ShangChengJieDanFragment newInstance (int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        ShangChengJieDanFragment fragment=new ShangChengJieDanFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_history_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initViews();
    }

    private void initViews(){
        Bundle bu = getArguments();
        flag = bu.getInt("type");

        LinearLayoutManager manager=new LinearLayoutManager(getActivity());
        recycleView.setRefreshProgressStyle(ProgressStyle.BallTrianglePath);
        recycleView.setLoadingMoreProgressStyle(ProgressStyle.BallScaleRipple);
        recycleView.setLoadingMoreEnabled(true);
        recycleView.setLayoutManager(manager);
        mAdapter=new ShangchengJieDanAdapter(getActivity(), flag, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent=new Intent(getActivity(),OrderDetailsActivity.class);
                startActivity(intent);
            }
        });
        mAdapter.setmPingjia(new CallBack.PingjiaListener() {
            @Override
            public void pingjia(View view, int in) {
                Intent intent=new Intent(getActivity(),PingjiaAdapterActivity.class);
                startActivity(intent);
            }
        });
        mAdapter.setmEditPrice(new CallBack.EditPriceListener() {
            @Override
            public void editPrice(View view, int in) {
                Intent intent=new Intent(getActivity(),EditPriceActivity.class);
                startActivity(intent);
            }
        });

        mAdapter.setmFahuo(new CallBack.FahuoListener() {
            @Override
            public void fahuo(int in) {
                Intent intent=new Intent(getActivity(),SCJieDanTuikuanDetailsActivity.class);
                startActivity(intent);
            }
        });

        recycleView.setAdapter(mAdapter);
    }

    @Override
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }
}

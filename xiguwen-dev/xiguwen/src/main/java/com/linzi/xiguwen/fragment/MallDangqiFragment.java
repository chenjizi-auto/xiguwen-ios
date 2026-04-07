package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MallDangqiAdapter;
import com.linzi.xiguwen.bean.ScheduleBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.CustomViewPager;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/5.
 */

public class MallDangqiFragment extends Fragment {

    CustomViewPager vp;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    View view;

    MallDangqiAdapter mAdapter;
    @BindView(R.id.no_data)
    TextView noData;
    private int shop_id;

    public static MallDangqiFragment newInstance(int shop_id) {
        MallDangqiFragment fragment = new MallDangqiFragment();
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
        vp.setObjectForPosition(view, 5);
        initViews();
        shop_id = getArguments().getInt("shop_id");
        NToast.log(getActivity(), shop_id + "");
        getData();
    }

    private void initViews() {
        mAdapter = new MallDangqiAdapter(getActivity());
        LinearLayoutManager manager = new LinearLayoutManager(getActivity()) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        recycle.setAdapter(mAdapter);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //初始化数据
    private void getData() {
        LoadDialog.showDialog(getActivity());
        ApiManager.getSchedule(shop_id + "", new OnRequestFinish<BaseBean<ArrayList<ScheduleBean>>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<ScheduleBean>> data) {
                if (data.getData() != null && data.getData().size() > 0) {
                    mAdapter.setData(data.getData());
                    noData.setVisibility(View.GONE);
                } else {
                    noData.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.log(getActivity(), ex.toString());
            }
        });
    }


}

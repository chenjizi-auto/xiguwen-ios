package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MallBaojiaAdapter;
import com.linzi.xiguwen.bean.ShopUserDetailsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.CustomViewPager;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/4.
 */

public class MallBaojiaFragment extends Fragment {
    CustomViewPager vp;
    View view;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data)
    TextView noData;
    private int shop_id;
    private int page = 1;
    private int limit = 10;
    private MallBaojiaAdapter adapter;

    public static MallBaojiaFragment newInstance(int shop_id) {
        MallBaojiaFragment fragment = new MallBaojiaFragment();
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
        vp.setObjectForPosition(view, 1);
        initViews();
        shop_id = getArguments().getInt("shop_id");
        getData();
    }

    private void initViews() {
        GridLayoutManager manager = new GridLayoutManager(getActivity(), 2) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);

    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //初始化数据
    private void getData() {
        LoadDialog.showDialog(getActivity());
        ApiManager.getOffer(shop_id + "", page + "", limit + "", new OnRequestFinish<BaseBean<ShopUserDetailsBean.BaojiaBeanX>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ShopUserDetailsBean.BaojiaBeanX> data) {
                if (data.getData() != null && data.getData().getBaojia().size() > 0) {
                    adapter = new MallBaojiaAdapter(getActivity());
                    recycle.setAdapter(adapter);
                    adapter.setbaojiaBeanList(data.getData().getBaojia());
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

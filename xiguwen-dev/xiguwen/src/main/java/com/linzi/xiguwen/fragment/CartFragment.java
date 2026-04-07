package com.linzi.xiguwen.fragment;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.CartAdapter;
import com.linzi.xiguwen.adapter.ForTuijianAdapter;
import com.linzi.xiguwen.ui.SureOrderActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuRecyclerView;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/29.
 */

public class CartFragment extends Fragment {
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.recycle)
    SwipeMenuRecyclerView recycle;
    @BindView(R.id.cb_all)
    CheckBox cbAll;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_to_jiesuan)
    TextView tvToJiesuan;
    @BindView(R.id.recycle2)
    SwipeMenuRecyclerView recycle2;
    @BindView(R.id.ll_no_data)
    LinearLayout llNoData;
    @BindView(R.id.ll_jiesuan)
    LinearLayout llJiesuan;

    CartAdapter mAdapter;
    ForTuijianAdapter tuijianAdapter;
    ArrayList<Integer> select = new ArrayList<>();

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_cart_layout, null);
        ButterKnife.bind(this, view);
        initViews();
        return view;
    }

    private void initViews() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity()) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter = new CartAdapter(getActivity(), new CallBack.ChooseGoodsListener() {
            @Override
            public void chooseListener(int position, boolean in) {
                if (in) {
                    if (!select.contains(position)) {
                        select.add(position);
                    }
                } else {
                    //选择购物车数据去结算，获取选中的购物车数据中的id
                }
                tvToJiesuan.setText("去结算(" + select.size() + ")");
            }
        });
        recycle.setAdapter(mAdapter);

        GridLayoutManager manager2 = new GridLayoutManager(getActivity(), 2) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle2.setLayoutManager(manager2);
        tuijianAdapter = new ForTuijianAdapter(getActivity());
        recycle2.setAdapter(tuijianAdapter);
        tvTitle.setText("购物车(" + mAdapter.getItemCount() + ")");

        llJiesuan.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), SureOrderActivity.class);
                startActivity(intent);
            }
        });
    }

    //将dp转换为px
    public int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }
}

package com.linzi.xiguwen.fragment.shop;

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.bean.UserMerchant;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/3/28.
 */

public class ZiLiaoFragment extends BaseLazyFragment {
    @BindView(R.id.tv_sex)
    TextView tvSex;
    @BindView(R.id.tv_phone)
    TextView tvPhone;
    @BindView(R.id.tv_city)
    TextView tvCity;
    @BindView(R.id.tv_age)
    TextView tvAge;
    @BindView(R.id.tv_height)
    TextView tvHeight;
    @BindView(R.id.tv_width)
    TextView tvWidth;
    @BindView(R.id.tv_shopid)
    TextView tv_shopid;
    @BindView(R.id.tv_jianjie)
    TextView tvJianjie;

    private int shop_id;
    private UserMerchant bean;

    public static Fragment create(int shop_id) {
        ZiLiaoFragment fragment = new ZiLiaoFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("shop_id", shop_id);
        fragment.setArguments(bundle);
        return fragment;
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_mall_msg_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        shop_id = getArguments().getInt("shop_id");
        getData();
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //初始化数据
    private void getData() {
       // LoadDialog.showDialog(getActivity());
        ApiManager.getMerchantdata(shop_id + "", new OnRequestFinish<BaseBean<UserMerchant>>() {
            @Override
            public void onFinished() {
                //LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<UserMerchant> data) {
                bean = data.getData();
                refreshViews(bean);
            }

            @Override
            public void onError(Exception ex) {
            }
        });
    }

    private void refreshViews(UserMerchant bean) {
        tvSex.setText(bean.getSex() + "");
        tvPhone.setText(bean.getMobile() + "");
        tvCity.setText(bean.getAddr() + "");
        tvAge.setText(bean.getAge() + "");
        tvHeight.setText(bean.getHeight() + "");
        tvWidth.setText(bean.getWeight() + "");
        tv_shopid.setText(bean.getUserid() + "");
        tvJianjie.setText(bean.getSmalltext() + "");
    }

    @Override
    public void onLazyLoad() {
    }

}

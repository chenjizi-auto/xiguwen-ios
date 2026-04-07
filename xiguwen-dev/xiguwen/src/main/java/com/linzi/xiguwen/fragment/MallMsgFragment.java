package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.UserMerchant;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.CustomViewPager;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/5.
 */

public class MallMsgFragment extends Fragment {
    CustomViewPager vp;
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
    private int shop_id;

    public static MallMsgFragment newInstance(int shop_id) {
        MallMsgFragment fragment = new MallMsgFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("shop_id", shop_id);
        fragment.setArguments(bundle);
        return fragment;
    }

    View view;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_mall_msg_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        vp = (CustomViewPager) getActivity().findViewById(R.id.view_pager);
        vp.setObjectForPosition(view, 6);
        shop_id = getArguments().getInt("shop_id");
        NToast.log(getActivity(), shop_id + "");
        getData();
    }

    private void refreshViews(UserMerchant bean) {
        tvSex.setText(bean.getSex() + "");
        tvPhone.setText(bean.getMobile() + "");
        tvCity.setText(bean.getAddr() + "");
        tvAge.setText(bean.getAge() + "");
        tvHeight.setText(bean.getHeight() + "");
        tvWidth.setText(bean.getWeight() + "");
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //初始化数据
    private void getData() {
        LoadDialog.showDialog(getActivity());
        ApiManager.getMerchantdata(shop_id + "", new OnRequestFinish<BaseBean<UserMerchant>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<UserMerchant> data) {
                refreshViews(data.getData());
            }

            @Override
            public void onError(Exception ex) {
                NToast.log(getActivity(), ex.toString());
            }
        });
    }

}

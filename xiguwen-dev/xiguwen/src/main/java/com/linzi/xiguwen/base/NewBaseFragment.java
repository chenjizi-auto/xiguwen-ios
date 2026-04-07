package com.linzi.xiguwen.base;

import android.os.Bundle;
import androidx.annotation.LayoutRes;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import butterknife.ButterKnife;

/**
 * Title:
 * Description:Fragment的基类
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  13:46
 *
 * @author luyongjiang
 * @version 1.0
 */
public abstract class NewBaseFragment extends Fragment {

    protected View mView;


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        mView = inflater.inflate(onLayoutId(), container, false);
        ButterKnife.bind(this, mView);
        initView();
        return mView;
    }

    @LayoutRes
    public abstract int onLayoutId();

    public abstract void initView();
}

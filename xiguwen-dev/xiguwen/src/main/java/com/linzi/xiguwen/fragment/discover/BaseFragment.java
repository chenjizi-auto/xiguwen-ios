package com.linzi.xiguwen.fragment.discover;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import butterknife.ButterKnife;

/**
 * Created by devin on 2016/10/11 15:56
 * Description
 */
public abstract class BaseFragment extends Fragment implements View.OnClickListener{
    protected View mView;
    protected Context mContext;
    protected LayoutInflater mInflater;

    private boolean isVisible;                  //是否可见状态
    private boolean isPrepared;                 //标志位，View已经初始化完成。
    public boolean isFirstLoad = true;         //是否第一次加载


    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        mContext = getActivity();
        isFirstLoad = true;

//        if (mView == null) {
        mInflater = inflater;
        mView = inflater.inflate(setlayoutResID(), container, false);
        ButterKnife.bind(this, mView);
        isPrepared = true;
        initView();
        initEvents();
        initLoad();
//        initData();
//        }else {
//            ButterKnife.bind(this, mView);
//        }

        return mView;
    }



    public View findViewById(int id) {
        return mView.findViewById(id);
    }

    /**
     * 设置activity布局文件
     */
    public abstract int setlayoutResID();

    /**
     * 初始化view
     */
    public abstract void initView();

    /**
     * 点击事件监听
     */
    protected abstract void initEvents();

    /**
     * 初始化数据
     */
    public abstract void initData();



    /**
     * 通过Class跳转界面
     **/
    protected void startActivity(Context context, Class<?> cls) {
        Intent intent = new Intent();
        intent.setClass(context, cls);
        startActivity(intent);
    }

    /**
     * 通过Class跳转界面
     **/
    protected void startActivity(Context context, Class<?> cls, Bundle bundle) {
        Intent intent = new Intent();
        intent.setClass(context, cls);
        if (bundle != null) {
            intent.putExtras(bundle);
        }
        startActivity(intent);
    }


    public void showToast(int messageId) {

        Toast.makeText(mContext, mContext.getResources().getString(messageId), Toast.LENGTH_SHORT).show();

    }


    @Override
    public void onClick(View v) {

    }


    /** 如果是与ViewPager一起使用，调用的是setUserVisibleHint */
    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        if (getUserVisibleHint()) {
            isVisible = true;
            initLoad();
        } else {
            isVisible = false;
//            onInvisible();
        }
    }

    /**
     * 如果是通过FragmentTransaction的show和hide的方法来控制显示，调用的是onHiddenChanged.
     * 若是初始就show的Fragment 为了触发该事件 需要先hide再show
     */
    @Override
    public void onHiddenChanged(boolean hidden) {
        super.onHiddenChanged(hidden);
        if (!hidden) {
            isVisible = true;
            initLoad();
        } else {
            isVisible = false;
//            onInvisible();
        }
    }
    protected void initLoad() {
        if (!isPrepared || !isVisible || !isFirstLoad) {
            return;
        }
        isFirstLoad = false;
        initData();
    }
    @Override
    public void onDestroyView() {
        super.onDestroyView();
        com.linzi.xiguwen.utils.LogUtil.e("", "fragment====onDestroyView");
         
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        com.linzi.xiguwen.utils.LogUtil.e("", "fragment====destroy");

//        mView = null;
    }
}

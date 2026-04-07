package com.linzi.xiguwen.base;

/**
 * Created by pc on 2018/3/27.
 */

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.annotation.UiThread;
import androidx.fragment.app.Fragment;

/**
 * 懒加载fragment基类
 * Created by tinyyoung on 16/7/18.
 */
public abstract class BaseLazyFragment extends Fragment {
    /**
     * 懒加载过
     */
    private boolean isLazyLoaded;

    private boolean isPrepared;


    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        isPrepared = true;
        //只有Fragment onCreateView好了，
        //另外这里调用一次lazyLoad(）
        lazyLoad();
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        lazyLoad();
    }

    /**
     * 调用懒加载
     */

    private void lazyLoad() {
        if (getUserVisibleHint() && isPrepared && !isLazyLoaded) {
            onLazyLoad();
            isLazyLoaded = true;
        }
    }

    @UiThread
    public abstract void onLazyLoad();
}

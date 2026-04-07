package com.linzi.xiguwen.base;

import android.app.Activity;
import android.content.Context;
import androidx.fragment.app.Fragment;
import android.view.View;
import android.widget.Toast;


public abstract class BaseFragment extends Fragment implements View.OnClickListener {
	protected long lastClickTime = 0;
	protected final int SUCCESS = 0;
	protected final int TIME_INTERVAL = 500;
	protected boolean isVisible;
	/** 是否已被加载过一次，第二次就不再去请求数据了 */
	protected boolean isLoaded;
	/**
	 * 判断上下文是否有效
	 *
	 * @param context
	 * @return
	 */
	protected boolean isValidContext(Context context) {
		Activity a = (Activity) context;
		if (a.isFinishing()) {
			return false;
		} else {
			return true;
		}
	}

	@Override
	public void setUserVisibleHint(boolean isVisibleToUser) {
		super.setUserVisibleHint(isVisibleToUser);
		if (getUserVisibleHint()) {
			isVisible = true;
			onVisible();
		} else {
			isVisible = false;
			onInvisible();
		}
	}

	/**
	 * 可见
	 */
	protected void onVisible() {
		lazyLoad();
	}

	/**
	 * 不可见
	 */
	protected void onInvisible() {

	}

	/**
	 * 延迟加载 子类必须重写此方法
	 */
	protected abstract void lazyLoad() ;

	@Override
	public void onClick(View v) {
		// 避免连续点击
		if (System.currentTimeMillis() - lastClickTime < TIME_INTERVAL)
			return;

		lastClickTime = System.currentTimeMillis();

	}

	public boolean isLoaded() {
		return isLoaded;
	}
	public void showToast(String str) {
		Toast.makeText(getActivity(), str, Toast.LENGTH_SHORT).show();
	}

}

package com.linzi.xiguwen.fragment.club;

import androidx.fragment.app.Fragment;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.NewBaseFragment;
import com.linzi.xiguwen.fragment.multistage.bean.HeadTitleFragmentAndListenerBean;
import com.linzi.xiguwen.utils.StatusBarUtil;

import butterknife.BindView;
import butterknife.OnClick;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  12:06
 *
 * @author luyongjiang
 * @version 1.0
 */
public class TitleFragment extends NewBaseFragment {
    public static Fragment create() {
        return new TitleFragment();
    }

    private boolean isShowShareButton = true;
    private String title;
    private View.OnClickListener listener;

    public static Fragment create(boolean isShowShareButton, String title) {
        TitleFragment titleFragment = new TitleFragment();
        titleFragment.isShowShareButton = isShowShareButton;
        titleFragment.title = title;
        return titleFragment;
    }


    private HeadTitleFragmentAndListenerBean.OnHeadOffsetListener mOnHeadOffsetListener = new HeadTitleFragmentAndListenerBean.OnHeadOffsetListener() {
        @Override
        public void onCallback(float alpha, float offset) {
            vTitle.setAlpha(alpha);
            llBar.setAlpha(alpha);
        }
    };

    public HeadTitleFragmentAndListenerBean.OnHeadOffsetListener getOnHeadOffsetListener() {
        return mOnHeadOffsetListener;
    }

    @BindView(R.id.ll_title)
    View vTitle;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.ll_right)
    LinearLayout vRight;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    public void setRightOnClick(View.OnClickListener listener) {
        this.listener = listener;
    }

    @Override
    public int onLayoutId() {
        return R.layout.fr_title_paddingtop;
    }

    @OnClick(R.id.ll_back)
    public void onClick(View view) {
        getActivity().finish();
    }

    @Override
    public void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(getActivity()));
        llBar.setLayoutParams(params);
        // ViewCompat.setAlpha(llBar, 0);
        llBar.setBackgroundColor(getActivity().getResources().getColor(R.color.white));


        vRight.setOnClickListener(listener);
        tvTitle.setText(title);
        if (!isShowShareButton) {
            vRight.setVisibility(View.GONE);
        }
    }
}

package com.linzi.xiguwen.ui;

import android.os.Build;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.widget.FrameLayout;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.SynamicdetailsBean;
import com.linzi.xiguwen.fragment.club.TitleFragment;
import com.linzi.xiguwen.fragment.club.clubperson.ClubPersonCommentFragment;
import com.linzi.xiguwen.fragment.club.clubperson.ClubPersonDetailModel;
import com.linzi.xiguwen.fragment.club.clubperson.ClubPersonHeadFragment;
import com.linzi.xiguwen.fragment.club.clubperson.ClubPersonLikeFragment;
import com.linzi.xiguwen.fragment.multistage.bean.FragmentAndNavigationBean;
import com.linzi.xiguwen.fragment.multistage.bean.HeadTitleFragmentAndListenerBean;
import com.linzi.xiguwen.fragment.multistage.bean.MultistageTandemBean;
import com.linzi.xiguwen.fragment.multistage.fragment.MultistageTandemFragment;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.StatusBarUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * Title:
 * Description:动态详情页面
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  19:57
 *
 * @author luyongjiang
 * @version 1.0
 */
public class NewClubDetailsPersonActivity extends AppCompatActivity implements ClubPersonDetailModel {
    public static final String ID_KEY = "id";
    private BaseBean<SynamicdetailsBean> requestBean;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(NewClubDetailsPersonActivity.this, R.color.white);
            StatusBarUtil.setNavigationBarColor(NewClubDetailsPersonActivity.this, R.color.white);
        }
        FrameLayout frameLayout = new FrameLayout(this);
        frameLayout.setId(android.R.id.custom);
        setContentView(frameLayout);
        int id = getIntent().getIntExtra(ID_KEY, -1);
        LoadDialog.showDialog(this);
        ApiManager.getSynamicdetails(id, new OnRequestFinish<BaseBean<SynamicdetailsBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();

            }

            @Override
            public void onSuccess(BaseBean<SynamicdetailsBean> data) {
                requestBean = data;
                afterBindView();

            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void afterBindView() {
        ArrayList<FragmentAndNavigationBean> navigationBeans = new ArrayList<>();
        navigationBeans.add(FragmentAndNavigationBean.create("评论 " + requestBean.getData().getCommentnum(), ClubPersonCommentFragment.create()));
        navigationBeans.add(FragmentAndNavigationBean.create("赞 " + requestBean.getData().getZan(), ClubPersonLikeFragment.create()));
        getSupportFragmentManager()
                .beginTransaction()
                .add(android.R.id.custom
                        , MultistageTandemFragment.create(createTandemBean(navigationBeans
                                , (TitleFragment) TitleFragment.create(false, "动态详情")))
                        , MultistageTandemFragment.class.toString())
                .commit();
    }


    private MultistageTandemBean createTandemBean(ArrayList<FragmentAndNavigationBean> navigationBeans, TitleFragment title) {
        ClubPersonHeadFragment head = ClubPersonHeadFragment.createFragment(requestBean.getData());
        return new MultistageTandemBean()
                .setTitleBean(HeadTitleFragmentAndListenerBean.create(head
                        , title
                        , new HeadTitleFragmentAndListenerBean.OnHeadOffsetListener() {
                            @Override
                            public void onCallback(float alpha, float offset) {

                            }
                        }))
                .setNavigationBeans(navigationBeans);
    }

    @Override
    public List<SynamicdetailsBean.ZanlistBean> getZanList() {
        return requestBean.getData().getZanlist();
    }

    @Override
    public List<SynamicdetailsBean.CommentlistBean> getCommentList() {
        return requestBean.getData().getCommentlist();
    }

}

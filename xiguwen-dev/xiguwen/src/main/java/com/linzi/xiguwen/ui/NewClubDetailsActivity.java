package com.linzi.xiguwen.ui;

import android.os.Build;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ShetuanIndexBean;
import com.linzi.xiguwen.fragment.club.ActionFragment;
import com.linzi.xiguwen.fragment.club.ContactFragment;
import com.linzi.xiguwen.fragment.club.HeadFragment;
import com.linzi.xiguwen.fragment.club.MemberFragment;
import com.linzi.xiguwen.fragment.club.TitleFragment;
import com.linzi.xiguwen.fragment.club.WorkFragment;
import com.linzi.xiguwen.fragment.multistage.bean.FragmentAndNavigationBean;
import com.linzi.xiguwen.fragment.multistage.bean.HeadTitleFragmentAndListenerBean;
import com.linzi.xiguwen.fragment.multistage.bean.MultistageTandemBean;
import com.linzi.xiguwen.fragment.multistage.fragment.MultistageTandemFragment;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.StatusBarUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * Title:
 * Description:新的社团详情页面
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/26  14:29
 *
 * @author luyongjiang
 * @version 1.0
 */
public class NewClubDetailsActivity extends AppCompatActivity implements NewClubDetailsModel {
    public static final String ID_KEY = "bean";
    private String id = "-1";
    private int shetuan_id;
    private BaseBean<ShetuanIndexBean> mData;
    private static final String CLUB_ID_KEY = "club_id_key";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(NewClubDetailsActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(NewClubDetailsActivity.this, R.color.white);
        }
        setContentView(R.layout.act_new_club_details);
        id = getIntent().getIntExtra(ID_KEY, -1) + "";
        shetuan_id= getIntent().getIntExtra(ID_KEY, -1);

        LoadDialog.showDialog(this);
        ApiManager.getShetuanIndex(id, "1", "30", new OnRequestFinish<BaseBean<ShetuanIndexBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ShetuanIndexBean> data) {
                mData = data;
                afterConfigView();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }


    private void afterConfigView() {
        ArrayList<FragmentAndNavigationBean> navigationBeans = new ArrayList<>();
        navigationBeans.add(FragmentAndNavigationBean.create("动态", ActionFragment.create()));
        navigationBeans.add(FragmentAndNavigationBean.create("成员", MemberFragment.create(mData.getData().getInfo().getId())));
        navigationBeans.add(FragmentAndNavigationBean.create("作品", WorkFragment.create(mData.getData().getInfo().getId())));
        navigationBeans.add(FragmentAndNavigationBean.create("联系", ContactFragment.create(mData.getData().getInfo().getId())));

        TitleFragment title = (TitleFragment) TitleFragment.create(true, mData.getData().getInfo().getName());
        title.setRightOnClick(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                GetShareContentUtil.getContent(NewClubDetailsActivity.this, shetuan_id, 8, -1);
            }
        });
        MultistageTandemBean tandemBean = new MultistageTandemBean()
                .setTitleBean(HeadTitleFragmentAndListenerBean.create(HeadFragment.create(), title, title.getOnHeadOffsetListener()))
                .setNavigationBeans(navigationBeans);
        getSupportFragmentManager()
                .beginTransaction()
                .add(R.id.fl_content, MultistageTandemFragment.create(tandemBean), MultistageTandemFragment.class.toString())
                .commit();
    }


    @Override
    public List<ShetuanIndexBean.DynamiclistBean> getActionList() {
        return mData.getData().getDynamiclist();
    }

    @Override
    public ShetuanIndexBean.InfoBean getHeadBean() {
        return mData.getData().getInfo();
    }
}

package com.linzi.xiguwen.fragment.club;

import android.content.Intent;
import android.os.Bundle;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.NewBaseFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.MemberBean;
import com.linzi.xiguwen.fragment.club.dele.AllNumberDele;
import com.linzi.xiguwen.fragment.club.dele.TitleDelegate;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.NewClubDetailsActivity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;

import butterknife.BindView;

/**
 * Title:成员
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  12:06
 *
 * @author luyongjiang
 * @version 1.0
 */
public class MemberFragment extends NewBaseFragment {

    private BaseBean<MemberBean> mBean;
    private BaseAdapter mAdapter;

    public static Fragment create(int id) {
        MemberFragment memberFragment = new MemberFragment();
        Bundle bundle = new Bundle();
        bundle.putInt(NewClubDetailsActivity.ID_KEY, id);
        memberFragment.setArguments(bundle);
        return memberFragment;
    }

    @Override
    public int onLayoutId() {
        return R.layout.fr_member;
    }

    @Override
    public void initView() {
        if (mBean == null) {
            requestData();
        } else {
            afterView(mBean);
        }
    }

    private void requestData() {
        LoadDialog.showDialog(getContext());
        ApiManager.getMemberList(getArguments().getInt(NewClubDetailsActivity.ID_KEY, -1), new OnRequestFinish<BaseBean<MemberBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MemberBean> data) {
                mBean = data;
                afterView(mBean);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    @BindView(R.id.rv_list)
    RecyclerView rvList;

    private void afterView(BaseBean<MemberBean> data) {
        mAdapter = createAdapter(data);
        rvList.setAdapter(mAdapter);
    }


    class MemberHolder extends BaseViewHolder<MemberBean.Member> {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_position)
        TextView tvPosition;
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_price)
        TextView tvPrice;

        public MemberHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final MemberBean.Member bean) {
            tvName.setText(bean.getNickname());
            tvPosition.setText(bean.getOccupation());
            GlideLoad.GlideLoadCircle(bean.getHead(), ivHead);
            tvPrice.setText("￥" + bean.getZuidijia() + "元");
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent1 = new Intent(v.getContext(), NewMallDetailsActivity.class);//进店看看
                    intent1.putExtra("shop_id", bean.getUserid());
                    startActivity(intent1);
                }
            });
        }
    }

    private BaseAdapter createAdapter(BaseBean<MemberBean> data) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter()
                .injectHolderDelegate(new AllNumberDele().cleanAfterAddData("全部成员(" + data.getData().getChengyuan().size() + ")"))
                .injectHolderDelegate(new TitleDelegate().cleanAfterAddData("创始人"))//创始人标题
                .injectHolderDelegate(new CreateHolderDelegate<MemberBean.ChuangshirenBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_member;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new MemberHolder(itemView);
                    }
                }//创始人item
                        .cleanAfterAddData(data.getData().getChuangshiren()))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_dev;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new BaseViewHolder<String>(itemView) {
                            @Override
                            protected void bindView(String s) {

                            }
                        };
                    }
                }.cleanAfterAddData(""))//分割线View
                .injectHolderDelegate(new TitleDelegate().cleanAfterAddData("社团成员"))//社团成员标题
                .injectHolderDelegate(new CreateHolderDelegate<MemberBean.ChengyuanBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_member;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new MemberHolder(itemView);
                    }
                }//社团成员item
                        .cleanAfterAddAllData(data.getData().getChengyuan()))
                .setLayoutManager(rvList);

        return baseAdapter;
    }
}

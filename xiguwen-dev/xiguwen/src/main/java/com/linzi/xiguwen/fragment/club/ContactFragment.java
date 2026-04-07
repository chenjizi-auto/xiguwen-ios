package com.linzi.xiguwen.fragment.club;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.NewBaseFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.ContactBean;
import com.linzi.xiguwen.fragment.club.dele.AllNumberDele;
import com.linzi.xiguwen.fragment.club.dele.TitleDelegate;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.LoginActivity;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginUtil;

import java.util.ArrayList;

import butterknife.BindView;

/**
 * Title:联系
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  12:06
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ContactFragment extends NewBaseFragment {

    private BaseBean<ContactBean> mData;

    public static Fragment create() {
        return new ContactFragment();
    }

    private static final String ID_KEY = "id";

    public static Fragment create(int id) {
        ContactFragment fragment = new ContactFragment();
        Bundle bundle = new Bundle();
        bundle.putInt(ID_KEY, id);
        fragment.setArguments(bundle);
        return fragment;
    }

    @BindView(R.id.rv_list)
    RecyclerView rvList;

    @Override
    public int onLayoutId() {
        return R.layout.fr_contact;
    }

    @Override
    public void initView() {
        if (mData == null) {
            requestData();
        } else {
            afterView(mData.getData());
        }
    }

    private void requestData() {
        LoadDialog.showDialog(getContext());
        ApiManager.getContactList(getArguments().getInt(ID_KEY), new OnRequestFinish<BaseBean<ContactBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ContactBean> data) {
                mData = data;
                afterView(data.getData());
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void afterView(ContactBean bean) {
        ArrayList<ContactBean.OnContact> contactArrayList = new ArrayList<>();
        contactArrayList.addAll(bean.getChengyuan());
        rvList.setAdapter(BaseAdapter.createBaseAdapter()
                .injectHolderDelegate(new AllNumberDele().cleanAfterAddData("全部成员(" + bean.getNum() + ")"))
                .injectHolderDelegate(new TitleDelegate().cleanAfterAddData("创始人"))
                .injectHolderDelegate(new ContactDele().cleanAfterAddData(bean.getChuangshiren()))
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
                }.cleanAfterAddData(""))
                .injectHolderDelegate(new TitleDelegate().cleanAfterAddData("社团成员"))
                .injectHolderDelegate(new ContactDele().cleanAfterAddAllData(contactArrayList))
                .setLayoutManager(rvList));
    }

    class ContactDele extends CreateHolderDelegate<ContactBean.OnContact> {

        @Override
        protected int getLayoutRes() {
            return R.layout.item_contact;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new ContactHolder(itemView);
        }
    }

    class ContactHolder extends BaseViewHolder<ContactBean.OnContact> {

        public ContactHolder(View itemView) {
            super(itemView);
        }

        @BindView(R.id.tv_name)
        TextView tvName;

        @BindView(R.id.tv_number)
        TextView tvNumber;


        @Override
        protected void bindView(final ContactBean.OnContact onContact) {
            tvName.setText(onContact.getNickname());
            tvNumber.setText(onContact.getMobile());
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (!LoginUtil.isLogin()) {
                        LoginActivity.startAction(getActivity());
                    } else {
                        Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + onContact.getMobile()));
                        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        v.getContext().startActivity(intent);
                    }
                }
            });
        }
    }
}

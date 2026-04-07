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
import com.linzi.xiguwen.bean.WorkBean;
import com.linzi.xiguwen.fragment.club.dele.AllNumberDele;
import com.linzi.xiguwen.fragment.club.dele.TitleDelegate;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.NewExampleDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;

import java.util.ArrayList;

import butterknife.BindView;

/**
 * Title:作品
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  12:06
 *
 * @author luyongjiang
 * @version 1.0
 */
public class WorkFragment extends NewBaseFragment {
    private static final String ID_KEY = "id";
    private BaseBean<WorkBean> mData;

    public static Fragment create() {
        return new WorkFragment();
    }

    public static Fragment create(int id) {
        WorkFragment workFragment = new WorkFragment();
        Bundle bundle = new Bundle();
        bundle.putInt(ID_KEY, id);
        workFragment.setArguments(bundle);
        return workFragment;
    }


    @Override
    public int onLayoutId() {
        return R.layout.fr_work;
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
        ApiManager.getWorkList(getArguments().getInt(ID_KEY), new OnRequestFinish<BaseBean<WorkBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<WorkBean> data) {
                mData = data;
                afterView(data.getData());
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    @BindView(R.id.rv_list)
    RecyclerView rvList;

    private void afterView(WorkBean workBean) {
        ArrayList<WorkBean.OnWorkBean> onWorkBeans = new ArrayList<>();
        onWorkBeans.addAll(workBean.getChengyuan());
        rvList.setAdapter(BaseAdapter.createBaseAdapter()
                .injectHolderDelegate(new AllNumberDele() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }
                }.cleanAfterAddData("全部作品(" + workBean.getNum() + ")"))
                .injectHolderDelegate(new TitleDelegate() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }
                }.cleanAfterAddData("创始人"))
                .injectHolderDelegate(new CreateHolderDelegate<WorkBean.OnWorkBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_work_csr;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new WorkHolder(itemView);
                    }

                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }
                }.cleanAfterAddData(workBean.getChuangshiren()))
                .injectHolderDelegate(new TitleDelegate() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }
                }.cleanAfterAddData("社团成员"))
                .injectHolderDelegate(new CreateHolderDelegate<WorkBean.OnWorkBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_work_cy;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new WorkHolder(itemView);
                    }
                }.cleanAfterAddAllData(onWorkBeans))
                .setLayoutManager(rvList));
    }


    class WorkHolder extends BaseViewHolder<WorkBean.OnWorkBean> {

        public WorkHolder(View itemView) {
            super(itemView);
        }

        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_look)
        TextView tvLook;
        @BindView(R.id.tv_quotation)
        TextView tvQuotation;
        @BindView(R.id.tv_content)
        TextView tvContent;
        @BindView(R.id.iv_head)
        ImageView ivHead;

        @Override
        protected void bindView(final WorkBean.OnWorkBean bean) {
            final int id = bean.getId();
            tvName.setText(bean.getTitle());
            tvLook.setText(bean.getClicked() + "");
            tvQuotation.setText("¥" + bean.getWeddingexpenses());
            GlideLoad.GlideLoadImg2(bean.getWeddingcover(), ivHead);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(v.getContext(), NewExampleDetailsActivity.class);
                    intent.putExtra("caseid", id);
                    v.getContext().startActivity(intent);
                }
            });
        }
    }

}

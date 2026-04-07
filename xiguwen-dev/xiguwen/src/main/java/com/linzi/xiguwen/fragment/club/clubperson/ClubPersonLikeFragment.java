package com.linzi.xiguwen.fragment.club.clubperson;

import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.NewBaseFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.SynamicdetailsBean;
import com.linzi.xiguwen.utils.GlideLoad;

import butterknife.BindView;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/28  09:11
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ClubPersonLikeFragment extends NewBaseFragment {
    public static ClubPersonLikeFragment create() {
        return new ClubPersonLikeFragment();
    }

    @Override
    public int onLayoutId() {
        return R.layout.fr_like;
    }

    @BindView(R.id.rv_like)
    RecyclerView rvLike;

    @Override
    public void initView() {
        rvLike.setAdapter(BaseAdapter.createBaseAdapter()
                .injectHolderDelegate(new CreateHolderDelegate<SynamicdetailsBean.ZanlistBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_like;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new LikeViewHolder(itemView);
                    }
                }
                        .setData(((ClubPersonDetailModel) getActivity()).getZanList()))
                .setLayoutManager(rvLike));
    }

    class LikeViewHolder extends BaseViewHolder<SynamicdetailsBean.ZanlistBean> {
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_name)
        TextView tvName;

        public LikeViewHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(SynamicdetailsBean.ZanlistBean bean) {
            GlideLoad.GlideLoadCircle(bean.getHead(), ivHead);
            tvName.setText(bean.getNickname());
        }
    }


}

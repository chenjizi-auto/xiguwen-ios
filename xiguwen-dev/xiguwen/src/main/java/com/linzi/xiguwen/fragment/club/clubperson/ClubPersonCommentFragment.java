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
public class ClubPersonCommentFragment extends NewBaseFragment {
    public static ClubPersonCommentFragment create() {
        return new ClubPersonCommentFragment();
    }

    @Override
    public int onLayoutId() {
        return R.layout.fr_comment;
    }

    @BindView(R.id.rl_comment)
    RecyclerView mRecyclerView;

    @Override
    public void initView() {
        mRecyclerView.setAdapter(BaseAdapter.<SynamicdetailsBean.CommentlistBean>createBaseAdapter()
                .injectHolderDelegate(dele.setData(((ClubPersonDetailModel) getActivity()).getCommentList()))
                .setLayoutManager(mRecyclerView));
    }

    //-----------------------分割线-------------------------------------
    CreateHolderDelegate<SynamicdetailsBean.CommentlistBean> dele = new CreateHolderDelegate<SynamicdetailsBean.CommentlistBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.item_comment;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new CommentHolder(itemView);
        }
    };

    class CommentHolder extends BaseViewHolder<SynamicdetailsBean.CommentlistBean> {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_content)
        TextView tvContent;
        @BindView(R.id.iv_head)
        ImageView ivHead;

        public CommentHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(SynamicdetailsBean.CommentlistBean bean) {
            tvName.setText(bean.getNickname());
            tvTime.setText(bean.getCreate_ti());
            tvContent.setText(bean.getComm());
            GlideLoad.GlideLoadCircle(bean.getHead(), ivHead);
        }
    }
}

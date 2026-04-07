package com.linzi.xiguwen.fragment.discover;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PinglunAdapter;
import com.linzi.xiguwen.bean.SynamicdetailsBean;

import java.util.List;

import butterknife.BindView;

/**
 * Created by devin on 2018/4/12 10:52
 * Description
 */

public class DiscoverCommentListFragment extends BaseFragment {

    @BindView(R.id.recycle)
    RecyclerView recycle;
    private PinglunAdapter mAdapter;

    private List<SynamicdetailsBean.CommentlistBean> commentlistBeans;

    public static DiscoverCommentListFragment newInstance() {
        DiscoverCommentListFragment fragment = new DiscoverCommentListFragment();
        return fragment;
    }

    @Override
    public int setlayoutResID() {
        return R.layout.fragment_discover_recycle_layout;
    }

    @Override
    public void initView() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        recycle.setLayoutManager(manager);
        mAdapter = new PinglunAdapter(getActivity());
        recycle.setAdapter(mAdapter);
        mAdapter.setListener(listener);
    }


    @Override
    protected void initEvents() {

    }

    @Override
    public void initData() {

    }

    public void setCommentlistBean(List<SynamicdetailsBean.CommentlistBean> commentlistBean) {
        this.commentlistBeans = commentlistBean;
        if (mAdapter != null) {
            mAdapter.addFirst(commentlistBeans);
        }
        mAdapter.notifyDataSetChanged();
    }

    private com.jcodecraeer.xrecyclerview.OnItemClickListener1 listener;

    public void setOnitemListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 listener) {
        this.listener = listener;
    }
}

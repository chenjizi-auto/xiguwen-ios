package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.BYXYVideoFragmentAdapter;
import com.linzi.xiguwen.base.BaseFragment;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class VideoMoreFragment extends BaseFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.ed_sousuo)
    EditText edSousuo;

    private int flag = -1;

    private boolean isPrepare = false;

    String[] arrow = {"全部", "策划师", "摄像师", "主持人", "化妆师", "摄影师", "灯光师", "音响师"};
    private int position_all = 0;

    BYXYVideoFragmentAdapter.ItemAdapter mAdapter;


    public static VideoMoreFragment newInstance(int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        VideoMoreFragment fragment = new VideoMoreFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_video_more, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initViews();
    }

    private void initViews() {
        Bundle bu = getArguments();
        flag = bu.getInt("type");

        GridLayoutManager manager = new GridLayoutManager(getActivity(),2);
//        recycleView.setRefreshProgressStyle(ProgressStyle.BallTrianglePath);
//        recycleView.setLoadingMoreProgressStyle(ProgressStyle.BallScaleRipple);
//        recycleView.setLoadingMoreEnabled(true);
        recycle.setLayoutManager(manager);
        mAdapter=new BYXYVideoFragmentAdapter(getActivity()).new ItemAdapter();
        recycle.setAdapter(mAdapter);
    }

    @Override
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

}

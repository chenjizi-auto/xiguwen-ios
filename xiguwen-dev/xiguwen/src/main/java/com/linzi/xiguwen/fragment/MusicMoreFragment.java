package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.BYXYMusicFragmentAdapter;
import com.linzi.xiguwen.base.BaseFragment;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class MusicMoreFragment extends BaseFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.ed_sousuo)
    EditText edSousuo;

    private int flag = -1;

    private boolean isPrepare = false;
    private int position_all = 0;

    BYXYMusicFragmentAdapter.ItemAdapter mAdapter;


    public static MusicMoreFragment newInstance(int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        MusicMoreFragment fragment = new MusicMoreFragment();
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

        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
//        recycleView.setRefreshProgressStyle(ProgressStyle.BallTrianglePath);
//        recycleView.setLoadingMoreProgressStyle(ProgressStyle.BallScaleRipple);
//        recycleView.setLoadingMoreEnabled(true);
        recycle.setLayoutManager(manager);
        mAdapter=new BYXYMusicFragmentAdapter(getActivity()).new ItemAdapter();
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

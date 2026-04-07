package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.CareUserAdapter;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/3.
 */

public class CareUserFragment extends Fragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;

    CareUserAdapter mAdapter;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_recycle_layout, null);
        ButterKnife.bind(this, view);
        initViews();
        return view;
    }

    private void initViews(){
        LinearLayoutManager manager=new LinearLayoutManager(getActivity());
        recycle.setLayoutManager(manager);
        mAdapter=new CareUserAdapter(getActivity());
        recycle.setAdapter(mAdapter);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }
}

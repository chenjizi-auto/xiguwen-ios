package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.InvatedNewAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.bean.ListPeoBean;
import com.linzi.xiguwen.utils.GetContactsUtils;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class InvatedNewPeoFragment extends BaseFragment {

    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    private int flag = -1;

    private boolean isPrepare = false;

    private List<ListPeoBean>mList;

    InvatedNewAdapter mAdapter;

    public static InvatedNewPeoFragment newInstance(int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        InvatedNewPeoFragment fragment = new InvatedNewPeoFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_invated_new_peo, null);
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
        recycle.setLayoutManager(manager);
        mAdapter = new InvatedNewAdapter(getActivity(), flag);
        mAdapter.setItemClickListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {

            }
        });
        if(flag==0) {
            recycle.setAdapter(mAdapter);
        }else{
            List<GetContactsUtils.Contacts> contacts= GetContactsUtils.getContacts(getActivity());
            mList=new ArrayList<>();
            for(int x=0;x<contacts.size();x++){
                ListPeoBean bean=new ListPeoBean();
                bean.setName(contacts.get(x).getName());
                bean.setPhone(contacts.get(x).getPhone());
                mList.add(bean);
            }
            mAdapter.setmList(mList);
            recycle.setAdapter(mAdapter);
        }
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

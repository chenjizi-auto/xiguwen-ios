package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.GridView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MenuAdapter;
import com.linzi.xiguwen.bean.MenuBean;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.NToast;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/11/21.
 */

public class GridMenuFragment extends Fragment {
    @BindView(R.id.grid)
    GridView grid;

    MenuAdapter mAdapter;

//    private int FLAG=0;
    private MenuBean mList;
    private List<MenuBean.Menu>mData;

    public GridMenuFragment() {
    }

//
    public static GridMenuFragment newInstance (int FLAG, MenuBean mList) {
        Bundle args = new Bundle();
        args.putString("flag", ""+FLAG);
        NToast.log("FLAG", "FLAG==========" + FLAG);
        args.putSerializable("data", mList);
        GridMenuFragment fragment=new GridMenuFragment();
        fragment.setArguments(args);
        return fragment;
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.item_menu_grid, null);
        ButterKnife.bind(this, view);
        initViews();
        return view;
    }

    private void initViews(){
        if(isAdded()) {
            Bundle bundle = getArguments();
            if (bundle != null) {
                String FLAG = bundle.getString("flag");
                mList = (MenuBean) bundle.getSerializable("data");
                mData = new ArrayList<>();
                int size = 0;
                if (mList != null) {
                    NToast.log("本页菜单==========", "" + mList.getMenus().size());
                    if (((Integer.valueOf(FLAG) + 1) * 10) <= mList.getMenus().size()) {
                        size = (Integer.valueOf(FLAG) + 1) * 10;
                    } else {
                        size = mList.getMenus().size();
                    }
                    for (int x = (10 * Integer.valueOf(FLAG)); x < size; x++) {
                        mData.add(mList.getMenus().get(x));
                    }
                }
            }
            mAdapter = new MenuAdapter(getActivity(), mData, new CallBack.OnMenuItemClickListener() {
                @Override
                public void itemClick(int position) {
                    NToast.show("菜单" + position);
                }

                @Override
                public void itemClick(int position, String name) {

                }
            });
            grid.setAdapter(mAdapter);
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }
}

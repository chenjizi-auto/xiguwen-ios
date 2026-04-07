package com.linzi.xiguwen.fragment;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ClubActivitiesAdapter;
import com.linzi.xiguwen.bean.ShetuanIndexBean;
import com.linzi.xiguwen.view.CustomViewPager;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/21.
 */

@SuppressLint("ValidFragment")
public class ClubActivitiesFragment extends Fragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;

    ClubActivitiesAdapter mAdapter;

    View view;

    CustomViewPager vp;
    private List<ShetuanIndexBean.DynamiclistBean> mArrayList;
//    private BaseAdapter<ShetuanIndexBean.DynamiclistBean> newsAdapter;

    public ClubActivitiesFragment(CustomViewPager vp) {
        this.vp = vp;
    }

    public void setArrayList(List<ShetuanIndexBean.DynamiclistBean> arrayList) {
        if (arrayList == null || arrayList.size() == 0)
            return;
        mArrayList = arrayList;
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_club_detail_activity_layout, container, false);
        ButterKnife.bind(this, view);
//        BaseBean<ShetuanIndexBean> data = ((ClubDetailsActivity) getActivity()).getData();
//        this.mArrayList = data.getData().getDynamiclist();
        initView();
        return view;
    }

    private void initView() {

        mAdapter = new ClubActivitiesAdapter(getActivity());
//        newsAdapter = createAdapter(recycle);
//        recycle.setAdapter(newsAdapter);

    }

//    private BaseAdapter<ShetuanIndexBean.DynamiclistBean> createAdapter(RecyclerView recycle) {
//        BaseAdapter<ShetuanIndexBean.DynamiclistBean> newsAdapter = BaseAdapter.<ShetuanIndexBean.DynamiclistBean>createBaseAdapter()
//                .injectHolderDelegate(holderDelegate).injectHolderDelegate(headDele).injectHolderDelegate(footer).setData(mArrayList);
//        newsAdapter.addFirst(new ShetuanIndexBean.DynamiclistBean());
//        newsAdapter.addLast(new ShetuanIndexBean.DynamiclistBean());
//        recycle.setLayoutManager(newsAdapter.createLayoutManager(getContext()));
//        return newsAdapter;
//    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //    private int layoutId = android.R.layout.simple_list_item_1;
    private int layoutId = R.layout.item_news_club_activities_layout;
//
//    BaseAdapter.CreateHolderDelegate headDele = new BaseAdapter.CreateHolderDelegate() {
//
//        @Override
//        public int getLayoutRes() {
//            return layoutId;
//        }
//
//        @Override
//        public BaseAdapter.BaseViewHolder onCreateHolder(View itemView) {
//            return new TestHolder(itemView);
//        }
//
//        @Override
//        public boolean onSpanSize(int position) {
//            if (position == 0)
//                return true;
//            return super.onSpanSize(position);
//        }
//
//        @Override
//        public int onSpanSize() {
//            return 2;
//        }
//
//        @Override
//        public boolean onScopeShowHolder(int position) {
//            return position == 0;
//        }
//
//        @Override
//        public int getType(BaseAdapter adapter) {
//            return 10;
//        }
//    };
//    BaseAdapter.CreateHolderDelegate footer = new BaseAdapter.CreateHolderDelegate() {
//
//        @Override
//        public boolean onSpanSize(int position) {
//            if (position == newsAdapter.getFootPosition())
//                return true;
//            return super.onSpanSize(position);
//        }
//
//        @Override
//        public int onSpanSize() {
//            return 2;
//        }
//
//        @Override
//        public int getLayoutRes() {
//            return layoutId;
//        }
//
//        @Override
//        public BaseAdapter.BaseViewHolder onCreateHolder(View itemView) {
//            return new TestHolder(itemView);
//        }
//
//        @Override
//        public boolean onScopeShowHolder(int position) {
//            return position == mAdapter.getFootPosition();
//        }
//
//        @Override
//        public int getType(BaseAdapter adapter) {
//            return 15;
//        }
//    };
//    BaseAdapter.CreateHolderDelegate holderDelegate = new BaseAdapter.CreateHolderDelegate() {
//
//        @Override
//        public int getLayoutRes() {
//            return layoutId;
//        }
//
//        @Override
//        public BaseAdapter.BaseViewHolder onCreateHolder(View itemView) {
//            return new TestHolder(itemView);
//        }
//
//        @Override
//        public int onSpanSize() {
//            return 2;
//        }
//    };
//
//
//    class TestHolder extends BaseAdapter.BaseViewHolder<ShetuanIndexBean.DynamiclistBean> {
//        @BindView(R.id.iv_head_img)
//        ImageView ivHeadImg;
//        @BindView(R.id.tv_user_name)
//        TextView tvUserName;
//        @BindView(R.id.tv_zhiwei)
//        TextView tvZhiwei;
//        @BindView(R.id.tv_time)
//        TextView tvTime;
//        @BindView(R.id.tv_team_name)
//        TextView tvTeamName;
//        @BindView(R.id.bt_care)
//        Button btCare;
//        @BindView(R.id.tv_content)
//        TextView tvContent;
//        //        @BindView(R.id.recycle)
////        RecyclerView recycle;
//        @BindView(R.id.tv_see_count)
//        TextView tvSeeCount;
//        @BindView(R.id.tv_pingjia_count)
//        TextView tvPingjiaCount;
//        @BindView(R.id.tv_dianzan_count)
//        TextView tvDianzanCount;
//
//        public TestHolder(View itemView) {
//            super(itemView);
//        }
//
//        @Override
//        protected void bindView(ShetuanIndexBean.DynamiclistBean bean) {
//
////            GlideLoad.GlideLoadCircle("http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg", ivHeadImg);
//            tvUserName.setText("林子");
//            tvZhiwei.setText("策划师");
//            tvTime.setText("2017-12-22");
//            tvTeamName.setText("**策划师团队");
//            tvContent.setText("青春是一首永不言败的歌，青春是一条永不停息的河流，青春是一本读不厌的书，青春是一杯品不尽的茶，青春是一起牵手在天空之桥留下我们幸福的足迹。");
//            tvSeeCount.setText("200");
//            tvPingjiaCount.setText("200");
//            tvDianzanCount.setText("200");
////            GridLayoutManager manager = new GridLayoutManager(itemView.getContext(), 3);
////            recycle.setLayoutManager(manager);
//            tvTeamName.setText(bean.getNickname());
////            recycle.setAdapter(new ImgAdapter());
//        }
//
//    }


}

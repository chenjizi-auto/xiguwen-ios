package com.linzi.xiguwen.fragment.shop;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.base.listener.OnRcvScrollListener;
import com.linzi.xiguwen.fragment.club.dele.AllNumberDele;
import com.linzi.xiguwen.fragment.shop.model.bean.WorksBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.NewExampleDetailsActivity;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.webview.WebViewVideoActivity;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;
import fm.jiecao.jcvideoplayer_lib.JCFullScreenActivity;
import fm.jiecao.jcvideoplayer_lib.JCVideoPlayerStandard;

/**
 * Created by pc on 2018/3/28.
 */

public class ZuoPingFragment extends BaseLazyFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data)
    TextView noData;
    private int shop_id;
    private int page = 1;
    private int limit = 10;
    private BaseAdapter mAdapter;
    private WorksBean bean;
    private boolean isCanLoadMore;//是否能加载更多

    public static Fragment create(int shop_id) {
        ZuoPingFragment fragment = new ZuoPingFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("shop_id", shop_id);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_mall_index_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        shop_id = getArguments().getInt("shop_id");
        isCanLoadMore = true;
        getData(false);
        recycle.addOnScrollListener(new OnRcvScrollListener() {
            @Override
            public void onBottom() {
                super.onBottom();
                if (isCanLoadMore)
                    getData(true);
            }
        });
    }

    @Override
    public void onLazyLoad() {

    }

    private void afterView(WorksBean bean, boolean isLoadMore) {
        if (isLoadMore) {
            mAdapter.injectHolderDelegate(new CreateHolderDelegate<WorksBean.ZuopingBean>() {
                @Override
                protected int getLayoutRes() {
                    return R.layout.item_mall_index_works_layout;
                }

                @Override
                protected BaseViewHolder onCreateHolder(View itemView) {
                    return new ZuoPingHolder(itemView);
                }
            }.addAllData(bean.getZuoping()));
            mAdapter.notifyDataSetChanged();
        } else {
            mAdapter = createAdapter(bean);
            recycle.setAdapter(mAdapter);
        }
    }

    private void getData(final boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
       // LoadDialog.showDialog(getActivity());
        ApiManager.getCaseNew(shop_id + "", page + "", limit + "", new OnRequestFinish<BaseBean<WorksBean>>() {
            @Override
            public void onFinished() {
                //LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<WorksBean> data) {
                WorksBean worksBean = data.getData();
                if (worksBean != null && worksBean.getZuoping().size() > 0) {
                    if (isLoadMore) {
                        bean.getZuoping().addAll(worksBean.getZuoping());
                        afterView(worksBean, true);
                    } else {
                        bean = worksBean;
                        afterView(bean, false);
                    }
                    noData.setVisibility(View.GONE);
                } else {
                    if (isLoadMore) {
                        isCanLoadMore = false;
                        page--;
                        mAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {
                            @Override
                            protected int onSpanSize() {
                                return 2;
                            }

                            @Override
                            protected int getLayoutRes() {
                                return R.layout.nodata_text_layout;
                            }

                            @Override
                            protected BaseViewHolder onCreateHolder(View itemView) {
                                return new BaseViewHolder<String>(itemView) {
                                    @Override
                                    protected void bindView(String o) {

                                    }
                                };
                            }
                        }.addData(""));//分割线View
                        mAdapter.notifyDataSetChanged();
                    } else {
                        noData.setVisibility(View.VISIBLE);
                    }
                }
            }

            @Override
            public void onError(Exception ex) {
                if (isLoadMore)
                    page--;
            }
        });

    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //作品Holder
    class ZuoPingHolder extends BaseViewHolder<WorksBean.ZuopingBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_context)
        TextView tvContext;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_sale_count)
        TextView tvSaleCount;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;
        @BindView(R.id.iv_video)
        JCVideoPlayerStandard ivVideo;
        @BindView(R.id.video_icon)
        ImageView videoIcon;

        private String type;
        private ArrayList<String> url;
        private int casrid;
        private String video_url;
        private String video_name;
        private String video_type;

        public ZuoPingHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (type.equals("tc")) {
                        FullScreenUtil.showFullScreenDialog(getActivity(),0,url);
                    }
                    if (type.equals("al")) {
                        Intent intent = new Intent(getActivity(), NewExampleDetailsActivity.class);
                        intent.putExtra("caseid", casrid);
                        getActivity().startActivity(intent);
                    }
                    if (type.equals("sp")) {
                        if (video_type.equals("h5")) {
                            JCFullScreenActivity.startActivity(getActivity(),
                                    video_url,
                                    JCVideoPlayerStandard.class, video_name
                            );
                        } else {
                            WebViewVideoActivity.startAction(getActivity(), video_url);
                        }
                    }
                }
            });
        }

        @Override
        protected void bindView(WorksBean.ZuopingBean zuopingBean) {
            type = zuopingBean.getType();
            if (type.equals("tc")) {//图册
                url = new ArrayList<>();
                for (int i = 0; i < zuopingBean.getPhotou().size(); i++) {
                    url.add(zuopingBean.getPhotou().get(i).getPhoto());
                }
                tvContext.setVisibility(View.VISIBLE);
                tvSaleCount.setVisibility(View.GONE);
                tvSeeCount.setVisibility(View.VISIBLE);
                tvContext.setText(zuopingBean.getSynopsis() + "");
                tvSeeCount.setText(zuopingBean.getClicked() + "");
                tvTitle.setText("" + zuopingBean.getName());
                GlideLoad.GlideLoadImg2(zuopingBean.getCover(), ivImg);
            }
            if (type.equals("al")) {//案例
                casrid = zuopingBean.getId();
                tvContext.setVisibility(View.VISIBLE);
                tvSaleCount.setVisibility(View.GONE);
                tvSeeCount.setVisibility(View.VISIBLE);
                tvPrice.setText(Constans.RMB + zuopingBean.getWeddingexpenses());
                tvTitle.setText("" + zuopingBean.getTitle());
                tvContext.setText(zuopingBean.getWeddingdescribe() + "");
                GlideLoad.GlideLoadImg2(zuopingBean.getWeddingcover(), ivImg);
            }
            if (type.equals("sp")) {//视频
                ivImg.setVisibility(View.VISIBLE);
                tvSaleCount.setVisibility(View.GONE);
                //ivVideo.setVisibility(View.VISIBLE);
                tvSeeCount.setVisibility(View.VISIBLE);
                tvPrice.setVisibility(View.GONE);
                video_url = zuopingBean.getVideo_url();
                video_name = zuopingBean.getTitle();
                video_type = zuopingBean.getVideo_type();
                //ivVideo.setUp(zuopingBean.getVideo_url(), zuopingBean.getTitle());
                GlideLoad.GlideLoadImg2(zuopingBean.getCover(), ivImg);
                videoIcon.setVisibility(View.VISIBLE);
                tvTitle.setText(zuopingBean.getTitle() + "");
                tvSeeCount.setText(zuopingBean.getClicked() + "");
            }
        }
    }

    //全局view Adapter

    private BaseAdapter createAdapter(WorksBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter().
                injectHolderDelegate(new AllNumberDele() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }
                }.cleanAfterAddData("全部作品(" + bean.getNum() + ")"))//统计view
                .injectHolderDelegate(new CreateHolderDelegate<WorksBean.ZuopingBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_mall_index_works_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new ZuoPingHolder(itemView);
                    }
                }.addAllData(bean.getZuoping()));

        baseAdapter.setLayoutManager(recycle);

        return baseAdapter;
    }
}

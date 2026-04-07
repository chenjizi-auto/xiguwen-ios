package com.linzi.xiguwen.fragment.shop;

import android.app.Activity;
import android.content.Context;
import android.graphics.Rect;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.hedgehog.ratingbar.RatingBar;
import com.jaeger.ninegridimageview.ItemImageClickListener;
import com.jaeger.ninegridimageview.NineGridImageView;
import com.jaeger.ninegridimageview.NineGridImageViewAdapter;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.base.listener.OnRcvScrollListener;
import com.linzi.xiguwen.fragment.club.dele.AllNumberDele;
import com.linzi.xiguwen.fragment.shop.model.bean.EvaluateBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideLoad;
import com.previewlibrary.GPreviewBuilder;
import com.linzi.xiguwen.preview.PreviewUtil;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/3/28.
 */

public class PingJiaFragment extends BaseLazyFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data)
    TextView noData;
    private int shop_id;
    private int page = 1;
    private int limit = 10;
    private BaseAdapter mAdapter;
    private EvaluateBean bean;
    private boolean isCanLoadMore;//是否能加载更多

    public static Fragment create(int shop_id) {
        PingJiaFragment fragment = new PingJiaFragment();
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

    private void getData(final boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
      //  LoadDialog.showDialog(getActivity());
        ApiManager.getEvaluation(shop_id + "", page + "", limit + "", new OnRequestFinish<BaseBean<EvaluateBean>>() {
            @Override
            public void onFinished() {
                //LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<EvaluateBean> data) {
                EvaluateBean evaluateBean = data.getData();
                if (evaluateBean != null && evaluateBean.getPinlun().size() > 0) {
                    if (isLoadMore) {
                        bean.getPinlun().addAll(evaluateBean.getPinlun());
                        afterView(evaluateBean, true);
                    } else {
                        bean = evaluateBean;
                        afterView(bean, false);
                    }

                    noData.setVisibility(View.GONE);
                } else {
                    if (isLoadMore) {
                        isCanLoadMore = false;
                        page--;
                        mAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {

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
                        }.addData(""));//no data View
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

    private void afterView(EvaluateBean bean, boolean isLoadMore) {

        for (int i = 0; i < bean.getPinlun().size(); i++) {
            List<EvaluateBean.PinlunBean.PicsBean> list = new ArrayList<>();
            for (int j = 0; j < bean.getPinlun().get(i).getPictures().size(); j++) {
                EvaluateBean.PinlunBean.PicsBean picsBean = new EvaluateBean.PinlunBean.PicsBean();
                picsBean.setUrl(bean.getPinlun().get(i).getPictures().get(j));
                list.add(picsBean);
            }
            bean.getPinlun().get(i).setPics(list);
        }
        if (isLoadMore) {
            mAdapter.injectHolderDelegate(new CreateHolderDelegate<EvaluateBean.PinlunBean>() {
                @Override
                protected int getLayoutRes() {
                    return R.layout.new_pingjia_item;
                }

                @Override
                protected BaseViewHolder onCreateHolder(View itemView) {
                    return new PingJiaHolder(itemView);
                }
            }.addAllData(bean.getPinlun()));
            mAdapter.notifyDataSetChanged();
        } else {
            mAdapter = createAdapter(bean);
            recycle.setAdapter(mAdapter);
        }
    }


    @Override
    public void onLazyLoad() {

    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //评价Holder
    class PingJiaHolder extends BaseViewHolder<EvaluateBean.PinlunBean> {
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.ratingbar)
        RatingBar ratingbar;
        @BindView(R.id.tv_star_count)
        TextView tvStarCount;
        @BindView(R.id.ll_pic)
        LinearLayout llPic;
        @BindView(R.id.tv_reply)
        TextView tvReply;
        @BindView(R.id.tv_context)
        TextView tvContext;
        @BindView(R.id.grid_image)
        NineGridImageView grid_image;

        public PingJiaHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(EvaluateBean.PinlunBean pinglunBean) {
            GlideLoad.GlideLoadCircle(pinglunBean.getHead(), ivHead);
            tvName.setText("" + pinglunBean.getNickname());
            tvTime.setText("" + pinglunBean.getCreated_at());
            ratingbar.setStar(pinglunBean.getOrder_score());
            tvStarCount.setText(pinglunBean.getOrder_score() + "分");
            tvContext.setText(pinglunBean.getContent());
            grid_image.setAdapter(mAdapter);
            grid_image.setImagesData(pinglunBean.getPics());
            grid_image.setItemImageClickListener(new ItemImageClickListener<EvaluateBean.PinlunBean.PicsBean>() {
                @Override
                public void onItemImageClick(Context context, ImageView imageView, int index, List<EvaluateBean.PinlunBean.PicsBean> list) {
                    if (!PreviewUtil.canPreview(context, list, index)) {
                        return;
                    }
                    computeBoundsBackward(list);//组成数据
                    GPreviewBuilder.from((Activity) context)
                            .setUserFragment(com.linzi.xiguwen.preview.SafePreviewPhotoFragment.class)
                            .setData(list)
                            .setCurrentIndex(index)
                            .setType(GPreviewBuilder.IndicatorType.Dot)
                            .start();//启动
                }
            });
        }

        /**
         * 查找信息
         *
         * @param list 图片集合
         */
        private void computeBoundsBackward(List<EvaluateBean.PinlunBean.PicsBean> list) {
            for (int i = 0; i < grid_image.getChildCount(); i++) {
                View itemView = grid_image.getChildAt(i);
                Rect bounds = new Rect();
                if (itemView != null) {
                    ImageView thumbView = (ImageView) itemView;
                    thumbView.getGlobalVisibleRect(bounds);
                }
                list.get(i).setBounds(bounds);
                list.get(i).setUrl(list.get(i).getUrl());
            }
        }

        private NineGridImageViewAdapter<EvaluateBean.PinlunBean.PicsBean> mAdapter = new NineGridImageViewAdapter<EvaluateBean.PinlunBean.PicsBean>() {
            @Override
            protected void onDisplayImage(Context context, ImageView imageView, EvaluateBean.PinlunBean.PicsBean s) {
                GlideLoad.GlideLoadImg2(s.getUrl(), imageView);
            }

            @Override
            protected ImageView generateImageView(Context context) {
                return super.generateImageView(context);
            }

            @Override
            protected void onItemImageClick(Context context, ImageView imageView, int index, List<EvaluateBean.PinlunBean.PicsBean> list) {
                //  Toast.makeText(context, "image position is " + index, Toast.LENGTH_SHORT).show();
            }
        };
    }

    //全局view Adapter
    private BaseAdapter createAdapter(EvaluateBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter().
                injectHolderDelegate(new AllNumberDele() {
                }.cleanAfterAddData("全部评价(" + bean.getNum() + ")"))//统计view
                .injectHolderDelegate(new CreateHolderDelegate<EvaluateBean.PinlunBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_pingjia_item;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new PingJiaHolder(itemView);
                    }
                }.addAllData(bean.getPinlun()));


        baseAdapter.setLayoutManager(recycle);

        return baseAdapter;
    }
}

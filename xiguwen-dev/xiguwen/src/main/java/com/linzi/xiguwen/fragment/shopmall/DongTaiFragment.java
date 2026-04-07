package com.linzi.xiguwen.fragment.shopmall;

import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.graphics.Rect;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewOutlineProvider;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

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
import com.linzi.xiguwen.fragment.shopmall.bean.DongTaiBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.NToast;
import com.previewlibrary.GPreviewBuilder;
import com.linzi.xiguwen.preview.PreviewUtil;
import com.wx.goodview.GoodView;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/7.
 */

public class DongTaiFragment extends BaseLazyFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data)
    TextView noData;
    private int page = 1;
    private int limit = 10;
    private int shop_id;
    private boolean isCanLoadMore;
    private DongTaiBean bean;
    private BaseAdapter mAdapter;


    public static Fragment create(int shop_id) {
        DongTaiFragment fragment = new DongTaiFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("shop_id", shop_id);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Override
    public void onLazyLoad() {

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
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    private void afterView(DongTaiBean bean, boolean isLoadMore) {
        if (isLoadMore) {
            mAdapter.injectHolderDelegate(new CreateHolderDelegate<DongTaiBean.DataBean>() {
                @Override
                protected int getLayoutRes() {
                    return R.layout.item_news_club_activities_layout;
                }

                @Override
                protected BaseViewHolder onCreateHolder(View itemView) {
                    return new DongTaiHolder(itemView);
                }
            }.addAllData(bean.getData()));
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
       // LoadDialog.showDialog(getContext());
        ApiManager.getShopMallDongTai(shop_id, page, limit, new OnRequestFinish<BaseBean<DongTaiBean>>() {
            @Override
            public void onFinished() {
                //LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<DongTaiBean> data) {
                DongTaiBean dongTaiBean = data.getData();
                if (dongTaiBean.getData() != null && dongTaiBean.getData().size() > 0) {
                    if (isLoadMore) {
                        bean.getData().addAll(dongTaiBean.getData());
                        afterView(dongTaiBean, true);
                    } else {
                        bean = dongTaiBean;
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

    //动态Holder
    class DongTaiHolder extends BaseViewHolder<DongTaiBean.DataBean> {
        @BindView(R.id.iv_head_img)
        ImageView ivHeadImg;
        @BindView(R.id.tv_user_name)
        TextView tvUserName;
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_team_name)
        TextView tvTeamName;
        @BindView(R.id.bt_care)
        Button btCare;
        @BindView(R.id.tv_content)
        TextView tvContent;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;
        @BindView(R.id.tv_pingjia_count)
        TextView tvPingjiaCount;
        @BindView(R.id.tv_dianzan_count)
        TextView tvDianzanCount;
        @BindView(R.id.grid_image)
        NineGridImageView grid_image;
        private boolean isLike;
        GoodView goodView = new GoodView(itemView.getContext());
        private int id;

        public DongTaiHolder(View itemView) {
            super(itemView);
        }

        //点赞
        private void getLike(int id, final View view) {
            ApiManager.giveALike(id, new OnRequestFinish<BaseBean>() {
                @Override
                public void onFinished() {

                }

                @Override
                public void onSuccess(BaseBean data) {
                    if (data.getCode() == 0) {
                        goodView.setTextInfo("+1", Color.RED, 30);
                        goodView.show(view);
                        isLike = true;
                    } else
                        NToast.show(data.getMessage());
                }

                @Override
                public void onError(Exception ex) {

                }
            });
        }

        //取消点赞
        private void cancleLike(int id, final View view) {
            ApiManager.disGiveALike(id, new OnRequestFinish<BaseBean>() {
                @Override
                public void onFinished() {

                }

                @Override
                public void onSuccess(BaseBean data) {
                    if (data.getCode() == 0) {
                        goodView.setTextInfo("-1", Color.GRAY, 30);
                        goodView.show(view);
                        isLike = false;
                    } else
                        NToast.show(data.getMessage());
                }

                @Override
                public void onError(Exception ex) {

                }
            });
        }

        @Override
        protected void bindView(DongTaiBean.DataBean dongtaiBean) {
//            id = dongtaiBean.getId();
//            tvDianzanCount.setOnClickListener(new View.OnClickListener() {
//                @Override
//                public void onClick(View view) {
//                    NToast.log("APPTAG", id + "\n" + SPUtil.get("token", SPUtil.Type.STR).toString() + "\n" + SPUtil.get("userid", SPUtil.Type.INT) + "");
//                    if (isLike) {
//                        cancleLike(id, view);
//                    } else {
//                        getLike(id, view);
//                    }
//                }
//            });
            btCare.setVisibility(View.GONE);
            GlideLoad.GlideLoadCircle(dongtaiBean.getHead(), ivHeadImg);
            tvUserName.setText(dongtaiBean.getNickname());
            tvZhiwei.setText("");
            tvTime.setText(dongtaiBean.getCreate_ti());
            tvTeamName.setText(dongtaiBean.getTheteam());
            tvContent.setText(dongtaiBean.getContent());
            tvSeeCount.setText(dongtaiBean.getPv() + "");
            tvPingjiaCount.setText(dongtaiBean.getCommentnum() + "");
            tvDianzanCount.setText(dongtaiBean.getZan() + "");
            grid_image.setAdapter(mAdapter);
            grid_image.setImagesData(dongtaiBean.getPhotourl());
            grid_image.setItemImageClickListener(new ItemImageClickListener<DongTaiBean.DataBean.PhotourlBean>() {

                @Override
                public void onItemImageClick(Context context, ImageView imageView, int index, List<DongTaiBean.DataBean.PhotourlBean> list) {
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
        private void computeBoundsBackward(List<DongTaiBean.DataBean.PhotourlBean> list) {
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

        private NineGridImageViewAdapter<DongTaiBean.DataBean.PhotourlBean> mAdapter = new NineGridImageViewAdapter<DongTaiBean.DataBean.PhotourlBean>() {
            @Override
            protected void onDisplayImage(Context context, ImageView imageView, DongTaiBean.DataBean.PhotourlBean s) {
                GlideLoad.GlideLoadImg2(s.getUrl(), imageView);
            }

            @Override
            protected ImageView generateImageView(Context context) {
                ImageView imageView = super.generateImageView(context);
                imageView.setBackgroundResource(R.drawable.rounded_list_image_bg);
                imageView.setClipToOutline(true);
                imageView.setOutlineProvider(ViewOutlineProvider.BACKGROUND);
                imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                return imageView;
            }

            @Override
            protected void onItemImageClick(Context context, ImageView imageView, int index, List<DongTaiBean.DataBean.PhotourlBean> list) {
                //  Toast.makeText(context, "image position is " + index, Toast.LENGTH_SHORT).show();
            }
        };
    }

    //全局view Adapter
    private BaseAdapter createAdapter(DongTaiBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter().
                injectHolderDelegate(new AllNumberDele().cleanAfterAddData("全部动态(" + bean.getNum() + ")"))//统计view
                .injectHolderDelegate(new CreateHolderDelegate<DongTaiBean.DataBean>() {


                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_news_club_activities_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new DongTaiHolder(itemView) {

                        };
                    }
                }.addAllData(bean.getData()));

        baseAdapter.setLayoutManager(recycle);

        return baseAdapter;
    }
}

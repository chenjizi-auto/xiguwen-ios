package com.linzi.xiguwen.fragment.shop;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Rect;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
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
import com.linzi.xiguwen.bean.ShopUserDetailsBean;
import com.linzi.xiguwen.fragment.multistage.fragment.MultistageTandemFragment;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.NewBaijiaDetailsActivity;
import com.linzi.xiguwen.ui.NewExampleDetailsActivity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
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

public class IndexFragment extends BaseLazyFragment {

    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data)
    TextView noData;
    private int shop_id;
    private BaseAdapter mAdapter;
    private ShopUserDetailsBean bean;
    private MultistageTandemFragment multistageTandemBean;
    private int pingjiaNum;

    public static Fragment create(int shop_id) {
        IndexFragment fragment = new IndexFragment();
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
        getData();
        multistageTandemBean = ((NewMallDetailsActivity) getActivity()).getBean();
    }

    private void afterView(ShopUserDetailsBean data) {
        pingjiaNum = data.getPinglun().size();
        limitItemNum(4, bean);//最多4个item

        for (int i = 0; i < bean.getPinglun().size(); i++) {
            List<ShopUserDetailsBean.PinglunBean.PicsBean> list = new ArrayList<>();
            for (int j = 0; j < bean.getPinglun().get(i).getPictures().size(); j++) {
                ShopUserDetailsBean.PinglunBean.PicsBean picsBean = new ShopUserDetailsBean.PinglunBean.PicsBean();
                picsBean.setUrl(bean.getPinglun().get(i).getPictures().get(j));
                list.add(picsBean);
            }
            bean.getPinglun().get(i).setPics(list);
        }

        mAdapter = createAdapter(data);
        recycle.setAdapter(mAdapter);
    }

    @Override
    public void onLazyLoad() {

    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //初始化数据
    private void getData() {
        if (bean == null) {
            //LoadDialog.showDialog(getContext());
            ApiManager.getUserDetails(shop_id + "", new OnRequestFinish<BaseBean<ShopUserDetailsBean>>() {
                @Override
                public void onFinished() {
                    //LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean<ShopUserDetailsBean> data) {
                    bean = data.getData();
                    if (bean != null) {
                        afterView(bean);
                        noData.setVisibility(View.GONE);
                    } else {
                        noData.setVisibility(View.VISIBLE);
                    }
                }

                @Override
                public void onError(Exception ex) {
                }
            });
        } else {
            afterView(bean);
        }
    }

    //标题Delegate
    class TitleDelegate extends CreateHolderDelegate<String> {

        @Override
        protected int getLayoutRes() {
            return R.layout.item_mall_title;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new TitleHolder(itemView);
        }
    }

    //标题Holder
    class TitleHolder extends BaseViewHolder<String> {

        public TitleHolder(View itemView) {
            super(itemView);
        }

        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_more)
        TextView tvMore;

        @Override
        protected void bindView(String s) {
            tvName.setText(s);
        }

    }

    //报价Holder
    class BaoJiaHolder extends BaseViewHolder<ShopUserDetailsBean.BaojiaBeanX.BaojiaBean> {
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
        private int id;

        public BaoJiaHolder(View itemView) {
            super(itemView);

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewBaijiaDetailsActivity.class);
                    intent.putExtra("offoer_id", id);
                    getActivity().startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(ShopUserDetailsBean.BaojiaBeanX.BaojiaBean baojiaBean) {
            id = baojiaBean.getQuotationid();
            tvContext.setVisibility(View.GONE);
            tvSaleCount.setVisibility(View.VISIBLE);
            tvSeeCount.setVisibility(View.GONE);
            tvSaleCount.setText("已售 " + baojiaBean.getNum());
            tvPrice.setText(Constans.RMB + baojiaBean.getPrice());
            tvTitle.setText("" + baojiaBean.getName());
            GlideLoad.GlideLoadImg2(baojiaBean.getImglist(), ivImg);
            tvTitle.setText("" + baojiaBean.getName());
            tvPrice.setText(Constans.RMB + baojiaBean.getPrice() + "");
        }
    }

    //案例Holder
    class AnliHolder extends BaseViewHolder<ShopUserDetailsBean.ZuopingBean.ZuopinBean> {
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
        private int casrid;

        public AnliHolder(View itemView) {
            super(itemView);

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewExampleDetailsActivity.class);
                    intent.putExtra("caseid", casrid);
                    getActivity().startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(ShopUserDetailsBean.ZuopingBean.ZuopinBean zuopingBean) {
            tvContext.setVisibility(View.VISIBLE);
            tvSaleCount.setVisibility(View.GONE);
            tvSeeCount.setVisibility(View.VISIBLE);
            tvContext.setText("" + zuopingBean.getWeddingdescribe());
            tvSeeCount.setText("" + zuopingBean.getClicked());
            GlideLoad.GlideLoadImg2(zuopingBean.getWeddingcover(), ivImg);
            tvTitle.setText("" + zuopingBean.getTitle());
            tvPrice.setText(Constans.RMB + zuopingBean.getWeddingexpenses() + "");
            casrid = zuopingBean.getId();
        }
    }

    //评价Holder
    class PingJiaHolder extends BaseViewHolder<ShopUserDetailsBean.PinglunBean> {
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
        protected void bindView(ShopUserDetailsBean.PinglunBean pinglunBean) {
            GlideLoad.GlideLoadCircle(pinglunBean.getHead(), ivHead);
            tvName.setText("" + pinglunBean.getNickname());
            tvTime.setText("" + pinglunBean.getCreated_at());
            ratingbar.setStar(pinglunBean.getOrder_score());
            tvStarCount.setText(pinglunBean.getOrder_score() + "分");
            tvContext.setText(pinglunBean.getContent());
            grid_image.setAdapter(mAdapter);
            grid_image.setImagesData(pinglunBean.getPics());
            grid_image.setItemImageClickListener(new ItemImageClickListener<ShopUserDetailsBean.PinglunBean.PicsBean>() {
                @Override
                public void onItemImageClick(Context context, ImageView imageView, int index, List<ShopUserDetailsBean.PinglunBean.PicsBean> list) {
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
        private void computeBoundsBackward(List<ShopUserDetailsBean.PinglunBean.PicsBean> list) {
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

        private NineGridImageViewAdapter<ShopUserDetailsBean.PinglunBean.PicsBean> mAdapter = new NineGridImageViewAdapter<ShopUserDetailsBean.PinglunBean.PicsBean>() {
            @Override
            protected void onDisplayImage(Context context, ImageView imageView, ShopUserDetailsBean.PinglunBean.PicsBean s) {
                GlideLoad.GlideLoadImg2(s.getUrl(), imageView);
            }

            @Override
            protected ImageView generateImageView(Context context) {
                return super.generateImageView(context);
            }

            @Override
            protected void onItemImageClick(Context context, ImageView imageView, int index, List<ShopUserDetailsBean.PinglunBean.PicsBean> list) {
                //  Toast.makeText(context, "image position is " + index, Toast.LENGTH_SHORT).show();
            }
        };
    }

    //团队Holder
    class TeamHolder extends BaseViewHolder<ShopUserDetailsBean.TuijiantdBean> {
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.bt_price)
        Button btPrice;
        private int shop_id;

        public TeamHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", shop_id);
                    getActivity().startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(ShopUserDetailsBean.TuijiantdBean tuijiantdBean) {
            GlideLoad.GlideLoadCircle(tuijiantdBean.getHead(), ivHead);
            tvName.setText("" + tuijiantdBean.getNickname());
            tvZhiwei.setText("" + tuijiantdBean.getOccupationid());
            btPrice.setText(Constans.RMB + tuijiantdBean.getZuidijia() + "起");
            shop_id = tuijiantdBean.getUserid();
        }
    }

    CreateHolderDelegate<String> nodata = new CreateHolderDelegate<String>() {
        @Override
        protected int onSpanSize() {
            return 6;
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
    };

    //全局适配器
    private BaseAdapter createAdapter(ShopUserDetailsBean bean) {

        BaseAdapter adapter = BaseAdapter.createBaseAdapter();

        if (bean.getBaojia().getBaojia() != null && bean.getBaojia().getBaojia().size() > 0) {
            adapter.injectHolderDelegate(new TitleDelegate() {
                @Override
                protected int onSpanSize() {
                    return 6;
                }
            }.cleanAfterAddData("商品报价（" + bean.getBaojia().getZongshu() + "）"))

                    .injectHolderDelegate(new CreateHolderDelegate<ShopUserDetailsBean.BaojiaBeanX.BaojiaBean>() {
                        @Override
                        protected int getLayoutRes() {
                            return R.layout.item_mall_index_works_layout;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new BaoJiaHolder(itemView);
                        }

                        @Override
                        protected int onSpanSize() {
                            return 3;
                        }
                    }.cleanAfterAddAllData(bean.getBaojia().getBaojia()))//报价item
                    .injectHolderDelegate(new CreateHolderDelegate<String>() {

                        @Override
                        protected int onSpanSize() {
                            return 6;
                        }

                        @Override
                        protected int getLayoutRes() {
                            return R.layout.get_more_data_layout;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new BaseViewHolder<String>(itemView) {
                                @Override
                                protected void bindView(String o) {
                                    TextView textView = ((TextView) itemView.findViewById(R.id.tv_more_some));
                                    textView.setText("查看全部报价");
                                    textView.setOnClickListener(new View.OnClickListener() {
                                        @Override
                                        public void onClick(View view) {
                                            multistageTandemBean.selectTab(1);
                                        }
                                    });
                                }
                            };
                        }
                    }.cleanAfterAddData(""))
                    .injectHolderDelegate(new CreateHolderDelegate<String>() {
                        @Override
                        protected int onSpanSize() {
                            return 6;
                        }

                        @Override
                        protected int getLayoutRes() {
                            return R.layout.item_dev;
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
          //  adapter.setLayoutManager(recycle);
        }


        if (bean.getZuoping().getZuopin() != null && bean.getZuoping().getZuopin().size() > 0) {
            adapter.injectHolderDelegate(new TitleDelegate() {
                @Override
                protected int onSpanSize() {
                    return 6;
                }
            }.cleanAfterAddData("作品案例（" + bean.getZuoping().getZongshu() + "）"))

                    .injectHolderDelegate(new CreateHolderDelegate<ShopUserDetailsBean.ZuopingBean.ZuopinBean>() {
                        @Override
                        protected int getLayoutRes() {
                            return R.layout.item_mall_index_works_layout;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new AnliHolder(itemView);
                        }

                        @Override
                        protected int onSpanSize() {
                            return 3;
                        }
                    }.cleanAfterAddAllData(bean.getZuoping().getZuopin()))//案例item

                    .injectHolderDelegate(new CreateHolderDelegate<String>() {

                        @Override
                        protected int onSpanSize() {
                            return 6;
                        }

                        @Override
                        protected int getLayoutRes() {
                            return R.layout.get_more_data_layout;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new BaseViewHolder<String>(itemView) {
                                @Override
                                protected void bindView(String o) {
                                    TextView textView = ((TextView) itemView.findViewById(R.id.tv_more_some));
                                    textView.setText("查看全部作品案例");
                                    textView.setOnClickListener(new View.OnClickListener() {
                                        @Override
                                        public void onClick(View view) {
                                            multistageTandemBean.selectTab(2);
                                        }
                                    });
                                }
                            };
                        }
                    }.cleanAfterAddData(""))

                    .injectHolderDelegate(new CreateHolderDelegate<String>() {

                        @Override
                        protected int onSpanSize() {
                            return 6;
                        }

                        @Override
                        protected int getLayoutRes() {
                            return R.layout.item_dev;
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
         //   adapter.setLayoutManager(recycle);
        }
        if (bean.getPinglun() != null && bean.getPinglun().size() > 0) {
            adapter.injectHolderDelegate(new TitleDelegate() {
                @Override
                protected int onSpanSize() {
                    return 6;
                }
            }.cleanAfterAddData("用户评价（" + pingjiaNum + "）"))

                    .injectHolderDelegate(new CreateHolderDelegate<ShopUserDetailsBean.PinglunBean>() {
                        @Override
                        protected int getLayoutRes() {
                            return R.layout.new_pingjia_item;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new PingJiaHolder(itemView);
                        }

                        @Override
                        protected int onSpanSize() {
                            return 6;
                        }
                    }.cleanAfterAddAllData(bean.getPinglun()))//评价item

                    .injectHolderDelegate(new CreateHolderDelegate<String>() {

                        @Override
                        protected int onSpanSize() {
                            return 6;
                        }

                        @Override
                        protected int getLayoutRes() {
                            return R.layout.get_more_data_layout;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new BaseViewHolder<String>(itemView) {
                                @Override
                                protected void bindView(String o) {
                                    TextView textView = ((TextView) itemView.findViewById(R.id.tv_more_some));
                                    textView.setText("查看全部评价");
                                    textView.setOnClickListener(new View.OnClickListener() {
                                        @Override
                                        public void onClick(View view) {
                                            multistageTandemBean.selectTab(3);
                                        }
                                    });
                                }
                            };
                        }
                    }.cleanAfterAddData(""))

                    .injectHolderDelegate(new CreateHolderDelegate<String>() {
                        @Override
                        protected int onSpanSize() {
                            return 6;
                        }

                        @Override
                        protected int getLayoutRes() {
                            return R.layout.item_dev;
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
          //  adapter.setLayoutManager(recycle);
        }
        if (bean.getTuijiantd() != null && bean.getTuijiantd().size() > 0) {
            adapter.injectHolderDelegate(new TitleDelegate() {
                @Override
                protected int onSpanSize() {
                    return 6;
                }
            }.cleanAfterAddData("推荐团队"))

                    .injectHolderDelegate(new CreateHolderDelegate<ShopUserDetailsBean.TuijiantdBean>() {
                        @Override
                        protected int getLayoutRes() {
                            return R.layout.item_tuijian_team_layout;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new TeamHolder(itemView);
                        }

                        @Override
                        protected int onSpanSize() {
                            return 2;
                        }
                    }.addAllData(bean.getTuijiantd()))//团队item

                    .injectHolderDelegate(new CreateHolderDelegate<String>() {
                        @Override
                        protected int onSpanSize() {
                            return 6;
                        }

                        @Override
                        protected int getLayoutRes() {
                            return R.layout.item_dev;
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
            //adapter.setLayoutManager(recycle);
        }
        if (nodata.getData() == null) {
            adapter.injectHolderDelegate(nodata.addData("123"));//分割线View
        }
       if (adapter.getItemCount()>0){
           adapter.setLayoutManager(recycle);
       }

        return adapter;
    }

    //限制item个数
    private void limitItemNum(int limit, ShopUserDetailsBean bean) {


        if (bean.getPinglun().size() > limit) {
            List<ShopUserDetailsBean.PinglunBean> list = new ArrayList<>();
            for (int i = 0; i < limit; i++) {
                list.add(bean.getPinglun().get(i));
            }
            bean.setPinglun(list);
        }

        if (bean.getZuoping().getZuopin().size() > limit) {
            List<ShopUserDetailsBean.ZuopingBean.ZuopinBean> list = new ArrayList<>();
            for (int i = 0; i < limit; i++) {
                list.add(bean.getZuoping().getZuopin().get(i));
            }
            bean.getZuoping().setZuopin(list);
        }

        if (bean.getBaojia().getBaojia().size() > limit) {
            List<ShopUserDetailsBean.BaojiaBeanX.BaojiaBean> list = new ArrayList<>();
            for (int i = 0; i < limit; i++) {
                list.add(bean.getBaojia().getBaojia().get(i));
            }
            bean.getBaojia().setBaojia(list);
        }

    }
}

package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.view.ViewCompat;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.JiFenGoodsDetailBean;
import com.linzi.xiguwen.bean.JiFenHongBaoDetailBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.dialog.InputPassWordDialog;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.utils.ToastUtils;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/5/25.
 */

public class JiFenGoodsDetailActivity extends AppCompatActivity {

    @BindView(R.id.recycle2)
    RecyclerView recycle2;
    @BindView(R.id.iv_chat)
    ImageView ivChat;
    @BindView(R.id.iv_call_phone)
    ImageView ivCallPhone;
    @BindView(R.id.iv_care)
    ImageView ivCare;
    @BindView(R.id.ll_add_in_cart)
    LinearLayout llAddInCart;
    @BindView(R.id.ll_buy)
    LinearLayout llBuy;
    @BindView(R.id.ll_yuyue)
    LinearLayout llYuyue;
    @BindView(R.id.ll_bottom)
    LinearLayout llBottom;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.ll_title)
    RelativeLayout llTitle;
    @BindView(R.id.ll_back)
    LinearLayout llBack;
    @BindView(R.id.ll_right)
    LinearLayout llRight;
    @BindView(R.id.iv_to_top)
    ImageView ivToTop;
    @BindView(R.id.tv_cart_num)
    TextView tvCartNum;
    @BindView(R.id.iv_cart)
    RelativeLayout ivCart;
    @BindView(R.id.ll_parent)
    RelativeLayout llParent;
    @BindView(R.id.ll_ctrl)
    LinearLayout llCtrl;
    @BindView(R.id.tv_llgm)
    TextView tvLlgm;

    private Context mContext;
    private int goods_id;
    private int type;//0商品 1红包

    private ArrayList<String> url;//图片浏览用
    private BaseAdapter mAdapter;

    private JiFenGoodsDetailBean jiFenGoodsDetailBean;
    private JiFenHongBaoDetailBean jiFenHongBaoDetailBean;

    private InputPassWordDialog inputPassWordDialog;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(JiFenGoodsDetailActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(JiFenGoodsDetailActivity.this, R.color.white);
        }
        setContentView(R.layout.new_activity_baijia_details);
        ButterKnife.bind(this);
        goods_id = getIntent().getIntExtra("goods_id", -1);
        type = getIntent().getIntExtra("type", -1);
        mContext = this;

        initView();
        if (goods_id != -1) {
            if (type == 0) {
                getGoodsData();
            } else {
                getHongBaoData();
            }
        } else {
            finish();
            NToast.show("跳转失败，请重试！");
        }
    }

    private void initView() {
        tvCartNum.setVisibility(View.GONE);
        llCtrl.setVisibility(View.GONE);
        llAddInCart.setVisibility(View.GONE);
        tvLlgm.setText("马上兑换");
        ivCart.setVisibility(View.GONE);
        ivToTop.setVisibility(View.GONE);
        tvTitle.setText("商品详情");

        llBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        llRight.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //分享
                if (type == 0) {
                    GetShareContentUtil.getContent(JiFenGoodsDetailActivity.this, goods_id, 13, -1);
                } else {
                    GetShareContentUtil.getContent(JiFenGoodsDetailActivity.this, goods_id, 14, -1);
                }
            }
        });

        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(JiFenGoodsDetailActivity.this));
        llBar.setLayoutParams(params);

        ViewCompat.setAlpha(llTitle, 0);
        ViewCompat.setAlpha(llBar, 0);

        recycle2.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
                super.onScrolled(recyclerView, dx, dy);

                int position = ((LinearLayoutManager) recyclerView.getLayoutManager()).findFirstVisibleItemPosition();
                if (position > 0) {
                    llBar.setAlpha(1); // 显示
                    llTitle.setAlpha(1); // 显示

                    return;
                } else {
                    int top = recyclerView.getChildAt(0).getTop();
                    float v = -(top * 1.0f / recyclerView.getChildAt(0).getHeight());
                    if (v > 1) {
                        v = 1;
                    } else if (v < 0) {
                        v = 0;
                    }
                    llBar.setAlpha(v);
                    llTitle.setAlpha(v);
                }
            }
        });

        afterView();
    }

    private void afterView() {
        if (type == 0) {
            mAdapter = createGoodsAdapter();
        } else {
            mAdapter = createHongBaoAdapter();
        }
        recycle2.setAdapter(mAdapter);
    }

    //商品详情
    private void getGoodsData() {
        LoadDialog.showDialog(mContext);
        ApiManager.getJiFenGoodsDetail(goods_id, new OnRequestFinish<BaseBean<JiFenGoodsDetailBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<JiFenGoodsDetailBean> data) {
                jiFenGoodsDetailBean = data.getData();

                if (jiFenGoodsDetailBean.getData().getMiaoshu() != null && jiFenGoodsDetailBean.getData().getMiaoshu().size() > 0) {
                    List<JiFenGoodsDetailBean.DataBean.PicsBean> list = new ArrayList<>();
                    for (int i = 0; i < jiFenGoodsDetailBean.getData().getMiaoshu().size(); i++) {//包装图片列表
                        JiFenGoodsDetailBean.DataBean.PicsBean picsBean = new JiFenGoodsDetailBean.DataBean.PicsBean();
                        picsBean.setImgurl(jiFenGoodsDetailBean.getData().getMiaoshu().get(i));
                        list.add(picsBean);
                    }
                    jiFenGoodsDetailBean.getData().setPicsBean(list);

                    url = (ArrayList<String>) jiFenGoodsDetailBean.getData().getMiaoshu();
                } else {
                    url = new ArrayList<>();
                }

                if (jiFenGoodsDetailBean.getData().getKucuun() == 0) {
                    llBuy.setBackgroundColor(mContext.getResources().getColor(R.color.colorHint));
                    tvLlgm.setText("库存不足");
                    llBuy.setEnabled(false);
                } else {
                    tvLlgm.setTextColor(mContext.getResources().getColor(R.color.white));
                    llBuy.setEnabled(true);
                    llBuy.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            if (!LoginUtil.isLogin()) {
                                LoginActivity.startAction(mContext);
                                return;
                            }
                            Intent intent = new Intent(mContext, JiFenSureOrderActivity.class);
                            intent.putExtra("rec_id", goods_id);
                            mContext.startActivity(intent);
                        }
                    });
                }

                goodsbanner.cleanAfterAddData(jiFenGoodsDetailBean);
                goodsInfo.cleanAfterAddData(jiFenGoodsDetailBean.getData());
                imgdel.cleanAfterAddAllData(jiFenGoodsDetailBean.getData().getPicsBean());
                goodsgussdel.cleanAfterAddAllData(jiFenGoodsDetailBean.getYoulike());
                mAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    //红包详情
    private void getHongBaoData() {
        LoadDialog.showDialog(mContext);
        ApiManager.getJiFenHongBaoDetail(goods_id, new OnRequestFinish<BaseBean<JiFenHongBaoDetailBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<JiFenHongBaoDetailBean> data) {
                jiFenHongBaoDetailBean = data.getData();

                if (jiFenHongBaoDetailBean.getData().getNumber() == 0) {
                    llBuy.setBackgroundColor(mContext.getResources().getColor(R.color.c_f3f3f3));
                    tvLlgm.setText("库存不足");
                    llBuy.setEnabled(false);
                } else {

                    final int jifen = jiFenHongBaoDetailBean.getData().getXuyaojifen();
                    final int id = jiFenHongBaoDetailBean.getData().getId();
                    final String goodsname = jiFenHongBaoDetailBean.getData().getName();

                    llBuy.setEnabled(true);
                    llBuy.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            if (!LoginUtil.isLogin()) {
                                LoginActivity.startAction(mContext);
                                return;
                            }
                            createDel("提示", "请确认是否使用[ " + jifen + " ]积分兑换[" + goodsname + "]", "点错了", "确认", id, jifen + "");
                        }
                    });
                }

                hongbaobanner.cleanAfterAddData(jiFenHongBaoDetailBean);
                hongbaoInfo.cleanAfterAddData(jiFenHongBaoDetailBean.getData());
                hongbaogussdel.cleanAfterAddAllData(jiFenHongBaoDetailBean.getYoulike());
                mAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    //商品adapter
    private BaseAdapter createGoodsAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(goodsbanner)
                .injectHolderDelegate(goodsInfo)
                .injectHolderDelegate(tuwendel.addData(R.mipmap.icon_img_text))
                .injectHolderDelegate(imgdel)
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.baojia_title_item_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new BaseViewHolder<String>(itemView) {
                            @Override
                            protected void bindView(String o) {
                            }
                        };
                    }
                }.addData(""))
                .injectHolderDelegate(goodsgussdel)
        ;
        baseAdapter.setLayoutManager(recycle2);
        return baseAdapter;
    }


    //红包adapter
    private BaseAdapter createHongBaoAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(hongbaobanner)
                .injectHolderDelegate(hongbaoInfo)
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.baojia_title_item_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new BaseViewHolder<String>(itemView) {
                            @Override
                            protected void bindView(String o) {
                                View line = itemView.findViewById(R.id.line);
                                line.setVisibility(View.VISIBLE);
                            }
                        };
                    }
                }.addData(""))
                .injectHolderDelegate(hongbaogussdel)
        ;
        baseAdapter.setLayoutManager(recycle2);
        return baseAdapter;
    }

    //商品banner del
    CreateHolderDelegate<JiFenGoodsDetailBean> goodsbanner = new CreateHolderDelegate<JiFenGoodsDetailBean>() {
        @Override
        protected int onSpanSize() {
            return 2;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.baojia_banner_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new BannerHolder(itemView);
        }
    };

    //商品banner del
    CreateHolderDelegate<JiFenHongBaoDetailBean> hongbaobanner = new CreateHolderDelegate<JiFenHongBaoDetailBean>() {
        @Override
        protected int onSpanSize() {
            return 2;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.baojia_banner_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new HongbaoBannerHolder(itemView);
        }
    };

    //商品banner Holder
    class BannerHolder extends BaseViewHolder<JiFenGoodsDetailBean> {
        @BindView(R.id.banner)
        Banner banner;

        public BannerHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(JiFenGoodsDetailBean bean) {
            int w = ((Activity) mContext).getWindowManager().getDefaultDisplay().getWidth();
            int h = w;
            RelativeLayout.LayoutParams layoutParams = (RelativeLayout.LayoutParams) banner.getLayoutParams();
            layoutParams.width = w;
            layoutParams.height = h;
            banner.setLayoutParams(layoutParams);


            //设置banner
            banner.setImages(bean.getData().getTupian())
                    .setImageLoader(new GlideImageLoader())
                    .setIndicatorGravity(BannerConfig.CENTER)
                    .setDelayTime(2000)
                    .start();
        }
    }

    //红包banner Holder
    class HongbaoBannerHolder extends BaseViewHolder<JiFenHongBaoDetailBean> {
        @BindView(R.id.banner)
        Banner banner;

        public HongbaoBannerHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(JiFenHongBaoDetailBean bean) {
            int w = ((Activity) mContext).getWindowManager().getDefaultDisplay().getWidth();
            int h = w;
            RelativeLayout.LayoutParams layoutParams = (RelativeLayout.LayoutParams) banner.getLayoutParams();
            layoutParams.width = w;
            layoutParams.height = h;
            banner.setLayoutParams(layoutParams);

            //设置banner
            List list = new ArrayList<>();
            list.add(bean.getData().getImg());
            banner.setImages(list)
                    .setImageLoader(new GlideImageLoader())
                    .setIndicatorGravity(BannerConfig.CENTER)
                    .setDelayTime(2000)
                    .start();
        }
    }

    //商品info del
    CreateHolderDelegate<JiFenGoodsDetailBean.DataBean> goodsInfo = new CreateHolderDelegate<JiFenGoodsDetailBean.DataBean>() {
        @Override
        protected int onSpanSize() {
            return 2;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.baojia_info_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new BaoJiaInfoHolder(itemView);
        }
    };

    //商品信息Holder
    class BaoJiaInfoHolder extends BaseViewHolder<JiFenGoodsDetailBean.DataBean> {
        @BindView(R.id.tv_title_name)
        TextView tvTitleName;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_sale_num)
        TextView tvSaleNum;
        @BindView(R.id.tv_location)
        TextView tvLocation;
        @BindView(R.id.tv_tag)
        TextView tvtag;

        public BaoJiaInfoHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(JiFenGoodsDetailBean.DataBean bean) {
            tvTitleName.setText(bean.getName() + "");
            if (bean.getJiage() != null && !bean.getJiage().equals("0") && !bean.getJiage().equals("0.00")) {
                tvPrice.setText(bean.getJifen() + "积分+" + bean.getJiage() + "元");
            } else {
                tvPrice.setText(bean.getJifen() + "积分");
            }
            tvSaleNum.setText("已兑换 " + bean.getYiduinum() + " 单");
            tvLocation.setVisibility(View.GONE);
            tvtag.setVisibility(View.GONE);
        }
    }

    //红包info del
    CreateHolderDelegate<JiFenHongBaoDetailBean.DataBean> hongbaoInfo = new CreateHolderDelegate<JiFenHongBaoDetailBean.DataBean>() {
        @Override
        protected int onSpanSize() {
            return 2;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.baojia_info_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new HongBaoInfoHolder(itemView);
        }
    };

    //红包信息Holder
    class HongBaoInfoHolder extends BaseViewHolder<JiFenHongBaoDetailBean.DataBean> {
        @BindView(R.id.tv_title_name)
        TextView tvTitleName;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_sale_num)
        TextView tvSaleNum;
        @BindView(R.id.tv_location)
        TextView tvLocation;
        @BindView(R.id.tv_tag)
        TextView tvtag;

        public HongBaoInfoHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(JiFenHongBaoDetailBean.DataBean bean) {
            tvTitleName.setText(bean.getName() + "");
            tvPrice.setText(bean.getXuyaojifen() + "积分");
            tvSaleNum.setText("已兑换 " + bean.getLingqunum() + " 单");
            tvLocation.setVisibility(View.GONE);
            tvtag.setVisibility(View.GONE);
        }
    }

    //title del
    CreateHolderDelegate<Integer> tuwendel = new CreateHolderDelegate<Integer>() {
        @Override
        protected int onSpanSize() {
            return 2;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.baojia_line_view_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new TitleHolder(itemView);
        }
    };

    //title Holder
    class TitleHolder extends BaseViewHolder<Integer> {
        @BindView(R.id.img_title)
        ImageView imageView;

        public TitleHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(Integer s) {
            imageView.setBackgroundResource(s.intValue());
        }
    }

    //图文详情img del
    CreateHolderDelegate<JiFenGoodsDetailBean.DataBean.PicsBean> imgdel = new CreateHolderDelegate<JiFenGoodsDetailBean.DataBean.PicsBean>() {
        @Override
        protected int onSpanSize() {
            return 2;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.baojia_img_item_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new ImgHolder(itemView);
        }
    };

    //图文详情img Holder
    class ImgHolder extends BaseViewHolder<JiFenGoodsDetailBean.DataBean.PicsBean> {
        @BindView(R.id.image)
        ImageView imageView;

        public ImgHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    XXPermissions.with(JiFenGoodsDetailActivity.this)
                            .permission(Permission.MANAGE_EXTERNAL_STORAGE)
                            .request(new OnPermissionCallback() {
                                @Override
                                public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                                    if (!allGranted){
                                        FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(JiFenGoodsDetailActivity.this);
                                        commonPopWindow.showAtLocation(imageView, Gravity.CENTER, 0, 0);
                                        commonPopWindow.getTitText().setText(getResources().getString(R.string.per_photo));
                                        commonPopWindow.getCancel().setOnClickListener(view -> {
                                            commonPopWindow.dismiss();
                                            FullScreenUtil.showFullScreenDialog(imageView.getContext(), getPosition() - 5,url);
                                        });
                                        commonPopWindow.getSure().setOnClickListener(view -> {
                                            commonPopWindow.dismiss();
                                        });

                                    }else {
                                        FullScreenUtil.showFullScreenDialog(imageView.getContext(), getPosition() - 5,url);
                                    }
                                }

                                @Override
                                public void onDenied(@NonNull List<String> permissions, boolean doNotAskAgain) {
                                    if (doNotAskAgain) {
                                        ToastUtils.showToast(JiFenGoodsDetailActivity.this,"被永久拒绝授权，请手动存储权限");
                                        // 如果是被永久拒绝就跳转到应用权限系统设置页面
                                        XXPermissions.startPermissionActivity(JiFenGoodsDetailActivity.this, permissions);
                                    } else {
                                        ToastUtils.showToast(JiFenGoodsDetailActivity.this,"获取存储权限权限失败");
                                    }
                                }
                            });
                }
            });
        }

        @Override
        protected void bindView(JiFenGoodsDetailBean.DataBean.PicsBean bean) {
            GlideLoad.GlideLoadImg2(bean.getImgurl(), imageView);
        }
    }

    CreateHolderDelegate<JiFenGoodsDetailBean.YoulikeBean> goodsgussdel = new CreateHolderDelegate<JiFenGoodsDetailBean.YoulikeBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.item_mall_index_works_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new GussULikeHolder(itemView);
        }
    };

    //猜你喜欢 商品 Holder
    class GussULikeHolder extends BaseViewHolder<JiFenGoodsDetailBean.YoulikeBean> {
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
        @BindView(R.id.ll_content)
        LinearLayout ll_content;

        private int id;//报价id

        public GussULikeHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, JiFenGoodsDetailActivity.class);
                    intent.putExtra("goods_id", id);
                    intent.putExtra("type", 0);
                    mContext.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(JiFenGoodsDetailBean.YoulikeBean youlikeBean) {
            int w = ((Activity) mContext).getWindowManager().getDefaultDisplay().getWidth();
            int h = w;
            RelativeLayout.LayoutParams layoutParams = (RelativeLayout.LayoutParams) ivImg.getLayoutParams();
            layoutParams.width = w/2;
            layoutParams.height = h/2;
            ivImg.setLayoutParams(layoutParams);

            id = youlikeBean.getId();
            tvContext.setVisibility(View.GONE);
            tvSaleCount.setVisibility(View.VISIBLE);
            tvSeeCount.setVisibility(View.GONE);
            tvSaleCount.setText("已兑 " + youlikeBean.getYiduinum());

            if (youlikeBean.getJiage() != null && !youlikeBean.getJiage().equals("0") && !youlikeBean.getJiage().equals("0.00")) {
                tvPrice.setText(youlikeBean.getJifen() + "积分+" + youlikeBean.getJiage() + "元");
            } else {
                tvPrice.setText(youlikeBean.getJifen() + "积分");
            }
            tvTitle.setText("" + youlikeBean.getName());
            GlideLoad.GlideLoadImg2(youlikeBean.getTupian(), ivImg);
        }
    }

    CreateHolderDelegate<JiFenHongBaoDetailBean.YoulikeBean> hongbaogussdel = new CreateHolderDelegate<JiFenHongBaoDetailBean.YoulikeBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.item_mall_index_works_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new HongBaoGussULikeHolder(itemView);
        }
    };

    //猜你喜欢 商品 Holder
    class HongBaoGussULikeHolder extends BaseViewHolder<JiFenHongBaoDetailBean.YoulikeBean> {
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
        private int id;//报价id

        public HongBaoGussULikeHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, JiFenGoodsDetailActivity.class);
                    intent.putExtra("goods_id", id);
                    intent.putExtra("type", 1);
                    mContext.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(JiFenHongBaoDetailBean.YoulikeBean youlikeBean) {
            int w = ((Activity) mContext).getWindowManager().getDefaultDisplay().getWidth();
            int h = w;
            RelativeLayout.LayoutParams layoutParams = (RelativeLayout.LayoutParams) ivImg.getLayoutParams();
            layoutParams.width = w/2;
            layoutParams.height = h/2;
            ivImg.setLayoutParams(layoutParams);

            id = youlikeBean.getId();
            tvContext.setVisibility(View.GONE);
            tvSaleCount.setVisibility(View.VISIBLE);
            tvSeeCount.setVisibility(View.GONE);
            tvSaleCount.setText("已兑 " + youlikeBean.getLingqunum());
            tvPrice.setText(youlikeBean.getXuyaojifen() + "积分");
            tvTitle.setText("" + youlikeBean.getName());
            GlideLoad.GlideLoadImg2(youlikeBean.getImg(), ivImg);
        }
    }

    //提醒dialog
    private void createDel(String title, String content, String canleNam, String sureName, final int order_id, final String price) {
        final AskDialog dialog = new AskDialog(mContext, JiFenGoodsDetailActivity.this);
        dialog.setTitle(title);
        dialog.setMessage(content);
        dialog.setCancleListener(canleNam, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener(sureName, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (inputPassWordDialog == null) {
                    inputPassWordDialog = createDialog(false);
                    inputPassWordDialog.setOrder_id(order_id);
                    inputPassWordDialog.setJiFen(true);
                    inputPassWordDialog.setPrice(price);
                    inputPassWordDialog.isShow();
                } else {
                    inputPassWordDialog.clearInput();
                    inputPassWordDialog.setOrder_id(order_id);
                    inputPassWordDialog.setJiFen(true);
                    inputPassWordDialog.setPrice(price);
                    inputPassWordDialog.isShow();
                }

            }
        });
        dialog.show();
    }

    //初始化余额支付对话框
    private InputPassWordDialog createDialog(boolean isWeiKuan) {
        inputPassWordDialog = new InputPassWordDialog(mContext, R.style.MyDialog, isWeiKuan, 8);
        inputPassWordDialog.setRefreshNum(new InputPassWordDialog.RefreshNum() {
            @Override
            public void onRefresh() {
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }
        });
        inputPassWordDialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
            @Override
            public void onDismiss(DialogInterface dialogInterface) {
                // NToast.show("订单生成后已扣除对应积分，请尽快完成兑换订单哦~");
                //finish();
            }
        });
        return inputPassWordDialog;
    }
}

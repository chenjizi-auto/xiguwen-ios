package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
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
import android.widget.Button;
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
import com.linzi.xiguwen.bean.OffoerDetailsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginHepler;
import com.linzi.xiguwen.utils.LoginHeplerListener;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.dialog.AddCartDialog;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.basic.PictureSelector;
import com.luck.picture.lib.entity.LocalMedia;
import com.luck.picture.lib.interfaces.OnExternalPreviewEventListener;
import com.luck.picture.lib.utils.ToastUtils;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;


/**
 * Created by pc on 2018/3/30.
 */

public class NewBaijiaDetailsActivity extends AppCompatActivity implements LoginHeplerListener {
    @BindView(R.id.recycle2)
    RecyclerView recycle2;
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
    @BindView(R.id.iv_care)
    ImageView ivCare;
    @BindView(R.id.ll_parent)
    RelativeLayout llParent;
    @BindView(R.id.tv_cart_num)
    TextView tvCartNum;

    private Context mContext;
    private BaseAdapter mAdapter;
    private int offoer_id;//报价id
    private OffoerDetailsBean bean;
    private ArrayList<String> url;//图片浏览用
    private String address;//地址信息
    private int iscared;
    private int shop_id;
    private String timeStr;
    private AddCartDialog cartDialog;
    private int baojia_id;



    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        NToast.log("oncreate",getClass().getCanonicalName());
        getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
        StatusBarUtil.setStatusBarColor(NewBaijiaDetailsActivity.this, R.color.trans);
        StatusBarUtil.setNavigationBarColor(NewBaijiaDetailsActivity.this, R.color.white);
        setContentView(R.layout.new_activity_baijia_details);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        mContext = this;
        offoer_id = getIntent().getIntExtra("offoer_id", -1);
        initView();
        getData();
        getCartNum();
    }

    private void initView() {
        tvTitle.setText("报价详情");

        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(NewBaijiaDetailsActivity.this));
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
                    ivToTop.setVisibility(View.VISIBLE);
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
                    ivToTop.setVisibility(View.GONE);
                }
            }
        });

        ivToTop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                recycle2.scrollToPosition(0);
            }
        });

        llBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

    }

    private void getData() {
        LoadDialog.showDialog(mContext);
        ApiManager.getOfferDetailsBean(offoer_id, new OnRequestFinish<BaseBean<OffoerDetailsBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<OffoerDetailsBean> data) {
                bean = data.getData();
                baojia_id = bean.getBaojia().getQuotationid();
                afterView(bean);
                createAddCartPop();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void afterView(OffoerDetailsBean bean) {
        shop_id = bean.getUser().getUserid();
        address = bean.getUser().getAddr();
        iscared = bean.getUserf();
        if (iscared == 1) {
            ivCare.setBackgroundResource(R.mipmap.icon_cared2);
        } else {
            ivCare.setBackgroundResource(R.mipmap.icon_care2);
        }

        if (bean.getBaojia().getImglist() != null && bean.getBaojia().getImglist().size() > 0) {
            List<OffoerDetailsBean.BaojiaBean.PicsBean> list = new ArrayList<>();
            for (int i = 0; i < bean.getBaojia().getImglist().size(); i++) {//包装图片列表
                OffoerDetailsBean.BaojiaBean.PicsBean picsBean = new OffoerDetailsBean.BaojiaBean.PicsBean();
                picsBean.setImgurl(bean.getBaojia().getImglist().get(i));
                list.add(picsBean);
            }
            bean.getBaojia().setPicsBean(list);
            url = (ArrayList<String>) bean.getBaojia().getImglist();
        } else {
            url = new ArrayList<>();
        }

        mAdapter = createAdapter(bean);
        recycle2.setAdapter(mAdapter);
    }

    @OnClick({R.id.iv_chat, R.id.iv_call_phone, R.id.iv_care, R.id.ll_buy, R.id.ll_add_in_cart, R.id.iv_cart, R.id.ll_right})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.iv_chat:
                LoginHepler.LoginHepler(mContext, 666, true, this);
                break;
            case R.id.iv_call_phone:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    break;
                }
                callUser();
                break;
            case R.id.iv_care:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    break;
                }
                if (iscared == 1) {
                    cancelCare();
                } else {
                    careShop();
                }
                break;
            case R.id.ll_buy:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    break;
                }
                cartDialog.setType(1);
                if (cartDialog.isShowing()) {
                    cartDialog.dismiss();
                } else {
                    cartDialog.setShowWithView(llParent);
                }
                break;
            case R.id.ll_add_in_cart:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    break;
                }
                cartDialog.setType(0);
                if (cartDialog.isShowing()) {
                    cartDialog.dismiss();
                } else {
                    cartDialog.setShowWithView(llParent);
                }
                break;
            case R.id.iv_cart:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    break;
                }
                Intent intent = new Intent(mContext, CartActivity.class);
                mContext.startActivity(intent);
                break;
            case R.id.ll_right:
                GetShareContentUtil.getContent(NewBaijiaDetailsActivity.this, offoer_id, 2, -1);
                break;
        }
    }

    //创建加入购物车
    private void createAddCartPop() {
        cartDialog = new AddCartDialog(mContext, bean.getBaojia(), llParent);
        cartDialog.setRefreshNum(new AddCartDialog.RefreshNum() {
            @Override
            public void onRefresh(boolean isRefresh, String baojiadate, int baojiaid, int baojiatime, int paytype, String quantity,String agreedPrice) {
                if (isRefresh) {
                    getCartNum();
                    EventBusUtil.sendEvent(new Event(EventCode.REFRESH_CART));
                } else {
                    Intent intent = new Intent(mContext, BuyNowSureOrderActivity.class);
                    intent.putExtra("intentType", 0);
                    intent.putExtra("baojiadate", baojiadate);
                    intent.putExtra("baojiaid", baojiaid);
                    intent.putExtra("baojiatime", baojiatime);
                    intent.putExtra("paytype", paytype);
                    intent.putExtra("quantity", quantity);
                    intent.putExtra("agreedPrice", agreedPrice);
                    mContext.startActivity(intent);
                }
            }
        });
    }

    //关注报价
    private void careShop() {
        LoadDialog.showDialog(mContext);
        ApiManager.addBJcare(baojia_id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                if (data.getCode() == 0) {
                    iscared = 1;
                    ivCare.setBackgroundResource(R.mipmap.icon_cared2);
                    NToast.show(data.getMessage());
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    //取消关注报价
    private void cancelCare() {
        LoadDialog.showDialog(mContext);
        ApiManager.delBJcare(baojia_id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                if (data.getCode() == 0) {
                    iscared = 0;
                    ivCare.setBackgroundResource(R.mipmap.icon_care2);
                    NToast.show(data.getMessage());
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    //联系商家
    private void callUser() {
        if (bean.getUser().getMobile() != null) {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + bean.getUser().getMobile()));
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        } else {
            NToast.show("抱歉，暂时没有该商家的联系方式！");
        }
    }

    @Override
    public void loginOpinion(int code) {
        switch (code) {
            case 666:
//                NimUIKit.startP2PSession(this, "user" + bean.getUser().getUserid());
                break;
        }
    }

    //banner Holder
    class BannerHolder extends BaseViewHolder<OffoerDetailsBean.BaojiaBean> {
        @BindView(R.id.banner)
        Banner banner;

        public BannerHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(OffoerDetailsBean.BaojiaBean bean) {
            //设置banner
            banner.setImages(bean.getImglist())
                    .setImageLoader(new GlideImageLoader())
                    .setIndicatorGravity(BannerConfig.CENTER)
                    .setDelayTime(2000)
                    .start();
        }
    }

    //报价信息Holder
    class BaoJiaInfoHolder extends BaseViewHolder<OffoerDetailsBean.BaojiaBean> {
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
        protected void bindView(OffoerDetailsBean.BaojiaBean bean) {
            tvTitleName.setText(bean.getName() + "");
            tvPrice.setText("￥" + bean.getPrice() + "");
            tvSaleNum.setText("已售 " + bean.getNum() + " 单");
            tvLocation.setText(address + "");
            tvtag.setText("定金" + bean.getTemporarypay() + "元，用券可抵扣" + bean.getDeductible() + "元");
        }
    }

    //商家信息 Holder
    class UserInfoHolder extends BaseViewHolder<OffoerDetailsBean.UserBean> {
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_user_name)
        TextView tvUserName;
        @BindView(R.id.tv_zhiwu)
        TextView tvZhiwu;
        @BindView(R.id.iv_rz_cx)
        ImageView ivRzCx;
        @BindView(R.id.iv_rz_pt)
        ImageView ivRzPt;
        @BindView(R.id.iv_rz_xy)
        ImageView ivRzXy;
        @BindView(R.id.tv_haopinlv)
        TextView tvHaopinlv;
        @BindView(R.id.tv_pinglun_count)
        TextView tvPinglunCount;
        @BindView(R.id.tv_fans)
        TextView tvFans;
        @BindView(R.id.bt_enter_mall)
        Button btEnterMall;
        @BindView(R.id.iv_rz_sm)
        ImageView ivRzSm;

        public UserInfoHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(OffoerDetailsBean.UserBean userBean) {
            btEnterMall.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", shop_id);
                    mContext.startActivity(intent);
                }
            });

            GlideLoad.GlideLoadImg2(bean.getUser().getHead(), ivHead);
            tvUserName.setText(bean.getUser().getNickname() + "");
            tvZhiwu.setText(bean.getUser().getOccupation() + "");
            tvHaopinlv.setText(bean.getUser().getGoodscore() + "");
            tvPinglunCount.setText(bean.getUser().getEvaluate() + "");
            tvFans.setText(bean.getUser().getFans() + "");
            ivRzXy.setVisibility(View.VISIBLE);
            switch (bean.getUser().getXueyuan()) {
                case 6:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan1);
                    break;
                case 7:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan2);
                    break;
                case 8:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan3);
                    break;
                case 9:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan4);
                    break;
                case 10:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan5);
                    break;
                case 11:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan6);
                    break;
                case 12:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan7);
                    break;
                case 13:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xing1);
                    break;
                case 14:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xing2);
                    break;
                case 15:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xing3);
                    break;
                case 16:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xing4);
                    break;
                case 17:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xing5);
                    break;
                case 18:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xing6);
                    break;
                case 19:
                    ivRzXy.setBackgroundResource(R.mipmap.icon_xing7);
                    break;
                default:
                    ivRzXy.setVisibility(View.GONE);
                    break;
            }


            if ((bean.getUser().getShiming() == 1)) {
                ivRzSm.setVisibility(View.VISIBLE);
            } else {
                ivRzSm.setVisibility(View.GONE);
            }

            if (bean.getUser().getSincerity() == 1) {
                ivRzCx.setVisibility(View.VISIBLE);
            } else {
                ivRzCx.setVisibility(View.GONE);
            }

            if (bean.getUser().getPlatform() == 1) {
                ivRzPt.setVisibility(View.VISIBLE);
            } else {
                ivRzPt.setVisibility(View.GONE);
            }
        }
    }

    //title Delegate
    class TitleDelegate extends CreateHolderDelegate<Integer> {
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
    }

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

    //图文详情img Holder
    class ImgHolder extends BaseViewHolder<OffoerDetailsBean.BaojiaBean.PicsBean> {
        @BindView(R.id.image)
        ImageView imageView;

        public ImgHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    XXPermissions.with(NewBaijiaDetailsActivity.this)
                            .permission(Permission.CAMERA)
                            .request(new OnPermissionCallback() {
                                @Override
                                public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                                    if (!allGranted){
                                        FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(NewBaijiaDetailsActivity.this);
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
                                        ToastUtils.showToast(NewBaijiaDetailsActivity.this,"被永久拒绝授权，请手动存储权限");
                                        // 如果是被永久拒绝就跳转到应用权限系统设置页面
                                        XXPermissions.startPermissionActivity(NewBaijiaDetailsActivity.this, permissions);
                                    } else {
                                        ToastUtils.showToast(NewBaijiaDetailsActivity.this,"获取存储权限失败");
                                    }
                                }
                            });
                    
                }
            });
        }

        @Override
        protected void bindView(OffoerDetailsBean.BaojiaBean.PicsBean bean) {
            GlideLoad.GlideLoadImgRectangleNoCenterCrop(bean.getImgurl(), imageView);
        }
    }

    //猜你喜欢 Holder
    class GussULikeHolder extends BaseViewHolder<OffoerDetailsBean.YoulikeBean> {
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

        public GussULikeHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, NewBaijiaDetailsActivity.class);
                    intent.putExtra("offoer_id", id);
                    mContext.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(OffoerDetailsBean.YoulikeBean youlikeBean) {
            id = youlikeBean.getQuotationid();
            tvContext.setVisibility(View.GONE);
            tvSaleCount.setVisibility(View.VISIBLE);
            tvSeeCount.setVisibility(View.GONE);
            tvSaleCount.setText("已售 " + youlikeBean.getNum());
            tvPrice.setText(Constans.RMB + youlikeBean.getPrice());
            tvTitle.setText("" + youlikeBean.getName());
            GlideLoad.GlideLoadImg2(youlikeBean.getImglist().get(0), ivImg);
        }
    }

    //全局adapter
    private BaseAdapter createAdapter(OffoerDetailsBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(new CreateHolderDelegate<OffoerDetailsBean.BaojiaBean>() {
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
                }.addData(bean.getBaojia()))

                .injectHolderDelegate(new CreateHolderDelegate<OffoerDetailsBean.BaojiaBean>() {
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
                }.addData(bean.getBaojia()))

                .injectHolderDelegate(new CreateHolderDelegate<OffoerDetailsBean.UserBean>() {

                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.baojia_userinfo_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new UserInfoHolder(itemView);
                    }
                }.addData(bean.getUser()))

                .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_img_text))

                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.baojia_textview_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {

                        return new BaseViewHolder<String>(itemView) {
                            @Override
                            protected void bindView(String o) {
                                ((TextView) itemView.findViewById(R.id.tv_content)).setText(o);
                            }
                        };
                    }
                }.addData(bean.getBaojia().getContent()))

                .injectHolderDelegate(new CreateHolderDelegate<OffoerDetailsBean.BaojiaBean.PicsBean>() {
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
                }.addAllData(bean.getBaojia().getPicsBean()))

//                .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_img_text))

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

                .injectHolderDelegate(new CreateHolderDelegate<OffoerDetailsBean.YoulikeBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_mall_index_works_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new GussULikeHolder(itemView);
                    }
                }.addAllData(bean.getYoulike()));
        baseAdapter.setLayoutManager(recycle2);
        return baseAdapter;
    }

    //获取购物车数量
    public void getCartNum() {
        ApiManager.getCartNum(1, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {

            }

            @Override
            public void onSuccess(BaseBean data) {
                tvCartNum.setVisibility(View.VISIBLE);
                tvCartNum.setText(data.getData() + "");
            }

            @Override
            public void onError(Exception ex) {
                tvCartNum.setVisibility(View.GONE);
            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
        EventBusUtil.unregister(this);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.REFRESH_CART_NUM:
                    getCartNum();
                    break;
            }
        } catch (Exception e) {
        }

    }
}

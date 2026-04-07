package com.linzi.xiguwen.ui;

import android.animation.ObjectAnimator;
import android.animation.ValueAnimator;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Rect;
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

import com.alibaba.fastjson.JSONObject;
import com.hedgehog.ratingbar.RatingBar;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.jaeger.ninegridimageview.ItemImageClickListener;
import com.jaeger.ninegridimageview.NineGridImageView;
import com.jaeger.ninegridimageview.NineGridImageViewAdapter;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.NewCaseBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginHepler;
import com.linzi.xiguwen.utils.LoginHeplerListener;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.utils.ToastUtils;
import com.previewlibrary.GPreviewBuilder;
import com.linzi.xiguwen.preview.PreviewUtil;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;
import org.xutils.common.Callback;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/3/31.
 */

public class NewExampleDetailsActivity extends AppCompatActivity implements LoginHeplerListener {
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
    @BindView(R.id.tv_cart_num)
    TextView tvCartNum;

    private Context mContext;
    private BaseAdapter mAdapter;
    private int caseid;//案例id
    private NewCaseBean bean;
    private ArrayList<String> url;//图片浏览用
    private int iscared;
    private int shop_id;

    private ImageView dropZoomView;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(NewExampleDetailsActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(NewExampleDetailsActivity.this, R.color.white);
        }
        setContentView(R.layout.new_activity_example_details);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        mContext = this;
        caseid = getIntent().getIntExtra("caseid", -1);
        initView();
        getData();
        getCartNum();
    }

    private void initView() {
        tvTitle.setText("案例详情");

        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(NewExampleDetailsActivity.this));
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
        ApiManager.getCaseDetails(caseid + "", new OnRequestFinish<BaseBean<NewCaseBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<NewCaseBean> data) {
                bean = data.getData();
                afterView(bean);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void afterView(NewCaseBean bean) {
        shop_id = bean.getUser().getUserid();
        iscared = bean.getUserf();
        if (iscared == 1) {
            ivCare.setBackgroundResource(R.mipmap.icon_cared2);
        } else {
            ivCare.setBackgroundResource(R.mipmap.icon_care2);
        }

        for (int i = 0; i < bean.getPinglun().size(); i++) {
            List<NewCaseBean.PinglunBean.PicsBean> list = new ArrayList<>();
            for (int j = 0; j < bean.getPinglun().get(i).getCommphoto().size(); j++) {
                NewCaseBean.PinglunBean.PicsBean picsBean = new NewCaseBean.PinglunBean.PicsBean();
                picsBean.setUrl(bean.getPinglun().get(i).getCommphoto().get(j));
                list.add(picsBean);
            }
            bean.getPinglun().get(i).setPics(list);
        }

        url = new ArrayList<>();
        if (bean.getInfo().getPhotourl() != null && bean.getInfo().getPhotourl().size() > 0) {
            for (int i = 0; i < bean.getInfo().getPhotourl().size(); i++) {
                url.add(bean.getInfo().getPhotourl().get(i).getPhotourl());
            }
        }

        mAdapter = createAdapter(bean);
        recycle2.setAdapter(mAdapter);
        //OverScrollDecoratorHelper.setUpOverScroll(recycle2, OverScrollDecoratorHelper.ORIENTATION_VERTICAL);
        //new VerticalOverScrollBounceEffectDecorator(new RecyclerViewOverScrollDecorAdapter(recycle2));


//        IOverScrollDecor scrollDecor = new VerticalOverScrollBounceEffectDecorator(new RecyclerViewOverScrollDecorAdapter(recycle2));
//
//        // Over-scroll listeners are applied here via the mVertOverScrollEffect explicitly.
//        scrollDecor.setOverScrollUpdateListener(new IOverScrollUpdateListener() {
//            @Override
//            public void onOverScrollUpdate(IOverScrollDecor decor, int state, float offset) {
//                setZoom(offset);
//            }
//        });
//        scrollDecor.setOverScrollStateListener(new IOverScrollStateListener() {
//
//            @Override
//            public void onOverScrollStateChange(IOverScrollDecor decor, int oldState, int newState) {
//                if (newState == STATE_DRAG_START_SIDE) {
//                    setZoom(newState);
//                } else if (newState == STATE_DRAG_END_SIDE) {
//                    //mVertScrollMeasure.setTextColor(mDragColorBottom);
//                } else if (newState == STATE_BOUNCE_BACK) {
//                    replyImage();
//                } else {
//                    // mVertScrollMeasure.setTextColor(mClearColor);
//                }
//            }
//        });
    }

    //缩放
    public void setZoom(float s) {
        int dropZoomViewHeight = dropZoomView.getHeight();
        int dropZoomViewWidth = dropZoomView.getWidth();
        if (dropZoomViewHeight <= 0 || dropZoomViewWidth <= 0) {
            return;
        }
        ViewGroup.LayoutParams lp = dropZoomView.getLayoutParams();
        lp.width = (int) (dropZoomViewWidth + s);
        lp.height = (int) (dropZoomViewHeight * ((dropZoomViewWidth + s) / dropZoomViewWidth));
        dropZoomView.setLayoutParams(lp);
    }

    // 回弹动画 (使用了属性动画)
    public void replyImage() {
        int dropZoomViewWidth = dropZoomView.getWidth();
        final float distance = dropZoomView.getMeasuredWidth() - dropZoomViewWidth;

        // 设置动画
        ValueAnimator anim = ObjectAnimator.ofFloat(0.0F, 1.0F).setDuration((long) (distance * 0.7));

        anim.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
            @Override
            public void onAnimationUpdate(ValueAnimator animation) {
                float cVal = (Float) animation.getAnimatedValue();
                setZoom(distance - ((distance) * cVal));
            }
        });
        anim.start();

    }

    @OnClick({R.id.iv_chat, R.id.iv_call_phone, R.id.iv_care, R.id.ll_yuyue, R.id.iv_cart, R.id.ll_right})
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
                if (bean.getUser().getMobile() != null) {
                    Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + bean.getUser().getMobile()));
                    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    startActivity(intent);
                } else {
                    NToast.show("抱歉，暂时没有该商家的联系方式！");
                }
                break;
            case R.id.iv_care:
                if (iscared == 1) {
                    delCare(caseid);
                } else {
                    addCare(caseid);
                }
                break;
            case R.id.ll_yuyue:
                startActivity(new Intent(mContext, GetSuggestActivity.class));//免费获取方案
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
                share();
                break;
        }
    }

    private void share() {
        GetShareContentUtil.getContent(NewExampleDetailsActivity.this, caseid, 4, -1);
    }

    @Override
    public void loginOpinion(int code) {
        switch (code) {
            case 666:
//                NimUIKit.startP2PSession(this, "user" + bean.getUser().getUserid());
                break;
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

    //head Holder
    class HeadViewHolder extends BaseViewHolder<NewCaseBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_example_title)
        TextView tvExampleTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_address)
        TextView tvAddress;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.bt_enter_mall)
        Button btEnterMall;


        public HeadViewHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(NewCaseBean bean) {
            btEnterMall.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, CheckCaseDetailsActivity.class);//查看明细、
                    intent.putExtra("case_id", caseid);
                    startActivity(intent);
                }
            });
            tvExampleTitle.setText("" + bean.getInfo().getTitle());
            tvTime.setText("婚礼时间：" + bean.getInfo().getWeddingtime());
            tvAddress.setText("婚礼地址：" + bean.getInfo().getWeddingplace());
            tvPrice.setText("￥" + bean.getInfo().getWeddingexpenses());
            GlideLoad.GlideLoadImg(mContext, bean.getInfo().getWeddingcover(), ivImg);
            dropZoomView = ivImg;

//            itemView.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
//                @Override
//                public void onGlobalLayout() {
//                    recycle2.setHeardView(ivImg);
//                    itemView.getViewTreeObserver().removeOnGlobalLayoutListener(this);
//                }
//            });
        }
    }

    //img Holder
    class ImgHolder extends BaseViewHolder<NewCaseBean.InfoBean.PhotourlBean> {
        @BindView(R.id.image)
        ImageView imageView;

        public ImgHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(view -> XXPermissions.with(NewExampleDetailsActivity.this)
                    .permission(Permission.CAMERA)
                    .request(new OnPermissionCallback() {
                        @Override
                        public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                            if (!allGranted){
                                FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(NewExampleDetailsActivity.this);
                                commonPopWindow.showAtLocation(imageView, Gravity.CENTER, 0, 0);
                                commonPopWindow.getTitText().setText(getResources().getString(R.string.per_photo));
                                commonPopWindow.getCancel().setOnClickListener(view -> {
                                    commonPopWindow.dismiss();
                                    FullScreenUtil.showFullScreenDialog(imageView.getContext(), getPosition() - 2,url);
                                });
                                commonPopWindow.getSure().setOnClickListener(view -> {
                                    commonPopWindow.dismiss();
                                });

                            }else {
                                FullScreenUtil.showFullScreenDialog(imageView.getContext(), getPosition() - 2,url);
                            }
                        }

                        @Override
                        public void onDenied(@NonNull List<String> permissions, boolean doNotAskAgain) {
                            if (doNotAskAgain) {
                                ToastUtils.showToast(NewExampleDetailsActivity.this,"被永久拒绝授权，请手动存储权限");
                                // 如果是被永久拒绝就跳转到应用权限系统设置页面
                                XXPermissions.startPermissionActivity(NewExampleDetailsActivity.this, permissions);
                            } else {
                                ToastUtils.showToast(NewExampleDetailsActivity.this,"获取存储权限失败");
                            }
                        }
                    }));
        }

        @Override
        protected void bindView(NewCaseBean.InfoBean.PhotourlBean bean) {
            GlideLoad.GlideLoadImgRectangleNoCenterCrop(bean.getPhotourl(), imageView);
        }
    }

    //商家信息 Holder
    class UserInfoHolder extends BaseViewHolder<NewCaseBean.UserBean> {
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
        @BindView(R.id.iv_rz_sm)
        ImageView ivRzSm;
        @BindView(R.id.tv_haopinlv)
        TextView tvHaopinlv;
        @BindView(R.id.tv_pinglun_count)
        TextView tvPinglunCount;
        @BindView(R.id.tv_fans)
        TextView tvFans;
        @BindView(R.id.bt_enter_mall)
        Button btEnterMall;

        public UserInfoHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(NewCaseBean.UserBean userBean) {
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

    //推荐团队 Holder
    class TeamHolder extends BaseViewHolder<NewCaseBean.TeamBean> {
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.bt_price)
        Button btPrice;

        public TeamHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(NewCaseBean.TeamBean teamBean) {
            GlideLoad.GlideLoadCircle(mContext, teamBean.getHead(), ivHead);
            tvName.setText("" + teamBean.getNickname());
            tvZhiwei.setText("" + teamBean.getOccupationid());
            btPrice.setText(Constans.RMB + teamBean.getZuidiqijia() + "起");
        }
    }

    //评价Holder
    class PingJiaHolder extends BaseViewHolder<NewCaseBean.PinglunBean> {
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
        protected void bindView(NewCaseBean.PinglunBean pinglunBean) {
            GlideLoad.GlideLoadCircle(pinglunBean.getTouxiang(), ivHead);
            tvName.setText("" + pinglunBean.getName());
            tvTime.setText("" + pinglunBean.getSsj());
            ratingbar.setStar(pinglunBean.getPingfen());
            tvStarCount.setText(pinglunBean.getPingfen() + "分");
            tvContext.setText(pinglunBean.getComment());
            grid_image.setAdapter(mAdapter);
            grid_image.setImagesData(pinglunBean.getPics());
            grid_image.setItemImageClickListener(new ItemImageClickListener<NewCaseBean.PinglunBean.PicsBean>() {
                @Override
                public void onItemImageClick(Context context, ImageView imageView, int index, List<NewCaseBean.PinglunBean.PicsBean> list) {
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
        private void computeBoundsBackward(List<NewCaseBean.PinglunBean.PicsBean> list) {
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

        private NineGridImageViewAdapter<NewCaseBean.PinglunBean.PicsBean> mAdapter = new NineGridImageViewAdapter<NewCaseBean.PinglunBean.PicsBean>() {
            @Override
            protected void onDisplayImage(Context context, ImageView imageView, NewCaseBean.PinglunBean.PicsBean s) {
                GlideLoad.GlideLoadImg2(s.getUrl(), imageView);
            }

            @Override
            protected ImageView generateImageView(Context context) {
                return super.generateImageView(context);
            }

            @Override
            protected void onItemImageClick(Context context, ImageView imageView, int index, List<NewCaseBean.PinglunBean.PicsBean> list) {
                //  Toast.makeText(context, "image position is " + index, Toast.LENGTH_SHORT).show();
            }
        };
    }

    //案例Holder
    class AnliHolder extends BaseViewHolder<NewCaseBean.GdanliBean> {
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
                    Intent intent = new Intent(mContext, NewExampleDetailsActivity.class);
                    intent.putExtra("caseid", casrid);
                    mContext.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(NewCaseBean.GdanliBean zuopingBean) {
            tvContext.setVisibility(View.VISIBLE);
            tvSaleCount.setVisibility(View.GONE);
            tvSeeCount.setVisibility(View.VISIBLE);
            tvContext.setText("" + zuopingBean.getWeddingdescribe());
            tvSeeCount.setText("" + zuopingBean.getClicked());
            GlideLoad.GlideLoadImg(zuopingBean.getWeddingcover(), ivImg);
            tvTitle.setText("" + zuopingBean.getTitle());
            tvPrice.setText(Constans.RMB + zuopingBean.getWeddingexpenses() + "");
            casrid = zuopingBean.getId();
        }
    }

    private BaseAdapter createAdapter(NewCaseBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(new CreateHolderDelegate<NewCaseBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 6;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.example_head_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new HeadViewHolder(itemView);
                    }
                }.cleanAfterAddData(bean))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 6;
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
                }.cleanAfterAddData(bean.getInfo().getWeddingdescribe()))
                .injectHolderDelegate(new CreateHolderDelegate<NewCaseBean.InfoBean.PhotourlBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 6;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.baojia_img_item_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new ImgHolder(itemView);
                    }
                }.cleanAfterAddAllData(bean.getInfo().getPhotourl()))
                .injectHolderDelegate(new CreateHolderDelegate<NewCaseBean.UserBean>() {

                    @Override
                    protected int onSpanSize() {
                        return 6;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.baojia_userinfo_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new UserInfoHolder(itemView);
                    }
                }.cleanAfterAddData(bean.getUser()))
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
                }.addData(""))//分割线View
                .injectHolderDelegate(new TitleDelegate() {
                    @Override
                    protected int onSpanSize() {
                        return 6;
                    }
                }.cleanAfterAddData("推荐团队"))

                .injectHolderDelegate(new CreateHolderDelegate<NewCaseBean.TeamBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_tuijian_team_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new TeamHolder(itemView);
                    }
                }.cleanAfterAddAllData(bean.getTeam()))
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
                }.addData(""))//分割线View
                .injectHolderDelegate(new TitleDelegate() {
                    @Override
                    protected int onSpanSize() {
                        return 6;
                    }
                }.cleanAfterAddData("用户评价（" + bean.getPinglunshu() + "）"))
                .injectHolderDelegate(new CreateHolderDelegate<NewCaseBean.PinglunBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 6;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_pingjia_item;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new PingJiaHolder(itemView);
                    }
                }.cleanAfterAddAllData(bean.getPinglun()))
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
                }.addData(""))//分割线View
                .injectHolderDelegate(new TitleDelegate() {
                    @Override
                    protected int onSpanSize() {
                        return 6;
                    }
                }.cleanAfterAddData("商家其他案例（" + bean.getGdanli().size() + "）"))

                .injectHolderDelegate(new CreateHolderDelegate<NewCaseBean.GdanliBean>() {
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
                }.cleanAfterAddAllData(bean.getGdanli()));
        baseAdapter.setLayoutManager(recycle2);
        return baseAdapter;
    }

    //限制item个数
    private void limitItemNum(int limit, NewCaseBean bean) {


        if (bean.getPinglun().size() > limit) {
            List<NewCaseBean.PinglunBean> list = new ArrayList<>();
            for (int i = 0; i < limit; i++) {
                list.add(bean.getPinglun().get(i));
            }
            bean.setPinglun(list);
        }

        if (bean.getGdanli().size() > limit) {
            List<NewCaseBean.GdanliBean> list = new ArrayList<>();
            for (int i = 0; i < limit; i++) {
                list.add(bean.getGdanli().get(i));
            }
            bean.setGdanli(list);
        }
    }

    //关注商家
    private void addCare(final int id) {
        LoadDialog.showDialog(mContext);
        new ApiManager().isCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("TAG-------关注结果", result + "   TAG-------案例id" + id);
                com.linzi.xiguwen.bean.BaseBean base = JSONObject.parseObject(result, com.linzi.xiguwen.bean.BaseBean.class);
                if (base.getCode() == 0) {
                    ivCare.setBackgroundResource(R.mipmap.icon_cared2);
                    iscared = 1;
                }

            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }

    //取消关注商家
    private void delCare(final int id) {
        LoadDialog.showDialog(mContext);
        new ApiManager().cancelCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {

                NToast.log("TAG-------取关结果", result + "   TAG-------案例id" + id);
                com.linzi.xiguwen.bean.BaseBean base = JSONObject.parseObject(result, com.linzi.xiguwen.bean.BaseBean.class);
                if (base.getCode() == 0) {
                    ivCare.setBackgroundResource(R.mipmap.icon_care2);
                    iscared = 0;
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
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

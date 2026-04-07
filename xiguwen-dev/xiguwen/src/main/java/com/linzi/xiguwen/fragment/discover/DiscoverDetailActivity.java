package com.linzi.xiguwen.fragment.discover;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Rect;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.Nullable;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.view.ViewOutlineProvider;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jaeger.ninegridimageview.ItemImageClickListener;
import com.jaeger.ninegridimageview.NineGridImageView;
import com.jaeger.ninegridimageview.NineGridImageViewAdapter;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ViewPagerAdapter;
import com.linzi.xiguwen.bean.SynamicdetailsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.LoginActivity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.ui.NewShopMallDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.dialog.DynamicCommentDialog;
import com.linzi.xiguwen.view.dialog.JuBaoCommentDialog;
import com.luck.picture.lib.utils.ToastUtils;
import com.previewlibrary.GPreviewBuilder;
import com.linzi.xiguwen.preview.PreviewUtil;
import com.wx.goodview.GoodView;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by devin on 2018/4/11 15:59
 * Description  动态详情
 */

public class DiscoverDetailActivity extends AppCompatActivity implements DynamicCommentDialog.VideoBarrageSendListener,
        com.jcodecraeer.xrecyclerview.OnItemClickListener1 {

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

    GoodView goodView;

    @BindView(R.id.ll_bottom)
    LinearLayout llBottom;
    @BindView(R.id.tabs)
    TabLayout tabTitle;
    @BindView(R.id.viewpager)
    ViewPager pager;
    @BindView(R.id.iv_dianzan)
    ImageView ivDianzan;
    @BindView(R.id.tx_dianzan)
    TextView txDianzan;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.ll_dianzan)
    LinearLayout llDianzan;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    private List<Fragment> mFragmentList;

    private ViewPagerAdapter pagerAdapter;
    private List<String> titlelist;
    private int id;
    private int itemPosition;
    private String comment = "";
    private int pid = -1;

    private int type;//0 婚庆圈 1 商城圈

    private DiscoverCommentListFragment commentListFragment;
    private DiscoverGoodsListFragment goodsListFragment;
    private SynamicdetailsBean mBean;


    public static void startAction(Context context, int id, int itemPosition) {

        Intent intent = new Intent(context, DiscoverDetailActivity.class);
        intent.putExtra("id", id);
        intent.putExtra("position", itemPosition);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        context.startActivity(intent);
    }

    public static void startAction(Context context, int type, int id, int itemPosition) {

        Intent intent = new Intent(context, DiscoverDetailActivity.class);
        intent.putExtra("id", id);
        intent.putExtra("type", type);
        intent.putExtra("position", itemPosition);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        com.linzi.xiguwen.utils.LogUtil.e("onCreate",getClass().getCanonicalName());
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(DiscoverDetailActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(DiscoverDetailActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_discover_detail);
        ButterKnife.bind(this);
        initView();
        httpData();
    }

    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(DiscoverDetailActivity.this));
        llBar.setLayoutParams(params);
        llBar.setBackgroundColor(DiscoverDetailActivity.this.getResources().getColor(R.color.white));
        //ViewCompat.setAlpha(llBar, 0);

        tvTitle.setText("动态详情");
        titlelist = new ArrayList<>();
        titlelist.add("评论");
        titlelist.add("点赞");
        getFragment();
        pagerAdapter = new ViewPagerAdapter(getSupportFragmentManager(), mFragmentList, titlelist);
        pager.setAdapter(pagerAdapter);
        pager.setCurrentItem(0);
        tabTitle.setupWithViewPager(pager);
        Intent intent = getIntent();
        type = intent.getIntExtra("type", type);
        id = intent.getIntExtra("id", -1);
        itemPosition = intent.getIntExtra("position", 0);
        btCare.setVisibility(View.GONE);

        createNewTab();


//        List<String> trades= Preferences.getNoticeIds();
//        if (!AppUtil.isEmpty(trades)){
//            if (trades.contains(id+"")){
//                trades.remove(id+"");
//            }
//            Preferences.removeNoticeId(id+"");
//            EventBusUtil.sendEvent(new Event(EventCode.MESSAGE_UPDATE_DOT));
//        }
        Preferences.removeNoticeId(id + "");
    }

    private List<Fragment> getFragment() {
        if (mFragmentList == null) {
            mFragmentList = new ArrayList<>();
            commentListFragment = DiscoverCommentListFragment.newInstance();
            goodsListFragment = DiscoverGoodsListFragment.newInstance();
            commentListFragment.setOnitemListener(this);
            mFragmentList.add(commentListFragment);
            mFragmentList.add(goodsListFragment);
        }
        return mFragmentList;
    }


    private void httpData() {

        LoadDialog.showDialog(this);
        if (LoginUtil.isLogin()) {
            ApiManager.getSynamicdetails(id, new OnRequestFinish<BaseBean<SynamicdetailsBean>>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();

                }

                @Override
                public void onSuccess(BaseBean<SynamicdetailsBean> data) {
                    mBean = data.getData();
                    bindValue(mBean);
                    //createNewTab();
                    txTitleZan.setText("点赞" + mBean.getZan());
                    txTitlePingLun.setText("评论" + mBean.getCommentnum());
                }

                @Override
                public void onError(Exception ex) {

                }
            });
        } else {
            ApiManager.getSynamicdetailsNotLogin(id, new OnRequestFinish<BaseBean<SynamicdetailsBean>>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();

                }

                @Override
                public void onSuccess(BaseBean<SynamicdetailsBean> data) {
                    mBean = data.getData();
                    bindValue(mBean);
                    //createNewTab();
                    txTitleZan.setText("点赞" + mBean.getZan());
                    txTitlePingLun.setText("评论" + mBean.getCommentnum());
                }

                @Override
                public void onError(Exception ex) {

                }
            });
        }
    }

    private TextView txTitleZan;
    private TextView txTitlePingLun;

    private void createNewTab() {
        for (int i = 0; i < 2; i++) {
            TabLayout.Tab tab = tabTitle.getTabAt(i);//获得每一个tab
            tab.setCustomView(R.layout.item_tab_tv);//给每一个tab设置view


            if (i == 0) {
                txTitlePingLun = tab.getCustomView().findViewById(R.id.tab_text);
                // 设置第一个tab的TextView是被选择的样式
                txTitlePingLun.setSelected(true);//第一个tab被选中
                if (mBean != null) {
                    txTitlePingLun.setText(titlelist.get(i) + mBean.getCommentnum());
                } else {
                    txTitlePingLun.setText(titlelist.get(i));
                }
            }
            if (i == 1) {
                txTitleZan = tab.getCustomView().findViewById(R.id.tab_text);
                if (mBean != null) {
                    txTitleZan.setText(titlelist.get(i) + mBean.getZan());
                } else {
                    txTitleZan.setText(titlelist.get(i));
                }

            }

        }
    }

    public void bindValue(SynamicdetailsBean bean) {
        GlideLoad.GlideLoadCircle(bean.getHead(), ivHeadImg);
        tvUserName.setText(bean.getNickname());
        if (type == 0) {
            tvZhiwei.setText(bean.getOccupation());
        } else {
            tvZhiwei.setVisibility(View.GONE);
        }
        tvTime.setText(bean.getCreate_ti());
        tvTeamName.setText(bean.getTheteam());
        tvContent.setText(bean.getContent());
//            tvSeeCount.setText(bean.getPv() + "");
//            tvPingjiaCount.setText(bean.getPls() + "");
//            tvDianzanCount.setText(bean.getZan() + "");
        grid_image.setAdapter(mAdapterDetail);
        grid_image.setImagesData(bean.getPhotourl());
        grid_image.setItemImageClickListener(new ItemImageClickListener<SynamicdetailsBean.PhotourlBean>() {
            @Override
            public void onItemImageClick(Context context, ImageView imageView, int index, List<SynamicdetailsBean.PhotourlBean> list) {
//                ArrayList<String> urls = new ArrayList<>();
//                for (SynamicdetailsBean.PhotourlBean bean : list) {
//                    urls.add(bean.getPhotourl());
//                }
//                BrowserUtils.intentToBrowser(context, urls, index);

                if (!PreviewUtil.canPreview(context, list, index)) {
                    return;
                }
                computeBoundsBackward(list);//组成数据
                GPreviewBuilder.from(DiscoverDetailActivity.this)
                        .setUserFragment(com.linzi.xiguwen.preview.SafePreviewPhotoFragment.class)
                        .setData(list)
                        .setCurrentIndex(index)
                        .setType(GPreviewBuilder.IndicatorType.Dot)
                        .start();//启动
            }
        });
        commentListFragment.setCommentlistBean(mBean.getCommentlist());
        goodsListFragment.setData(mBean.getZanlist());
        setGoodsType();

    }

    private void setGoodsType() {
        if (mBean.getMyzan() == 1) {
            txDianzan.setText("已赞");
            ivDianzan.setImageResource(R.mipmap.icon_dianzan);
            txDianzan.setTextColor(getResources().getColor(R.color.red_color));
        } else {
            txDianzan.setText("点赞");
            ivDianzan.setImageResource(R.mipmap.icon_weidianzan);
            txDianzan.setTextColor(getResources().getColor(R.color.g_999999));
        }
    }

    /**
     * 查找信息
     *
     * @param list 图片集合
     */
    private void computeBoundsBackward(List<SynamicdetailsBean.PhotourlBean> list) {
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


    private NineGridImageViewAdapter<SynamicdetailsBean.PhotourlBean> mAdapterDetail = new NineGridImageViewAdapter<SynamicdetailsBean.PhotourlBean>() {
        @Override
        protected void onDisplayImage(Context context, ImageView imageView, SynamicdetailsBean.PhotourlBean s) {
            GlideLoad.GlideLoadImg2(s.getPhotourl(), imageView);
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
        protected void onItemImageClick(Context context, ImageView imageView, int index, List<SynamicdetailsBean.PhotourlBean> list) {
            //  Toast.makeText(context, "image position is " + index, Toast.LENGTH_SHORT).show();
        }
    };


    //点赞
    private void goods() {
        ApiManager.giveALike(id, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                mBean.setMyzan(1);
                if (goodView == null) {
                    goodView = new GoodView(DiscoverDetailActivity.this);
                }
                goodView.setTextInfo("+1", Color.RED, 30);
                goodView.show(llDianzan);
//                int count = mBean.getZan() + 1;
//                mBean.setZan(count);
//                txTitleZan.setText("点赞" + count);
                setGoodsType();
                httpData();
            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(DiscoverDetailActivity.this, ex.getMessage());
            }
        });
    }

    //点赞
    private void goodsCancel() {
        ApiManager.disGiveALike(id, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                mBean.setMyzan(0);
                if (goodView == null) {
                    goodView = new GoodView(DiscoverDetailActivity.this);
                }
                goodView.setTextInfo("-1", Color.RED, 30);
                goodView.show(llDianzan);
//                int count = mBean.getZan() - 1;
//                mBean.setZan(count);
//                txTitleZan.setText("点赞" + count);
                setGoodsType();
                httpData();
            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(DiscoverDetailActivity.this, ex.getMessage());
            }
        });
    }

    //发表评论
    private void publishComment() {
        ApiManager.synamicPublishComment(id, pid, comment, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                httpData();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    private DynamicCommentDialog commentDialog;
    private JuBaoCommentDialog jubaoDialog;

    @OnClick({R.id.ll_back, R.id.ll_pingjia, R.id.ll_dianzan, R.id.iv_head_img})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.ll_back:
                finish();
                break;
            case R.id.ll_pingjia:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(DiscoverDetailActivity.this);
                    return;
                }
                if (commentDialog == null) {
                    commentDialog = new DynamicCommentDialog(this);
                    commentDialog.setListener(this);
                }
                commentDialog.setCurrentPosition(-1);
                commentDialog.show();
                break;
            case R.id.ll_dianzan:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(DiscoverDetailActivity.this);
                    return;
                }
                if (mBean.getMyzan() == 0) {
                    goods();
                } else {
                    goodsCancel();
                }
                break;
            case R.id.iv_head_img:
                if (type == 0) {
                    Intent intent = new Intent(this, NewMallDetailsActivity.class);
                    if (mBean != null) {
                        intent.putExtra("shop_id", mBean.getUserid());
                    }
                    startActivity(intent);
                } else {
                    Intent intent = new Intent(this, NewShopMallDetailsActivity.class);
                    if (mBean != null) {
                        intent.putExtra("shop_id", mBean.getUserid());
                    }
                    startActivity(intent);
                }
                break;
        }
    }

    @Override
    public void dialogBarrageSend(long currentPosition, String message) {
        comment = message;
        if (currentPosition == -1) {
            pid = -1;
        }
        publishComment();
    }

    @Override
    public void onItemClick(View view, int postion, Object data) {

        if (view.getId() == R.id.iv_pingjia){
            if (commentDialog == null) {
                commentDialog = new DynamicCommentDialog(this);
                commentDialog.setListener(this);
            }

            SynamicdetailsBean.CommentlistBean bean = (SynamicdetailsBean.CommentlistBean) data;
            pid = bean.getId();
            commentDialog.setCurrentPosition(postion);
            commentDialog.show();
        }else if (view.getId() == R.id.tv_jubao){
            if (jubaoDialog == null){
                jubaoDialog = new JuBaoCommentDialog(this);
            }
            jubaoDialog.show();
        }

    }
}

package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import androidx.fragment.app.FragmentManager;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RadioButton;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.FindChildAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.fragment.DianzanFragment;
import com.linzi.xiguwen.fragment.PinglunFragment;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.view.CusScrollView;


import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ActivitiesDetailsActivity extends BaseActivity {

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
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.tv_see_count)
    TextView tvSeeCount;
    @BindView(R.id.tv_pingjia_count)
    TextView tvPingjiaCount;
    @BindView(R.id.tv_dianzan_count)
    TextView tvDianzanCount;
    @BindView(R.id.ll_bottom)
    LinearLayout llBottom;
    @BindView(R.id.ll_pingjia)
    LinearLayout llPingjia;
    @BindView(R.id.iv_dianzan)
    ImageView ivDianzan;
    @BindView(R.id.ll_dianzan)
    LinearLayout llDianzan;
    @BindView(R.id.frame)
    FrameLayout frame;
    @BindView(R.id.rb_pinglun)
    RadioButton rbPinglun;
    @BindView(R.id.ll_choose)
    LinearLayout llChoose;
    @BindView(R.id.left_tab)
    RelativeLayout leftTab;
    @BindView(R.id.rb_dianzan)
    RadioButton rbDianzan;
    @BindView(R.id.ll_choose2)
    LinearLayout llChoose2;
    @BindView(R.id.right_tab)
    RelativeLayout rightTab;
    @BindView(R.id.scrollView)
    CusScrollView scrollView;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;

    private ArrayList<String> urls;

    private FragmentManager fm;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
        setContentView(R.layout.activity_activities_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        urls = new ArrayList<>();
        urls.add("http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg");
        urls.add("http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg");
        urls.add("http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg");
        urls.add("http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg");

        setTitle("动态详情");
        setBack();

        llBottom.setVisibility(View.GONE);
        btCare.setVisibility(View.GONE);

        GlideLoad.GlideLoadCircle(mContext, "http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg", ivHeadImg);
        tvUserName.setText("林子");
        tvZhiwei.setText("策划师");
        tvTime.setText("2017-12-22");
        tvTeamName.setText("**策划师团队");
        tvContent.setText("青春是一首永不言败的歌，青春是一条永不停息的河流，青春是一本读不厌的书，青春是一杯品不尽的茶，青春是一起牵手在天空之桥留下我们幸福的足迹。");
        tvSeeCount.setText("200");
        tvPingjiaCount.setText("200");
        tvDianzanCount.setText("200");
        final GridLayoutManager manager = new GridLayoutManager(mContext, 3) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        recycle.setAdapter(new FindChildAdapter(mContext, 0).new ImgAdapter(new CallBack.ImgClickListener() {
            @Override
            public void imgListener(int id) {
                FullScreenUtil.showFullScreenDialog(mContext,0,urls,false);
            }
        }));

        fm = this.getSupportFragmentManager();
        final PinglunFragment fragment = new PinglunFragment();
        final DianzanFragment dianzanFragment = new DianzanFragment();
        fm.beginTransaction().add(R.id.frame, fragment).commit();
        fm.beginTransaction().add(R.id.frame, dianzanFragment).commit();
        fm.beginTransaction().hide(dianzanFragment).commit();
        fm.beginTransaction().show(fragment).commit();

        leftTab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                rbPinglun.setChecked(true);
                rbDianzan.setChecked(false);
                llChoose.setVisibility(View.VISIBLE);
                llChoose2.setVisibility(View.GONE);
                fm.beginTransaction().hide(dianzanFragment).commit();
                fm.beginTransaction().show(fragment).commit();
            }
        });
        rightTab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                rbPinglun.setChecked(false);
                rbDianzan.setChecked(true);
                llChoose.setVisibility(View.GONE);
                llChoose2.setVisibility(View.VISIBLE);
                fm.beginTransaction().hide(fragment).commit();
                fm.beginTransaction().show(dianzanFragment).commit();
            }
        });

        llPingjia.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showPopReply(llParent);
            }
        });

    }

    private void showPopReply(View llParent) {
        final View view = LayoutInflater.from(mContext).inflate(R.layout.pop_reply_layout, null);
        ViewHolder vh = new ViewHolder(view);
        final PopupWindow pop = new PopupWindow(mContext);
        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = this.getWindowManager().getDefaultDisplay().getWidth();
//        int h = (this.getWindowManager().getDefaultDisplay().getHeight() / 5)*2;
        pop.setWidth(w);
//        pop.setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(view);
        pop.update();
        pop.showAtLocation(llParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
                HideKeyboard(view);
            }
        });
        showInputMethod(mContext, view);
    }

    class ViewHolder {
        @BindView(R.id.ed_reply)
        EditText edReply;
        @BindView(R.id.tv_send)
        TextView tvSend;
        @BindView(R.id.ll_reply)
        LinearLayout llReply;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

    private void getData(){

//        ApiManager
    }
}

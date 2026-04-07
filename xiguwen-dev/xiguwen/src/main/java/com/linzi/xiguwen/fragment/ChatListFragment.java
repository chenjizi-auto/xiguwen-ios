package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PagerAdapter;
import com.linzi.xiguwen.fragment.message.NoticeFragment;
import com.linzi.xiguwen.fragment.message.PreferentialActivity;
import com.linzi.xiguwen.fragment.message.TradeFragment;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.helper.SystemMessageUnreadManager;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.utils.yixin.reminder.ReminderItem;
import com.linzi.xiguwen.utils.yixin.reminder.ReminderManager;
import com.linzi.xiguwen.view.MyViewPager;
import com.netease.nimlib.sdk.NIMClient;
import com.netease.nimlib.sdk.Observer;
import com.netease.nimlib.sdk.msg.MsgService;
import com.netease.nimlib.sdk.msg.SystemMessageObserver;
import com.netease.nimlib.sdk.msg.SystemMessageService;
import com.netease.nimlib.sdk.msg.attachment.MsgAttachment;
import com.netease.nimlib.sdk.msg.constant.SessionTypeEnum;
import com.netease.nimlib.sdk.msg.model.RecentContact;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ChatListFragment extends Fragment implements ReminderManager.UnreadNumChangedCallback {
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    @BindView(R.id.msg_chart_img)
    ImageView msgChartImg;
    @BindView(R.id.msg_trade_img)
    ImageView msgTradeImg;
    @BindView(R.id.msg_notice_img)
    ImageView msgNoticeImg;
    @BindView(R.id.msg_preferential_img)
    ImageView msgPreferentialImg;
    @BindView(R.id.pager)
    MyViewPager pager;
    @BindView(R.id.msg_chart_count)
    TextView txChartCount;
    @BindView(R.id.msg_trade_count)
    TextView txTradeCount;
    @BindView(R.id.msg_notice_count)
    TextView txNoticeCount;
    @BindView(R.id.msg_pre_count)
    TextView txPreCount;
    @BindView(R.id.msg_chart_tx)
    TextView txChartTx;
    @BindView(R.id.msg_trade_tx)
    TextView txTradeTx;
    @BindView(R.id.msg_notice_tx)
    TextView txNoticeTx;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    private List<Fragment> mFragmentList;


    private int position;

    private String mParam1;
    private String mParam2;

    public static ChatListFragment newInstance(String param1, String param2) {
        ChatListFragment fragment = new ChatListFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }

    }

//    private RecentContactsFragment contactsFragment;
    private TradeFragment tradeFragment = new TradeFragment();

    /**
     * 初始化侧滑控件
     *
     * @return
     */
    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
//        if (contactsFragment == null) {
//            contactsFragment = new RecentContactsFragment();
//            contactsFragment.setCallback(new RecentContactsCallback() {
//                @Override
//                public void onRecentContactsLoaded() {
//
//                }
//
//                @Override
//                public void onUnreadCountChange(int unreadCount) {
//                    ReminderManager.getInstance().updateSessionUnreadNum(unreadCount);
//                }
//
//                @Override
//                public void onItemClick(RecentContact recent) {
//                    if (recent.getSessionType() == SessionTypeEnum.Team) {
////                        NimUIKit.startTeamSession(getActivity(), recent.getContactId());
//                    } else if (recent.getSessionType() == SessionTypeEnum.P2P) {
////                        NimUIKit.startP2PSession(getActivity(), recent.getContactId());
//                    }
//                }
//
//                @Override
//                public String getDigestOfAttachment(RecentContact recent, MsgAttachment attachment) {
//                    return null;
//                }
//
//                @Override
//                public String getDigestOfTipMsg(RecentContact recent) {
//                    return null;
//                }
//            });
//        }
        if (tradeFragment != null) {
            tradeFragment = new TradeFragment();
            tradeFragment.setCallback(new MessageDotChangeListener() {
                @Override
                public void change() {
                    updateCount();
                }
            });
        }
//        mFragmentList.add(contactsFragment);
        mFragmentList.add(tradeFragment);
        mFragmentList.add(new NoticeFragment());
//        mFragmentList.add(new ChartFragment());
        return mFragmentList;
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initView();
        registerMsgUnreadInfoObserver(true);
        registerSystemMessageObservers(true);
        requestSystemMessageUnreadCount();
        EventBusUtil.register(this);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_chat_list, container, false);
        ButterKnife.bind(this, view);
//        initView();
        return view;
    }


    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(getActivity()));
        llBar.setLayoutParams(params);
        llBar.setBackgroundColor(getActivity().getResources().getColor(R.color.white));
        //ViewCompat.setAlpha(llBar, 0);

        pager.setScanScroll(false);
        pager.setAdapter(new PagerAdapter(getChildFragmentManager(), getFragment()));
        pager.setCurrentItem(0, false);
        pager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                ChatListFragment.this.position = position;
                if (position == 0) {
                    enableMsgNotification(false);
                } else {
                    enableMsgNotification(true);
                }
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.MESSAGE_UPDATE_DOT:
                    updateCount();
                    break;
            }
        } catch (Exception e) {
        }

    }


    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        registerMsgUnreadInfoObserver(false);
        registerSystemMessageObservers(false);
        EventBusUtil.unregister(this);
    }

    @OnClick({R.id.msg_chart_img_item, R.id.msg_trade_img_item, R.id.msg_notice_img_item, R.id.msg_preferential_img_item})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.msg_chart_img_item:
                pager.setCurrentItem(0, false);//首页事件
                setTxChange(0);
                break;
            case R.id.msg_trade_img_item:
                pager.setCurrentItem(1, false);//首页事件
                setTxChange(1);
                break;
            case R.id.msg_notice_img_item:
                pager.setCurrentItem(2, false);//首页事件
                setTxChange(2);
                break;
            case R.id.msg_preferential_img_item:
                startActivity(new Intent(getActivity(), PreferentialActivity.class));
                break;
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        if (position == 0) {
            enableMsgNotification(false);
        } else {
            enableMsgNotification(true);
        }
//        enableMsgNotification(false);
//        com.linzi.xiguwen.utils.LogUtil.e("======messageCount=====", "=========" + Preferences.getInt("messageCount"));

        updateCount();
        //quitOtherActivities();
    }

    private void updateCount() {
        List<String> trades = Preferences.getTradeIds();
        if (trades != null && trades.size() > 0) {
            txTradeCount.setText(trades.size() + "");
            txTradeCount.setVisibility(View.VISIBLE);
        } else {
            txTradeCount.setVisibility(View.GONE);
        }

        List<String> noticess = Preferences.getNoticeIds();
        if (noticess != null && noticess.size() > 0) {
            txNoticeCount.setText(noticess.size() + "");
            txNoticeCount.setVisibility(View.VISIBLE);
        } else {
            txNoticeCount.setVisibility(View.GONE);
        }

        int preCount = Preferences.getDiscount();
        if (preCount > 0) {
            txPreCount.setText(preCount + "");
            txPreCount.setVisibility(View.VISIBLE);
        } else {
            txPreCount.setVisibility(View.GONE);
        }
    }

    @Override
    public void onPause() {
        super.onPause();
        enableMsgNotification(true);
    }


    private void setTxChange(int page) {
        txChartTx.setTextColor(getResources().getColor(R.color.c_666666));
        txTradeTx.setTextColor(getResources().getColor(R.color.c_666666));
        txNoticeTx.setTextColor(getResources().getColor(R.color.c_666666));
        msgChartImg.setImageResource(R.mipmap.msg_chart_unselect);
        msgTradeImg.setImageResource(R.mipmap.msg_trade_unselect);
        msgNoticeImg.setImageResource(R.mipmap.msg_notice_unselect);
        if (page == 0) {
            txChartTx.setTextColor(getResources().getColor(R.color.red_color));
            msgChartImg.setImageResource(R.mipmap.msg_chart_select);
        } else if (page == 1) {
            txTradeTx.setTextColor(getResources().getColor(R.color.red_color));
            msgTradeImg.setImageResource(R.mipmap.msg_chart_select);
        } else if (page == 2) {
            txNoticeTx.setTextColor(getResources().getColor(R.color.red_color));
            msgNoticeImg.setImageResource(R.mipmap.msg_chart_select);
        }

    }

    private void enableMsgNotification(boolean enable) {
        if (enable) {
            /**
             * 设置最近联系人的消息为已读
             *
             * @param account,    聊天对象帐号，或者以下两个值：
             *                    {@link #MSG_CHATTING_ACCOUNT_ALL} 目前没有与任何人对话，但能看到消息提醒（比如在消息列表界面），不需要在状态栏做消息通知
             *                    {@link #MSG_CHATTING_ACCOUNT_NONE} 目前没有与任何人对话，需要状态栏消息通知
             */
            NIMClient.getService(MsgService.class).setChattingAccount(MsgService.MSG_CHATTING_ACCOUNT_NONE, SessionTypeEnum.None);
        } else {
            NIMClient.getService(MsgService.class).setChattingAccount(MsgService.MSG_CHATTING_ACCOUNT_ALL, SessionTypeEnum.None);
        }
    }

    /**
     * 注册未读消息数量观察者
     */
    private void registerMsgUnreadInfoObserver(boolean register) {
        if (register) {
            ReminderManager.getInstance().registerUnreadNumChangedCallback(this);
        } else {
            ReminderManager.getInstance().unregisterUnreadNumChangedCallback(this);
        }
    }

    @Override
    public void onUnreadNumChanged(ReminderItem item) {


        int count = item.getUnread();
        com.linzi.xiguwen.utils.LogUtil.e("====1=====", "======onUnreadNumChanged==========" + count);
        if (item.getUnread() > 0) {
            txChartCount.setVisibility(View.VISIBLE);
            txChartCount.setText(count + "");
        } else {
            txChartCount.setVisibility(View.GONE);
        }
    }

    /**
     * 注册/注销系统消息未读数变化
     *
     * @param register
     */
    private void registerSystemMessageObservers(boolean register) {
        NIMClient.getService(SystemMessageObserver.class).observeUnreadCountChange(sysMsgUnreadCountChangedObserver,
                register);
    }

    private Observer<Integer> sysMsgUnreadCountChangedObserver = new Observer<Integer>() {
        @Override
        public void onEvent(Integer unreadCount) {
            com.linzi.xiguwen.utils.LogUtil.e("====2=====", "======onEvent==========");
            SystemMessageUnreadManager.getInstance().setSysMsgUnreadCount(unreadCount);
            ReminderManager.getInstance().updateContactUnreadNum(unreadCount);
        }
    };

    /**
     * 查询系统消息未读数
     */
    private void requestSystemMessageUnreadCount() {
        int unread = NIMClient.getService(SystemMessageService.class).querySystemMessageUnreadCountBlock();
        SystemMessageUnreadManager.getInstance().setSysMsgUnreadCount(unread);
        ReminderManager.getInstance().updateContactUnreadNum(unread);
    }

    public interface MessageDotChangeListener {
        void change();

    }
}

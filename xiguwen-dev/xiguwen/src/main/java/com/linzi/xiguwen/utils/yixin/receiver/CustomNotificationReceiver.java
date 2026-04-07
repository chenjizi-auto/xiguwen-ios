package com.linzi.xiguwen.utils.yixin.receiver;

import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import androidx.core.app.NotificationCompat;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MessageEntity;
import com.linzi.xiguwen.fragment.discover.DiscoverDetailActivity;
import com.linzi.xiguwen.ui.MainActivity;
import com.linzi.xiguwen.ui.NewOrderDetailsActivity;
import com.linzi.xiguwen.utils.SysInfoUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.netease.nimlib.sdk.NimIntent;
import com.netease.nimlib.sdk.msg.model.CustomNotification;

/**
 * 自定义通知消息广播接收器
 */
public class CustomNotificationReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = context.getPackageName() + NimIntent.ACTION_RECEIVE_CUSTOM_NOTIFICATION;
        if (action.equals(intent.getAction())) {
            // 处理自定义通知消息
//            LogUtil.e("demo", "receive custom notification:");
            // 从intent中取出自定义通知
            CustomNotification notification = (CustomNotification) intent.getSerializableExtra(NimIntent.EXTRA_BROADCAST_MSG);
//            ShortcutBadger.applyCount(context,10);
            try {
                MessageEntity obj = JSONObject.parseObject(notification.getContent(), MessageEntity.class);

                if (obj.getType() == 1) {
                    Preferences.saveTradeId(obj.getSid());
                    Preferences.savePushTradeId(obj.getId());
                    showNotifictionIcon(context, obj);
//                    int count=Preferences.getPushTradeIds().size();
//                    ShortcutBadger.applyCount(context,10);
                    EventBusUtil.sendEvent(new Event(EventCode.MESSAGE_UPDATE_DOT));

                } else if (obj.getType() == 2) {
//                    Preferences.savePushTradeId(obj.getId());
                    Preferences.saveNoticeId(obj.getSid());
                    showNotifictionIcon(context, obj);
                    EventBusUtil.sendEvent(new Event(EventCode.MESSAGE_UPDATE_DOT));
                }

//                if (obj != null && obj.getIntValue("id") == 2) {
//                    // 加入缓存中
//                    CustomNotificationCache.getInstance().addCustomNotification(notification);
//                    // Toast
//                    String content = obj.getString("content");
////                    String tip = String.format("自定义消息[%s]：%s", notification.getFromAccount(), content);
////                    Toast.makeText(context, tip, Toast.LENGTH_SHORT).show();
//
//                }
            } catch (JSONException e) {
//                LogUtil.e("demo", e.getMessage());
            }

            // 处理自定义通知消息
//            LogUtil.i("demo", "receive custom notification: " + notification.getContent() + " from :" + notification.getSessionId() + "/" + notification.getSessionType());
        }
    }


    public static void showNotifictionIcon(Context context, MessageEntity entity) {
        NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
        Intent intent = null;
        if (SysInfoUtil.isHasMainActivity(context)) {
            if (entity.getType() == 1) {//跳转到交易详情
//            intent = new Intent(context, WenzhangDetailsActivity.class);//直接跳转到详情界面
//            intent.putExtra("url", "https:www.baidu.com");
                Preferences.removePushTradeId(entity.getId()+"");
                intent = new Intent(context, NewOrderDetailsActivity.class);
                intent.putExtra("order_id", Integer.parseInt(entity.getSid() + ""));
                intent.putExtra("intentType", entity.getShifoujiedan());
                if (entity.getStatus() == 100){
                    intent.putExtra("status", entity.getStatus());
                }
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);

            } else if (entity.getType() == 2) {//跳转到通知详情
//                Preferences.removePushTradeId(entity.getId()+"");
//                DiscoverDetailActivity.startAction(context, Integer.parseInt(entity.getSid()), 0);
                intent = new Intent(context, DiscoverDetailActivity.class);
                intent.putExtra("id", Integer.parseInt(entity.getSid() + ""));
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            }
        } else {
            intent = new Intent(context, MainActivity.class);//将要跳转的界面
            intent.putExtra(MainActivity.WY_MY_MESSAGE, JSON.toJSONString(entity));
        }

        //Intent intent = new Intent();//只显示通知，无页面跳转
        builder.setAutoCancel(true);//点击后消失
        builder.setSmallIcon(R.mipmap.app_icon);//设置通知栏消息标题的头像
        builder.setDefaults(NotificationCompat.DEFAULT_SOUND);//设置通知铃声
//        builder.setTicker("状态栏显示的文字");
        builder.setContentTitle(entity.getTitle());
        builder.setContentText(entity.getCont());
        //利用PendingIntent来包装我们的intent对象,使其延迟跳转
        int pendingIntentFlags = PendingIntent.FLAG_CANCEL_CURRENT;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            pendingIntentFlags |= PendingIntent.FLAG_IMMUTABLE;
        }
        PendingIntent intentPend = PendingIntent.getActivity(context, 0, intent, pendingIntentFlags);
        builder.setContentIntent(intentPend);
        NotificationManager manager = (NotificationManager) context.getSystemService(context.NOTIFICATION_SERVICE);
        manager.notify(0, builder.build());
    }
}

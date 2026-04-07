package com.linzi.xiguwen.jpush;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;

import com.alibaba.fastjson.JSON;
import com.linzi.xiguwen.bean.MessageEntity;
import com.linzi.xiguwen.ui.MainActivity;
import com.linzi.xiguwen.ui.NewOrderDetailsActivity;
import com.linzi.xiguwen.ui.WenzhangDetailsActivity;
import com.linzi.xiguwen.utils.SysInfoUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;

import cn.jpush.android.api.JPushInterface;

/**
 * Created by devin on 2018/4/10 11:13
 * Description
 */

public class JPushReceiver extends BroadcastReceiver {
    private static final String TAG = "JIGUANG-Example";

    @Override
    public void onReceive(Context context, Intent intent) {
        try {
            Bundle bundle = intent.getExtras();
            com.linzi.xiguwen.utils.LogUtil.d(TAG, "[MyReceiver] onReceive - " + intent.getAction() + ", extras: " + printBundle(bundle));

            if (JPushInterface.ACTION_REGISTRATION_ID.equals(intent.getAction())) {
                String regId = bundle.getString(JPushInterface.EXTRA_REGISTRATION_ID);
                com.linzi.xiguwen.utils.LogUtil.d(TAG, "[MyReceiver] 接收Registration Id : " + regId);
                //send the Registration Id to your server...

            } else if (JPushInterface.ACTION_MESSAGE_RECEIVED.equals(intent.getAction())) {
                com.linzi.xiguwen.utils.LogUtil.d(TAG, "[MyReceiver] 接收到推送下来的自定义消息: " + bundle.getString(JPushInterface.EXTRA_MESSAGE));
//                processCustomMessage(context, bundle);

            } else if (JPushInterface.ACTION_NOTIFICATION_RECEIVED.equals(intent.getAction())) {
                com.linzi.xiguwen.utils.LogUtil.d(TAG, "[MyReceiver] 接收到推送下来的通知");
                int notifactionId = bundle.getInt(JPushInterface.EXTRA_NOTIFICATION_ID);
                com.linzi.xiguwen.utils.LogUtil.d(TAG, "[MyReceiver] 接收到推送下来的通知的ID: " + notifactionId);
                int count = Preferences.getDiscount();
                Preferences.saveDiscount(count + 1);
                EventBusUtil.sendEvent(new Event(EventCode.MESSAGE_UPDATE_DOT));

            } else if (JPushInterface.ACTION_NOTIFICATION_OPENED.equals(intent.getAction())) {
                com.linzi.xiguwen.utils.LogUtil.d(TAG, "[MyReceiver] 用户点击打开了通知");
//                WenzhangDetailsActivity.startAction(this, ben.getSrc(), ben.getTitle(), true);
                //打开自定义的Activity
                try {
                    String data = bundle.getString(JPushInterface.EXTRA_EXTRA);
                    MessageEntity entity = JSON.parseObject(data, MessageEntity.class);
                    if (SysInfoUtil.isHasMainActivity(context)){
                        if (entity.getType() != 3) {
                            Intent intent1 = new Intent(context, NewOrderDetailsActivity.class);
                            if (entity.getType() == 1) {
                                //婚庆
                                if (entity.getStyle() == 1) {
                                    //婚庆用户
                                    intent1.putExtra("intentType",0);
                                    intent1.putExtra("order_id",Integer.parseInt(entity.getId()));
                                } else if (entity.getStyle() == 2) {
                                    //婚庆接单
                                    intent1.putExtra("intentType",2);
                                    intent1.putExtra("order_id",Integer.parseInt(entity.getId()));
                                } else {
                                    //商城接单
                                    intent1.putExtra("intentType",3);
                                    intent1.putExtra("order_id",Integer.parseInt(entity.getId()));
                                }
                            } else {
                                //商城
                                if (entity.getStyle() == 1) {
                                    //商城用户
                                    intent1.putExtra("intentType",1);
                                    intent1.putExtra("order_id",Integer.parseInt(entity.getId()));
                                } else if (entity.getStyle() == 2) {
                                    //婚庆接单
                                    intent1.putExtra("intentType",2);
                                    intent1.putExtra("order_id",Integer.parseInt(entity.getId()));
                                } else {
                                    //商城接单
                                    intent1.putExtra("intentType",3);
                                    intent1.putExtra("order_id",Integer.parseInt(entity.getId()));
                                }
                            }
                            context.startActivity(intent1);
                        } else {
                            WenzhangDetailsActivity.startAction(context, entity.getUrl(), entity.getTitle() + "", true);
                        }
                    }else {
                        MainActivity.start(context,new Intent().putExtra(MainActivity.JPUSH_MESSAGE,data));
                    }

//                    Intent i = new Intent(context, WenzhangDetailsActivity.class);
//                    i.putExtras(bundle);
//                    //i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//                    i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
//                    context.startActivity(i);
                    int count = Preferences.getDiscount();
                    if (count > 0) {
                        Preferences.saveDiscount(count - 1);
                    }
                } catch (Exception e) {
                }

            } else if (JPushInterface.ACTION_RICHPUSH_CALLBACK.equals(intent.getAction())) {
                com.linzi.xiguwen.utils.LogUtil.d(TAG, "[MyReceiver] 用户收到到RICH PUSH CALLBACK: " + bundle.getString(JPushInterface.EXTRA_EXTRA));
                //在这里根据 JPushInterface.EXTRA_EXTRA 的内容处理代码，比如打开新的Activity， 打开一个网页等..

            } else if (JPushInterface.ACTION_CONNECTION_CHANGE.equals(intent.getAction())) {
                boolean connected = intent.getBooleanExtra(JPushInterface.EXTRA_CONNECTION_CHANGE, false);
                com.linzi.xiguwen.utils.LogUtil.w(TAG, "[MyReceiver]" + intent.getAction() + " connected state change to " + connected);
            } else {
                com.linzi.xiguwen.utils.LogUtil.d(TAG, "[MyReceiver] Unhandled intent - " + intent.getAction());
            }
        } catch (Exception e) {

        }

    }

    // 打印所有的 intent extra 数据
    private static String printBundle(Bundle bundle) {
        StringBuilder sb = new StringBuilder();
        for (String key : bundle.keySet()) {
            if (key.equals(JPushInterface.EXTRA_NOTIFICATION_ID)) {
                sb.append("\nkey:" + key + ", value:" + bundle.getInt(key));
            } else if (key.equals(JPushInterface.EXTRA_CONNECTION_CHANGE)) {
                sb.append("\nkey:" + key + ", value:" + bundle.getBoolean(key));
            } else if (key.equals(JPushInterface.EXTRA_EXTRA)) {
                if (TextUtils.isEmpty(bundle.getString(JPushInterface.EXTRA_EXTRA))) {
                    com.linzi.xiguwen.utils.LogUtil.i(TAG, "This message has no Extra data");
                    continue;
                }

                try {
                    JSONObject json = new JSONObject(bundle.getString(JPushInterface.EXTRA_EXTRA));
                    Iterator<String> it = json.keys();

                    while (it.hasNext()) {
                        String myKey = it.next();
                        sb.append("\nkey:" + key + ", value: [" +
                                myKey + " - " + json.optString(myKey) + "]");
                    }
                } catch (JSONException e) {
                    com.linzi.xiguwen.utils.LogUtil.e(TAG, "Get message extra JSON error!");
                }

            } else {
                sb.append("\nkey:" + key + ", value:" + bundle.getString(key));
            }
        }
        return sb.toString();
    }

/*    //send msg to MainActivity
    private void processCustomMessage(Context context, Bundle bundle) {
        if (MainActivity.isForeground) {
            String message = bundle.getString(JPushInterface.EXTRA_MESSAGE);
            String extras = bundle.getString(JPushInterface.EXTRA_EXTRA);
            Intent msgIntent = new Intent(MainActivity.MESSAGE_RECEIVED_ACTION);
            msgIntent.putExtra(MainActivity.KEY_MESSAGE, message);
            if (!ExampleUtil.isEmpty(extras)) {
                try {
                    JSONObject extraJson = new JSONObject(extras);
                    if (extraJson.length() > 0) {
                        msgIntent.putExtra(MainActivity.KEY_EXTRAS, extras);
                    }
                } catch (JSONException e) {

                }

            }
            LocalBroadcastManager.getInstance(context).sendBroadcast(msgIntent);
        }
    }*/
}
package com.linzi.xiguwen.utils.eventbus;

import org.greenrobot.eventbus.EventBus;

/**
 * Created by devin on 2017/7/3 17:24
 * Description
 */
public class EventBusUtil {

    public static void register(Object subscriber) {
        if (subscriber == null) {
            return;
        }
        EventBus bus = EventBus.getDefault();
        if (!bus.isRegistered(subscriber)) {
            bus.register(subscriber);
        }
    }

    public static void unregister(Object subscriber) {
        if (subscriber == null) {
            return;
        }
        EventBus bus = EventBus.getDefault();
        if (bus.isRegistered(subscriber)) {
            bus.unregister(subscriber);
        }
    }

    public static void sendEvent(Event event) {
        EventBus.getDefault().post(event);
    }

//    public static void sendEvent(eent webEntity) {
//        EventBus.getDefault().post(webEntity);
//    }


    public static void sendStickyEvent(Event event) {
        EventBus.getDefault().postSticky(event);
    }

    // 其他
}

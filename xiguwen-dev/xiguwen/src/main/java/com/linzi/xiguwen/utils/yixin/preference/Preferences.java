package com.linzi.xiguwen.utils.yixin.preference;

import android.content.Context;
import android.content.SharedPreferences;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.utils.yixin.DemoCache;

import java.util.ArrayList;
import java.util.List;


/**
 * Created by hzxuwen on 2015/4/13.
 */
public class Preferences {
    private static final String KEY_USER_ACCOUNT = "im_account";
    private static final String KEY_USER_TOKEN = "im_token";

    private static final String PUSH_ID_TRADE = "push_id_trade";
    private static final String COUNT_TRADE = "count_trade";
    private static final String COUNT_NOTICE = "count_notice";
    private static final String COUNT_PRE = "count_pre";

    public static final String SYNAMIC_IMAGE = "synamic_image";
    public static final String SYNAMIC_CONTENT = "synamic_content";

    public static final String SEARCH_HISTORE = "search_history";

    public static final String PROFESSIONAL = "professional";

    public static final String CITY_LOCATION = "city_location";

    public static final String USER_PHONE = "user_phone";

    public static final String WACHAT_OPENID = "wachat_openid";


    public static void saveString(String key, String value) {
        SharedPreferences.Editor editor = getSharedPreferences().edit();
        editor.putString(key, value);
        editor.commit();
    }

    public static String getString(String key) {
        return getSharedPreferences().getString(key, null);
    }

    static SharedPreferences getSharedPreferences() {
        return DemoCache.getContext().getSharedPreferences("Demo", Context.MODE_PRIVATE);
    }

    public static void saveInt(String key, int value) {
        SharedPreferences.Editor editor = getSharedPreferences().edit();
        editor.putInt(key, value);
        editor.commit();
    }

    public static int getInt(String key) {
        return getSharedPreferences().getInt(key, 0);
    }


    public static void saveUserAccount(String account) {
        saveString(KEY_USER_ACCOUNT, account);
    }

    public static String getUserAccount() {
        return getString(KEY_USER_ACCOUNT);
    }

    public static void saveUserToken(String token) {
        saveString(KEY_USER_TOKEN, token);
    }

    public static String getUserToken() {
        return getString(KEY_USER_TOKEN);
    }


    public static void saveTradeId(String id) {
        List<String> data = getTradeIds();
        if (data != null) {
            data.add(id);
        } else {
            data = new ArrayList<>();
            data.add(id);
        }
        saveString(COUNT_TRADE, JSON.toJSONString(data));
    }

    public static void removeTradeId(String id) {
        List<String> data = getTradeIds();
        if (data != null && data.contains(id)) {
            data.remove(id);
            saveString(COUNT_TRADE, JSON.toJSONString(data));
        }
    }

    public static List<String> getTradeIds() {
        String count = getString(COUNT_TRADE);
        if (count == null) {
            return null;
        }
        List<String> data;
        try {
            data = JSON.parseArray(count, String.class);
        } catch (Exception e) {
            data = null;
        }

        return data;
    }

    public static void saveNoticeId(String id) {
        List<String> data = getNoticeIds();
        if (data != null) {
            data.add(id);
        } else {
            data = new ArrayList<>();
            data.add(id);
        }
        saveString(COUNT_NOTICE, JSON.toJSONString(data));
    }

    public static void removeNoticeId(String id) {
        List<String> data = getNoticeIds();
        if (data != null &&data.size()>0&& data.contains(id)) {
            data.remove(id);
            saveString(COUNT_NOTICE, JSON.toJSONString(data));
        }
    }

    public static List<String> getNoticeIds() {
        String count = getString(COUNT_NOTICE);
        if (count == null) {
            return null;
        }
        List<String> data;
        try {
            data = JSON.parseArray(count, String.class);
        } catch (Exception e) {
            data = null;
        }

        return data;
    }


    public static void saveDiscount(int count) {
        saveInt(COUNT_PRE, count);
    }

    public static int getDiscount() {
        return getInt(COUNT_PRE);
    }



    public static void savePushTradeId(String id) {
        List<String> data = getPushTradeIds();
        if (data != null) {
            data.add(id);
        } else {
            data = new ArrayList<>();
            data.add(id);
        }
        saveString(PUSH_ID_TRADE, JSON.toJSONString(data));
    }

    public static void removePushTradeId(String id) {
        List<String> data = getPushTradeIds();
        if (data != null && data.contains(id)) {
            data.remove(id);
            saveString(PUSH_ID_TRADE, JSON.toJSONString(data));
        }
    }

    public static List<String> getPushTradeIds() {
        String count = getString(PUSH_ID_TRADE);
        if (count == null) {
            return null;
        }
        List<String> data;
        try {
            data = JSON.parseArray(count, String.class);
        } catch (Exception e) {
            data = null;
        }

        return data;
    }


    public static void saveCity(CityEntity cityEntity) {
        if (cityEntity != null) {
            saveString(CITY_LOCATION, JSON.toJSONString(cityEntity));
        } else {
            saveString(CITY_LOCATION, "");
        }

    }

    public static CityEntity getCity() {
        String city = getString(CITY_LOCATION);
        try {
            if (city != null)
                return JSONObject.parseObject(city, CityEntity.class);
        } catch (Exception e) {
        }
        return null;
    }


}

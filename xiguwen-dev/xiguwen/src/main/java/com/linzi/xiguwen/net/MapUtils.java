package com.linzi.xiguwen.net;

import android.content.Context;

import com.linzi.xiguwen.utils.SPUtil;

import java.util.HashMap;
import java.util.Map;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/22  16:43
 *
 * @author luyongjiang
 * @version 1.0
 */
public class MapUtils {
    Map<String, Object> map = new HashMap<>();
    private static Context mContext;

    public static void init(Context context) {
        mContext = context;
    }

    private MapUtils() {

    }

    private MapUtils(boolean isToken) {
        if (SPUtil.get("token", SPUtil.Type.STR).toString() != null && !SPUtil.get("token", SPUtil.Type.STR).toString().equals("")) {
            map.put("token", SPUtil.get("token", SPUtil.Type.STR).toString());
            map.put("userid", SPUtil.get("userid", SPUtil.Type.INT) + "");
        } else {
//            Intent intent = new Intent(mContext, LoginActivity.class);
//            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
//            mContext.startActivity(intent);
        }
    }

    @Deprecated
    public static MapUtils craete() {
        return new MapUtils();
    }

    public static MapUtils create() {
        return new MapUtils();
    }

    /**
     * 如果需要默认携带token的话就使用这个方法创建
     *
     * @return
     */
    public static MapUtils createToken() {
        return new MapUtils(true);
    }


    public MapUtils putBody(String key, String value) {
        map.put(key, value);
        return this;
    }

    public MapUtils putBody(String key, Object value) {
        map.put(key, value);
        return this;
    }

    public Map<String, Object> getValue() {
        return map;
    }

}
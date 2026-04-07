package com.linzi.xiguwen.net;

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
public class MapUtilsX {
    Map<String, Object> map = new HashMap<>();

    private MapUtilsX() {

    }

    private MapUtilsX(boolean isToken) {
        map.put("token", SPUtil.get("token", SPUtil.Type.STR).toString());
        map.put("userid", SPUtil.get("userid", SPUtil.Type.INT) + "");
    }

    @Deprecated
    public static MapUtilsX craete() {
        return new MapUtilsX();
    }

    public static MapUtilsX create() {
        return new MapUtilsX();
    }

    /**
     * 如果需要默认携带token的话就使用这个方法创建
     *
     * @return
     */
    public static MapUtilsX createToken() {
        return new MapUtilsX(true);
    }


    public MapUtilsX putBody(String key, Object value) {
        map.put(key, value);
        return this;
    }


    public Map<String, Object> getValue() {
        return map;
    }

}
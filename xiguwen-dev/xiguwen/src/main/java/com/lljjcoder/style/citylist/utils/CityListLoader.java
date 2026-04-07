package com.lljjcoder.style.citylist.utils;

import android.content.Context;

public class CityListLoader {
    private static final CityListLoader INSTANCE = new CityListLoader();

    private CityListLoader() {
    }

    public static CityListLoader getInstance() {
        return INSTANCE;
    }

    public void loadProData(Context context) {
    }
}

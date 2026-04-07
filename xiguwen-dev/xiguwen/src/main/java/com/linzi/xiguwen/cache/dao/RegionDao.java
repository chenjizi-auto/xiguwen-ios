package com.linzi.xiguwen.cache.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.linzi.xiguwen.bean.ProvinceBean;
import com.linzi.xiguwen.cache.CacheDbHelper;

import java.util.ArrayList;
import java.util.List;

public class RegionDao {

    private final CacheDbHelper dbHelper;

    public RegionDao(Context context) {
        dbHelper = CacheDbHelper.getInstance(context);
    }

    public List<ProvinceBean> getAllProvinceTree() {
        List<ProvinceBean> provinces = queryProvinces();
        for (ProvinceBean province : provinces) {
            List<ProvinceBean.CityBean> cities = queryCities(province.getId());
            province.setCity(cities);
            for (ProvinceBean.CityBean city : cities) {
                city.setCounty(queryCounties(city.getId()));
            }
        }
        return provinces;
    }

    public void replaceAll(List<ProvinceBean> provinces) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        long now = System.currentTimeMillis();
        db.beginTransaction();
        try {
            db.delete(CacheDbHelper.TABLE_REGION, null, null);
            int provinceIndex = 0;
            for (ProvinceBean province : provinces) {
                insertProvince(db, province, provinceIndex++, now);
                List<ProvinceBean.CityBean> cities = province.getCity();
                if (cities == null) {
                    continue;
                }

                int cityIndex = 0;
                for (ProvinceBean.CityBean city : cities) {
                    insertCity(db, province.getId(), city, cityIndex++, now);
                    List<ProvinceBean.CityBean.CountyBean> counties = city.getCounty();
                    if (counties == null) {
                        continue;
                    }

                    int countyIndex = 0;
                    for (ProvinceBean.CityBean.CountyBean county : counties) {
                        insertCounty(db, city.getId(), county, countyIndex++, now);
                    }
                }
            }
            db.setTransactionSuccessful();
        } finally {
            db.endTransaction();
        }
    }

    private List<ProvinceBean> queryProvinces() {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        Cursor cursor = db.query(CacheDbHelper.TABLE_REGION, null, "level=? AND parent_id=?",
                new String[]{"1", "0"}, null, null, "sort_index ASC, weigh ASC, id ASC");
        try {
            List<ProvinceBean> list = new ArrayList<>();
            while (cursor.moveToNext()) {
                ProvinceBean bean = new ProvinceBean();
                fillProvince(bean, cursor);
                list.add(bean);
            }
            return list;
        } finally {
            cursor.close();
        }
    }

    private List<ProvinceBean.CityBean> queryCities(String provinceId) {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        Cursor cursor = db.query(CacheDbHelper.TABLE_REGION, null, "level=? AND parent_id=?",
                new String[]{"2", provinceId}, null, null, "sort_index ASC, weigh ASC, id ASC");
        try {
            List<ProvinceBean.CityBean> list = new ArrayList<>();
            while (cursor.moveToNext()) {
                ProvinceBean.CityBean bean = new ProvinceBean.CityBean();
                fillCity(bean, cursor);
                list.add(bean);
            }
            return list;
        } finally {
            cursor.close();
        }
    }

    private List<ProvinceBean.CityBean.CountyBean> queryCounties(String cityId) {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        Cursor cursor = db.query(CacheDbHelper.TABLE_REGION, null, "level=? AND parent_id=?",
                new String[]{"3", cityId}, null, null, "sort_index ASC, weigh ASC, id ASC");
        try {
            List<ProvinceBean.CityBean.CountyBean> list = new ArrayList<>();
            while (cursor.moveToNext()) {
                ProvinceBean.CityBean.CountyBean bean = new ProvinceBean.CityBean.CountyBean();
                fillCounty(bean, cursor);
                list.add(bean);
            }
            return list;
        } finally {
            cursor.close();
        }
    }

    private void insertProvince(SQLiteDatabase db, ProvinceBean bean, int sortIndex, long now) {
        ContentValues values = buildCommonValues(bean.getId(), "0", bean.getCityid(), bean.getName(),
                1, bean.getInitial(), bean.getPinyin(), bean.getStatus(), bean.getWeigh(),
                bean.getIsnew(), sortIndex, now);
        db.insert(CacheDbHelper.TABLE_REGION, null, values);
    }

    private void insertCity(SQLiteDatabase db, String parentId, ProvinceBean.CityBean bean, int sortIndex, long now) {
        ContentValues values = buildCommonValues(bean.getId(), parentId, bean.getCityid(), bean.getName(),
                2, bean.getInitial(), bean.getPinyin(), bean.getStatus(), bean.getWeigh(),
                bean.getIsnew(), sortIndex, now);
        db.insert(CacheDbHelper.TABLE_REGION, null, values);
    }

    private void insertCounty(SQLiteDatabase db, String parentId, ProvinceBean.CityBean.CountyBean bean,
                              int sortIndex, long now) {
        ContentValues values = buildCommonValues(bean.getId(), parentId, bean.getCityid(), bean.getName(),
                3, bean.getInitial(), bean.getPinyin(), bean.getStatus(), bean.getWeigh(),
                bean.getIsnew(), sortIndex, now);
        db.insert(CacheDbHelper.TABLE_REGION, null, values);
    }

    private ContentValues buildCommonValues(String id, String parentId, String regionCode, String name,
                                            int level, String initial, String pinyin, int status,
                                            int weigh, int isNew, int sortIndex, long now) {
        ContentValues values = new ContentValues();
        values.put("id", id);
        values.put("parent_id", parentId);
        values.put("region_code", regionCode);
        values.put("name", name);
        values.put("level", level);
        values.put("initial", initial);
        values.put("pinyin", pinyin);
        values.put("status", status);
        values.put("weigh", weigh);
        values.put("is_new", isNew);
        values.put("sort_index", sortIndex);
        values.put("updated_at", now);
        return values;
    }

    private void fillProvince(ProvinceBean bean, Cursor cursor) {
        bean.setId(cursor.getString(cursor.getColumnIndexOrThrow("id")));
        bean.setCityid(cursor.getString(cursor.getColumnIndexOrThrow("region_code")));
        bean.setName(cursor.getString(cursor.getColumnIndexOrThrow("name")));
        bean.setInitial(cursor.getString(cursor.getColumnIndexOrThrow("initial")));
        bean.setPinyin(cursor.getString(cursor.getColumnIndexOrThrow("pinyin")));
        bean.setStatus(cursor.getInt(cursor.getColumnIndexOrThrow("status")));
        bean.setWeigh(cursor.getInt(cursor.getColumnIndexOrThrow("weigh")));
        bean.setIsnew(cursor.getInt(cursor.getColumnIndexOrThrow("is_new")));
    }

    private void fillCity(ProvinceBean.CityBean bean, Cursor cursor) {
        bean.setId(cursor.getString(cursor.getColumnIndexOrThrow("id")));
        bean.setCityid(cursor.getString(cursor.getColumnIndexOrThrow("region_code")));
        bean.setName(cursor.getString(cursor.getColumnIndexOrThrow("name")));
        bean.setInitial(cursor.getString(cursor.getColumnIndexOrThrow("initial")));
        bean.setPinyin(cursor.getString(cursor.getColumnIndexOrThrow("pinyin")));
        bean.setStatus(cursor.getInt(cursor.getColumnIndexOrThrow("status")));
        bean.setWeigh(cursor.getInt(cursor.getColumnIndexOrThrow("weigh")));
        bean.setIsnew(cursor.getInt(cursor.getColumnIndexOrThrow("is_new")));
    }

    private void fillCounty(ProvinceBean.CityBean.CountyBean bean, Cursor cursor) {
        bean.setId(cursor.getString(cursor.getColumnIndexOrThrow("id")));
        bean.setCityid(cursor.getString(cursor.getColumnIndexOrThrow("region_code")));
        bean.setName(cursor.getString(cursor.getColumnIndexOrThrow("name")));
        bean.setInitial(cursor.getString(cursor.getColumnIndexOrThrow("initial")));
        bean.setPinyin(cursor.getString(cursor.getColumnIndexOrThrow("pinyin")));
        bean.setStatus(cursor.getInt(cursor.getColumnIndexOrThrow("status")));
        bean.setWeigh(cursor.getInt(cursor.getColumnIndexOrThrow("weigh")));
        bean.setIsnew(cursor.getInt(cursor.getColumnIndexOrThrow("is_new")));
    }
}

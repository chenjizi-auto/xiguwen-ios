package com.linzi.xiguwen.cache.dao;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.linzi.xiguwen.cache.CacheDbHelper;

public class ApiCacheDao {

    private final CacheDbHelper dbHelper;

    public ApiCacheDao(Context context) {
        dbHelper = CacheDbHelper.getInstance(context);
    }

    public void save(String cacheKey, String apiPath, String paramsHash, String userScope,
                     String dataJson, String dataVersion, long expiredAt, long lastSuccessAt) {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        long now = System.currentTimeMillis();

        ContentValues values = new ContentValues();
        values.put("cache_key", cacheKey);
        values.put("api_path", apiPath);
        values.put("params_hash", paramsHash);
        values.put("user_scope", userScope);
        values.put("data_json", dataJson);
        values.put("data_version", dataVersion);
        values.put("expired_at", expiredAt);
        values.put("last_success_at", lastSuccessAt);
        values.put("created_at", now);
        values.put("updated_at", now);

        db.insertWithOnConflict(CacheDbHelper.TABLE_API_CACHE, null, values, SQLiteDatabase.CONFLICT_REPLACE);
    }

    public CacheRecord get(String cacheKey) {
        SQLiteDatabase db = dbHelper.getReadableDatabase();
        Cursor cursor = db.query(CacheDbHelper.TABLE_API_CACHE, null, "cache_key=?",
                new String[]{cacheKey}, null, null, null);
        try {
            if (!cursor.moveToFirst()) {
                return null;
            }

            CacheRecord record = new CacheRecord();
            record.cacheKey = cursor.getString(cursor.getColumnIndexOrThrow("cache_key"));
            record.apiPath = cursor.getString(cursor.getColumnIndexOrThrow("api_path"));
            record.dataJson = cursor.getString(cursor.getColumnIndexOrThrow("data_json"));
            record.expiredAt = cursor.getLong(cursor.getColumnIndexOrThrow("expired_at"));
            record.lastSuccessAt = cursor.getLong(cursor.getColumnIndexOrThrow("last_success_at"));
            return record;
        } finally {
            cursor.close();
        }
    }

    public boolean isExpired(CacheRecord record) {
        return record == null || System.currentTimeMillis() > record.expiredAt;
    }

    public static class CacheRecord {
        public String cacheKey;
        public String apiPath;
        public String dataJson;
        public long expiredAt;
        public long lastSuccessAt;
    }
}

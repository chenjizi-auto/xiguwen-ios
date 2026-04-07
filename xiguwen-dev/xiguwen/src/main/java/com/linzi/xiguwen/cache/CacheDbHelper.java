package com.linzi.xiguwen.cache;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class CacheDbHelper extends SQLiteOpenHelper {

    public static final String DB_NAME = "xiguwen_cache.db";
    public static final int DB_VERSION = 1;

    public static final String TABLE_REGION = "region";
    public static final String TABLE_API_CACHE = "api_cache";

    private static volatile CacheDbHelper sInstance;

    public static CacheDbHelper getInstance(Context context) {
        if (sInstance == null) {
            synchronized (CacheDbHelper.class) {
                if (sInstance == null) {
                    sInstance = new CacheDbHelper(context.getApplicationContext());
                }
            }
        }
        return sInstance;
    }

    private CacheDbHelper(Context context) {
        super(context, DB_NAME, null, DB_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE IF NOT EXISTS " + TABLE_REGION + " ("
                + "id TEXT NOT NULL PRIMARY KEY,"
                + "parent_id TEXT NOT NULL DEFAULT '0',"
                + "region_code TEXT,"
                + "name TEXT,"
                + "level INTEGER NOT NULL,"
                + "initial TEXT,"
                + "pinyin TEXT,"
                + "status INTEGER NOT NULL DEFAULT 0,"
                + "weigh INTEGER NOT NULL DEFAULT 0,"
                + "is_new INTEGER NOT NULL DEFAULT 0,"
                + "sort_index INTEGER NOT NULL DEFAULT 0,"
                + "updated_at INTEGER NOT NULL"
                + ")");

        db.execSQL("CREATE INDEX IF NOT EXISTS idx_region_parent_id ON " + TABLE_REGION + "(parent_id)");
        db.execSQL("CREATE INDEX IF NOT EXISTS idx_region_level ON " + TABLE_REGION + "(level)");
        db.execSQL("CREATE INDEX IF NOT EXISTS idx_region_name ON " + TABLE_REGION + "(name)");

        db.execSQL("CREATE TABLE IF NOT EXISTS " + TABLE_API_CACHE + " ("
                + "cache_key TEXT NOT NULL PRIMARY KEY,"
                + "api_path TEXT NOT NULL,"
                + "params_hash TEXT,"
                + "user_scope TEXT NOT NULL DEFAULT '0',"
                + "data_json TEXT NOT NULL,"
                + "data_version TEXT,"
                + "expired_at INTEGER NOT NULL DEFAULT 0,"
                + "last_success_at INTEGER NOT NULL DEFAULT 0,"
                + "created_at INTEGER NOT NULL,"
                + "updated_at INTEGER NOT NULL"
                + ")");

        db.execSQL("CREATE INDEX IF NOT EXISTS idx_api_cache_path ON " + TABLE_API_CACHE + "(api_path)");
        db.execSQL("CREATE INDEX IF NOT EXISTS idx_api_cache_user_scope ON " + TABLE_API_CACHE + "(user_scope)");
        db.execSQL("CREATE INDEX IF NOT EXISTS idx_api_cache_expired_at ON " + TABLE_API_CACHE + "(expired_at)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
    }
}

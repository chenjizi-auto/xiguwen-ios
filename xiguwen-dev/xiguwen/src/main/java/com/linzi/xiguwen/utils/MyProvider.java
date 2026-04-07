package com.linzi.xiguwen.utils;

import android.content.ContentValues;
import android.content.Context;
import android.content.pm.ProviderInfo;
import android.database.Cursor;
import android.net.Uri;
import android.os.ParcelFileDescriptor;
import androidx.core.content.FileProvider;

import java.io.FileNotFoundException;

/**
 * Created by jiang on 2018/2/12.
 */

public class MyProvider extends FileProvider {
    public MyProvider() {
        super();
    }

    @Override
    public boolean onCreate() {
        return super.onCreate();
    }

    @Override
    public void attachInfo(Context context, ProviderInfo info) {
        super.attachInfo(context, info);
    }

    @Override
    public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) {
        return super.query(uri, projection, selection, selectionArgs, sortOrder);
    }

    @Override
    public String getType(Uri uri) {
        return super.getType(uri);
    }

    @Override
    public Uri insert(Uri uri, ContentValues values) {
        return super.insert(uri, values);
    }

    @Override
    public int update(Uri uri, ContentValues values, String selection, String[] selectionArgs) {
        return super.update(uri, values, selection, selectionArgs);
    }

    @Override
    public int delete(Uri uri, String selection, String[] selectionArgs) {
        return super.delete(uri, selection, selectionArgs);
    }

    @Override
    public ParcelFileDescriptor openFile(Uri uri, String mode) throws FileNotFoundException {
        return super.openFile(uri, mode);
    }
}

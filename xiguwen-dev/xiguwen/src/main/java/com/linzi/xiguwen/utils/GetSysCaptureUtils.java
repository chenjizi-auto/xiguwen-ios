package com.linzi.xiguwen.utils;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import androidx.core.content.FileProvider;
import android.widget.Toast;

import java.io.File;

/**
 * Created by jiang on 2018/2/12.
 */

public class GetSysCaptureUtils {
    private Activity mContext;
    private Intent cameraIntent;
    private Uri contentUri;

    public GetSysCaptureUtils(Activity mContext) {
        this.mContext = mContext;
        cameraIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
    }
    public GetSysCaptureUtils setProvider(String provider_name,String img_path,String img_name){
        String state= Environment.getExternalStorageState();
        if (state.equals(Environment.MEDIA_MOUNTED)) {
            File imageDir = new File(img_path);
            if (!imageDir.exists()) {
                imageDir.mkdirs();
            }
            File img_file = new File(img_path, img_name);
            contentUri = FileProvider.getUriForFile(mContext, provider_name, img_file);
        }else{
            Toast.makeText(mContext,"未检测到内存卡",Toast.LENGTH_SHORT).show();
        }
        return this;
    }

    public GetSysCaptureUtils getPhoto(int code){
        if (cameraIntent.resolveActivity(mContext.getPackageManager()) != null) {
            com.linzi.xiguwen.utils.LogUtil.d("provider_path", "showCameraAction: "+contentUri.toString());
            cameraIntent.putExtra(MediaStore.EXTRA_OUTPUT, contentUri);
            mContext.startActivityForResult(cameraIntent,code);
        }
        return this;
    }
}

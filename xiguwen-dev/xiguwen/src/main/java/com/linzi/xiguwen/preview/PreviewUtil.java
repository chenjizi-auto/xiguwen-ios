package com.linzi.xiguwen.preview;

import android.content.Context;
import android.text.TextUtils;

import com.linzi.xiguwen.utils.NToast;
import com.previewlibrary.enitity.IThumbViewInfo;

import java.util.List;

/**
 * Guard preview activity when there is no valid image.
 */
public final class PreviewUtil {

    private PreviewUtil() {
    }

    public static boolean canPreview(Context context, List<? extends IThumbViewInfo> list, int index) {
        if (list == null || list.isEmpty()) {
            NToast.show("No image");
            return false;
        }
        if (index < 0 || index >= list.size()) {
            NToast.show("No image");
            return false;
        }
        IThumbViewInfo item = list.get(index);
        if (item == null) {
            NToast.show("No image");
            return false;
        }
        String url = item.getUrl();
        String videoUrl = item.getVideoUrl();
        if (TextUtils.isEmpty(url) && TextUtils.isEmpty(videoUrl)) {
            NToast.show("No image");
            return false;
        }
        return true;
    }
}

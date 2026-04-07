package com.linzi.xiguwen.utils;

import android.content.Context;
import android.content.Intent;


import java.util.ArrayList;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/29  14:46
 *
 * @author luyongjiang
 * @version 1.0
 */
public class BrowserUtils {
    public static void intentToBrowser(Context context, ArrayList<String> arrayList, int position) {
        FullScreenUtil.showFullScreenDialog(context,position,arrayList);
    }
}

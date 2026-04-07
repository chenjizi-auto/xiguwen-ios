package com.linzi.xiguwen.utils.location;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

import com.linzi.xiguwen.ui.NewBaijiaDetailsActivity;
import com.linzi.xiguwen.ui.NewExampleDetailsActivity;
import com.linzi.xiguwen.ui.NewGoodsDetailsActivity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.ui.NewShopMallDetailsActivity;
import com.linzi.xiguwen.ui.WenzhangDetailsActivity;
import com.linzi.xiguwen.utils.NToast;

/**
 * Created by pc on 2018/4/2.
 */

public class JumpUtil {

    /**
     * @param aptid  intent传参
     * @param aptype 1婚庆商家，2商城商家，3案例，5商品，6报价
     * @param src    H5地址
     */
    public static void judgeJump(Context context, int aptid, int aptype, String src) {
        Intent intent = null;
        if (src != null && !src.equals("")) {//H5跳转
            intent = new Intent(context, WenzhangDetailsActivity.class);
            intent.putExtra("url", src);
            intent.putExtra("isShowShare", false);//是否显示分享
        } else {//原生跳转

            switch (aptype) {
                case 1:
                    intent = new Intent(context, NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", aptid);
                    break;
                case 2:
                    intent = new Intent(context, NewShopMallDetailsActivity.class);
                    intent.putExtra("shop_id", aptid);
                    break;
                case 3:
                    intent = new Intent(context, NewExampleDetailsActivity.class);
                    intent.putExtra("caseid", aptid);
                    break;
                case 5:
                    intent = new Intent(context, NewGoodsDetailsActivity.class);
                    intent.putExtra("goods_id", aptid);
                    break;
                case 6:
                    intent = new Intent(context, NewBaijiaDetailsActivity.class);
                    intent.putExtra("offoer_id", aptid);
                    break;

                default:
                    NToast.show("抱歉跳转参数错误！");
            }

        }
        if (intent != null)
            context.startActivity(intent);
    }

    public static void judgeJump(Context context, int adid, String src, Class<?> activity, String color, String title,int types) {
        Intent intent = null;
        if (src != null && !src.equals("")) {//H5跳转
            intent = new Intent(context, WenzhangDetailsActivity.class);
            intent.putExtra("url", src);
            intent.putExtra("isShowShare", false);//是否显示分享
        } else {
            intent = new Intent(context, activity);
            intent.putExtra("adid", adid);
            intent.putExtra("color", color);//recycleview color
            intent.putExtra("title", title);//topbar title
            intent.putExtra("types",types);

        }
        if (intent != null)
            context.startActivity(intent);
    }

    public static void judgeJump(Context context, int adid, String src, Class<?> activity, String title,int types) {
        Intent intent = null;
        if (src != null && !src.equals("")) {//H5跳转
            intent = new Intent(context, WenzhangDetailsActivity.class);
            intent.putExtra("url", src);
            intent.putExtra("isShowShare", false);//是否显示分享
        } else {
            intent = new Intent(context, activity);
            intent.putExtra("adid", adid);
            intent.putExtra("title", title);//topbar title
            intent.putExtra("types",types);
        }
        if (intent != null)
            context.startActivity(intent);
    }
}

package com.linzi.xiguwen.utils;

import android.Manifest;
import android.app.Dialog;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Point;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.FragmentActivity;
import androidx.viewpager.widget.ViewPager;

import com.bumptech.glide.Glide;
import com.bumptech.glide.request.target.SimpleTarget;
import com.bumptech.glide.request.transition.Transition;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ImgVPAdapter;
import com.linzi.xiguwen.ui.NewCreateElectronicinvitationActivity;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.utils.ToastUtils;
import java.util.List;
/**
 * 看大图
 */
public class FullScreenUtil {

    public static void showFullScreenDialog(Context context, final int pos, final List<String> imgList) {
        showDialog(context, pos, imgList,false);
    }

    public static void showFullScreenDialog(Context context, final int pos, final List<String> imgList,boolean hideSave) {
        showDialog(context, pos, imgList,hideSave);
    }

    private static void showDialog(Context context, int pos, List<String> imgList,boolean hideSave) {
        final int[] a = {pos};
        final Dialog dialog = new Dialog(context, R.style.big_pic_dialog);
        //设置是否允许Dialog可以被点击取消,也会阻止Back键
        dialog.setCancelable(true);
        dialog.setCanceledOnTouchOutside(true);
        Window window = dialog.getWindow();
        window.setGravity(Gravity.CENTER);
        //获取Dialog窗体的根容器
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        ViewGroup root = (ViewGroup) dialog.getWindow().getDecorView().findViewById(android.R.id.content);
        //设置窗口大小为屏幕大小
        WindowManager wm = (WindowManager) context.getApplicationContext().getSystemService(Context.WINDOW_SERVICE);
        Point screenSize = new Point();
        wm.getDefaultDisplay().getSize(screenSize);
        root.setLayoutParams(new LinearLayout.LayoutParams(screenSize.x, screenSize.y));
        //  获取自定义布局,并设置给Dialog
        View view = inflater.inflate(R.layout.pop_photo_vp, root, false);
        final ViewPager img_vp = view.findViewById(R.id.img_vp);
        final TextView img_num_iv = view.findViewById(R.id.img_num_iv);
        final TextView img_down_iv = view.findViewById(R.id.img_down_iv);
        if (hideSave){
            img_down_iv.setVisibility(View.GONE);
        }
        view.setOnClickListener(v -> dialog.dismiss());
        ImgVPAdapter vpAdapter = new ImgVPAdapter(context, imgList);
        img_vp.setAdapter(vpAdapter);
        img_vp.setCurrentItem(pos,true);
        img_num_iv.setText((pos + 1) + "/" + imgList.size());
        img_vp.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(final int position) {
                img_num_iv.setText((position + 1) + "/" + imgList.size());
                a[0] =position;
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });

        img_down_iv.setOnClickListener(v -> {

            XXPermissions.with(context)
                    .permission(Permission.CAMERA,Permission.MANAGE_EXTERNAL_STORAGE)
                    .request(new OnPermissionCallback() {
                        @Override
                        public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                            if (!allGranted){
                                ToastUtils.showToast(context, "保存失败，无存储权限。");
                            }else {
                                Glide.with(context).asBitmap().load(imgList.get(a[0])).into(new SimpleTarget<Bitmap>() {
                                    @Override
                                    public void onResourceReady(@NonNull Bitmap bitmap, @Nullable Transition<? super Bitmap> transition) {
                                        ImageSaveUtil.saveAlbum(context, bitmap, Bitmap.CompressFormat.JPEG, 100, false);
                                    }
                                });
                            }
                        }

                        @Override
                        public void onDenied(@NonNull List<String> permissions, boolean doNotAskAgain) {
                            if (doNotAskAgain) {
                                ToastUtils.showToast(context,"被永久拒绝授权，请手动授予相机权限");
                                // 如果是被永久拒绝就跳转到应用权限系统设置页面
                                XXPermissions.startPermissionActivity(context, permissions);
                            } else {
                                ToastUtils.showToast(context,"获取存储权限失败");
                            }
                        }
                    });


            if (imgList.get(a[0]) != null) {
                XXPermissions.with(context)
                        .permission(Permission.CAMERA,Permission.MANAGE_EXTERNAL_STORAGE)
                        .request(new OnPermissionCallback() {
                            @Override
                            public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                                if (!allGranted){
                                    ToastUtils.showToast(context, "保存失败，无存储权限。");
                                }else {
                                    Glide.with(context).asBitmap().load(imgList.get(a[0])).into(new SimpleTarget<Bitmap>() {
                                        @Override
                                        public void onResourceReady(@NonNull Bitmap bitmap, @Nullable Transition<? super Bitmap> transition) {
                                            ImageSaveUtil.saveAlbum(context, bitmap, Bitmap.CompressFormat.JPEG, 100, false);
                                        }
                                    });
                                }
                            }
                            @Override
                            public void onDenied(@NonNull List<String> permissions, boolean doNotAskAgain) {
                                if (doNotAskAgain) {
                                    ToastUtils.showToast(context,"被永久拒绝授权，请手动授予相机权限");
                                    // 如果是被永久拒绝就跳转到应用权限系统设置页面
                                    XXPermissions.startPermissionActivity(context, permissions);
                                } else {
                                    ToastUtils.showToast(context,"获取存储权限失败");
                                }
                            }
                        });
            }
        });

        vpAdapter.setAllClickListener(new ImgVPAdapter.AllClickListener() {
            @Override
            public void allclick(int pos) {
                dialog.dismiss();
            }

            @Override
            public void alllongclick(int pos,View v) {

            }
        });

        dialog.setContentView(view);
        dialog.show();
    }

//    private static void showPop(Context context, View v, String url) {
//
//        PopupWindow popupWindow = new PopupWindow(context);
//        View inflate = LayoutInflater.from(context).inflate(R.layout.pop_save_item, null);
//        inflate.findViewById(R.id.pop_dis).setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                popupWindow.dismiss();
//            }
//        });
//        inflate.findViewById(R.id.pop_save).setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                popupWindow.dismiss();
//
//            }
//        });
//        popupWindow.setWidth(ViewGroup.LayoutParams.MATCH_PARENT);
//        popupWindow.setHeight(ViewGroup.LayoutParams.MATCH_PARENT);
//        popupWindow.setContentView(inflate);
//        popupWindow.showAtLocation(v,Gravity.BOTTOM,0,0);
//
//    }

}

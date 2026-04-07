package com.linzi.xiguwen.utils;

import android.view.View;

import java.util.ArrayList;

/**
 * Created by jiang on 2017/11/22.
 */

public class CallBack {
    /**
     * 自定义接口
     */
    public interface OnMenuItemClickListener {
        /**
         * 接口方法
         *
         * @param position 接口返参
         */
        public void itemClick(int position);

        public void itemClick(int position,String name);
    }

    public interface MainMenuClick {
        public void itemClick(int id);
    }

    public interface FayangaoEditListener {
        public void editListener(int id);
    }

    public interface FayangaoDelListener {
        public void delListener(int id);
    }

    public interface ImgClickListener {
        public void imgListener(int id);
    }

    public interface ChooseGoodsListener {
        public void chooseListener(int position, boolean in);
    }

    public interface PingjiaListener {
        public void pingjia(View view, int in);
    }

    public interface TuikuanListener {
        public void tuikuan(View view, int in);
    }

    public interface TuikuanDetailsListener {
        public void tuikuanDetails(View view, int in);
    }

    public interface EditPriceListener {
        public void editPrice(View view, int in);
    }

    public interface JiedanListener {
        public void jiedan(View view, int in);
    }

    public interface ComleteListener {
        public void complete(View view, int in);
    }

    public interface ComleteTypeListener {
        public void completeType(int in);
    }

    public interface TuikuanClickListener {
        public void TuikuanClick(int in);
    }

    public interface FahuoListener {
        public void fahuo(int in);
    }

    public interface EditListener {
        public void edit(int in);
    }

    public interface CloseListener {
        public void close(int in);
    }

    public interface DelListener {
        public void del(int in);
    }

    public interface MoreListener {
        public void more(int in);
    }

    public interface CaseCareClikListener {
        public void CaseCareClik(int postion);
    }

    public interface CaseUserClikListener {
        public void CaseUserClik(int postion);
    }

}

package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/6/25.
 */

public class QingJianMainBean {
    List<PageBean> pageBeans;

    public List<PageBean> getPageBeans() {
        return pageBeans;
    }

    public void setPageBeans(List<PageBean> pageBeans) {
        this.pageBeans = pageBeans;
    }

    public static class PageBean {

        List<TextBean> textBeans;
        List<ImageBean> imageBeans;
        BackgroundBean backgroundBean;

        public List<TextBean> getTextBeans() {
            return textBeans;
        }

        public void setTextBeans(List<TextBean> textBeans) {
            this.textBeans = textBeans;
        }

        public List<ImageBean> getImageBeans() {
            return imageBeans;
        }

        public void setImageBeans(List<ImageBean> imageBeans) {
            this.imageBeans = imageBeans;
        }

        public BackgroundBean getBackgroundBean() {
            return backgroundBean;
        }

        public void setBackgroundBean(BackgroundBean backgroundBean) {
            this.backgroundBean = backgroundBean;
        }

        public static class TextBean {
            //                    "type":1,//type:1是背景  2是文字，3是图片
//                    "left":0,//距离左边
//                    "top":0,//距离上边
//                    "shape":"",//1是圆形，2是正方形，3是长方形
//                    "size":"",//字体大小
//                    "color":"",//字体颜色
//                    "width":"",//宽度
//                    "height":"",//高度
//                    "layer":1,//层级，数字越大层级越高
//                    "sort":2,//当页的第几个数据
//                    "value":"[图片]http://yiniu.qanlian.com/s/b2.jpg "//值
//                    "banckground":"[图片]http://yiniu.qanlian.com/s/b2.jpg ",//背景图
//                    "page":2,//页码，第几页
//                    "textnum":2,//当页有几条文字数据
//                    "imgnum":1//当页有几条图片数据
//                    "zwidth":375,//屏幕宽度
//                    "zheight":667,//屏幕高度
//                    "zpage":7,//总页数
//                    "text-align":center//文字居中 //left文字居左 //right文字居右
//                    "padding":12//文字距离父边框的高度
//                    "time":1,//是否是时间1是0否
//                    "address":0,//是否是地址1是0否
            private int id;
            private String value;
            private float top;
            private float left;
            private float padding;
            private float width;
            private int time;
            private float size;
            private String color;
            private String textAlign;
            private float height;
            private String address;
            private int unitid;
            private float lineHeight;

            public float getLineHeight() {
                return lineHeight;
            }

            public void setLineHeight(float lineHeight) {
                this.lineHeight = lineHeight;
            }

            public int getUnitid() {
                return unitid;
            }

            public void setUnitid(int unitid) {
                this.unitid = unitid;
            }

            public int getId() {
                return id;
            }

            public void setId(int id) {
                this.id = id;
            }

            public String getValue() {
                return value;
            }

            public void setValue(String value) {
                this.value = value;
            }

            public float getTop() {
                return top;
            }

            public void setTop(float top) {
                this.top = top;
            }

            public float getLeft() {
                return left;
            }

            public void setLeft(float left) {
                this.left = left;
            }

            public float getPadding() {
                return padding;
            }

            public void setPadding(float padding) {
                this.padding = padding;
            }

            public float getWidth() {
                return width;
            }

            public void setWidth(float width) {
                this.width = width;
            }

            public int getTime() {
                return time;
            }

            public void setTime(int time) {
                this.time = time;
            }

            public float getSize() {
                return size;
            }

            public void setSize(float size) {
                this.size = size;
            }

            public String getColor() {
                return color;
            }

            public void setColor(String color) {
                this.color = color;
            }

            public String getTextAlign() {
                return textAlign;
            }

            public void setTextAlign(String textAlign) {
                this.textAlign = textAlign;
            }

            public float getHeight() {
                return height;
            }

            public void setHeight(float height) {
                this.height = height;
            }

            public String getAddress() {
                return address;
            }

            public void setAddress(String address) {
                this.address = address;
            }
        }

        public static class ImageBean {
            private int id;
            private String value;
            private float top;
            private float left;
            private float width;
            private float height;
            private int shape;
            private int unitid;

            public int getUnitid() {
                return unitid;
            }

            public void setUnitid(int unitid) {
                this.unitid = unitid;
            }


            public int getId() {
                return id;
            }

            public void setId(int id) {
                this.id = id;
            }

            public String getValue() {
                return value;
            }

            public void setValue(String value) {
                this.value = value;
            }

            public float getTop() {
                return top;
            }

            public void setTop(float top) {
                this.top = top;
            }

            public float getLeft() {
                return left;
            }

            public void setLeft(float left) {
                this.left = left;
            }

            public float getWidth() {
                return width;
            }

            public void setWidth(float width) {
                this.width = width;
            }

            public float getHeight() {
                return height;
            }

            public void setHeight(float height) {
                this.height = height;
            }

            public int getShape() {
                return shape;
            }

            public void setShape(int shape) {
                this.shape = shape;
            }
        }

        public static class BackgroundBean {
            private String value;
            private int unitid;

            public int getUnitid() {
                return unitid;
            }

            public void setUnitid(int unitid) {
                this.unitid = unitid;
            }

            public String getValue() {
                return value;
            }

            public void setValue(String value) {
                this.value = value;
            }
        }
    }
}

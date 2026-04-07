package com.linzi.xiguwen.adapter;


public class CardItem {

//    private int mTextResource;
//    private int mTitleResource;
//
//    public CardItem(int title, int text) {
//        mTitleResource = title;
//        mTextResource = text;
//    }
//
//    public int getText() {
//        return mTextResource;
//    }
//
//    public int getTitle() {
//        return mTitleResource;
//    }

    private String imgResource;
    private int index;

    public CardItem(String imgResource, int index) {
        this.imgResource = imgResource;
        this.index = index;
    }

    public String getImgResource() {
        return imgResource;
    }

    public void setImgResource(String imgResource) {
        this.imgResource = imgResource;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }
}

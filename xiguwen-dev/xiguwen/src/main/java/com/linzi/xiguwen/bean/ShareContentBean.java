package com.linzi.xiguwen.bean;

import android.os.Parcel;
import android.os.Parcelable;

/**
 * Created by pc on 2018/4/27.
 */

public class ShareContentBean implements Parcelable {

    /**
     * url : http://www.boyihunjia.com/wap/wedding/business/id/16.html
     * image : https://www.boyihunjia.com/home/default/boyi.png
     * title : 杜卡基老师
     * descr : 杜卡基老师
     */

    private String url;
    private String image;
    private String title;
    private String descr;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(this.url);
        dest.writeString(this.image);
        dest.writeString(this.title);
        dest.writeString(this.descr);
    }

    public ShareContentBean() {
    }

    protected ShareContentBean(Parcel in) {
        this.url = in.readString();
        this.image = in.readString();
        this.title = in.readString();
        this.descr = in.readString();
    }

    public static final Parcelable.Creator<ShareContentBean> CREATOR = new Parcelable.Creator<ShareContentBean>() {
        @Override
        public ShareContentBean createFromParcel(Parcel source) {
            return new ShareContentBean(source);
        }

        @Override
        public ShareContentBean[] newArray(int size) {
            return new ShareContentBean[size];
        }
    };
}

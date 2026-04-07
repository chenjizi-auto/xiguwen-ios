package com.linzi.xiguwen.bean;

import android.graphics.Rect;
import android.os.Parcel;
import androidx.annotation.Nullable;

import com.previewlibrary.enitity.IThumbViewInfo;

import java.util.List;

/**
 * Created by pc on 2018/3/27.
 */

public class WeddingRingBean {

    /**
     * id : 30
     * content : 因为相爱，每一天都是良辰吉日；因为相爱，即使只为你唱一首歌也是一种仪式。<img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/52.gif' /><img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/62.gif' />
     * create_ti : 2018-01-13 15:41:34
     * userid : 16
     * pv : 45
     * zan : 140
     * nickname : 杜卡基老师
     * head : http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg
     * commentnum : 10
     * theteam : 杜卡基老师婚庆团队
     * photourl : [{"id":48,"mydynamicid":30,"photourl":"http://www.boyihunjia.com/uploads/20180113/d2b8d13a8c16dad64468026f2ee0e996.jpg"},{"id":45,"mydynamicid":30,"photourl":"http://www.boyihunjia.com/uploads/20180113/2427dca682547c0c72f574945e93c0ca.jpg"},{"id":46,"mydynamicid":30,"photourl":"http://www.boyihunjia.com/uploads/20180113/b8c3bd146e52407a6b3bee2e8c4da1b7.jpg"},{"id":47,"mydynamicid":30,"photourl":"http://www.boyihunjia.com/uploads/20180113/8f811b0c2bfe63914f7677d71ead4b37.jpg"}]
     * follow : 0
     */

    private int id;
    private String content;
    private String create_ti;
    private int userid;
    private int pv;
    private int zan;
    private String nickname;
    private String head;
    private int commentnum;
    private String theteam;
    private int follow;
    private String occupation;
    private String occupationid;
    private List<PhotourlBean> photourl;
    private int shifouzan;

    public int getShifouzan() {
        return shifouzan;
    }

    public void setShifouzan(int shifouzan) {
        this.shifouzan = shifouzan;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public String getOccupationid() {
        return occupationid;
    }

    public void setOccupationid(String occupationid) {
        this.occupationid = occupationid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreate_ti() {
        return create_ti;
    }

    public void setCreate_ti(String create_ti) {
        this.create_ti = create_ti;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getPv() {
        return pv;
    }

    public void setPv(int pv) {
        this.pv = pv;
    }

    public int getZan() {
        return zan;
    }

    public void setZan(int zan) {
        this.zan = zan;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public int getCommentnum() {
        return commentnum;
    }

    public void setCommentnum(int commentnum) {
        this.commentnum = commentnum;
    }

    public String getTheteam() {
        return theteam;
    }

    public void setTheteam(String theteam) {
        this.theteam = theteam;
    }

    public int getFollow() {
        return follow;
    }

    public void setFollow(int follow) {
        this.follow = follow;
    }

    public List<PhotourlBean> getPhotourl() {
        return photourl;
    }

    public void setPhotourl(List<PhotourlBean> photourl) {
        this.photourl = photourl;
    }

    public static class PhotourlBean implements IThumbViewInfo {
        /**
         * id : 48
         * mydynamicid : 30
         * photourl : http://www.boyihunjia.com/uploads/20180113/d2b8d13a8c16dad64468026f2ee0e996.jpg
         */

        private int id;
        private int mydynamicid;
        private String photourl;
        private Rect bounds;


        protected PhotourlBean(Parcel in) {
            id = in.readInt();
            mydynamicid = in.readInt();
            photourl = in.readString();
            bounds = in.readParcelable(Rect.class.getClassLoader());
        }

        public static final Creator<PhotourlBean> CREATOR = new Creator<PhotourlBean>() {
            @Override
            public PhotourlBean createFromParcel(Parcel in) {
                return new PhotourlBean(in);
            }

            @Override
            public PhotourlBean[] newArray(int size) {
                return new PhotourlBean[size];
            }
        };

        @Override
        public String getUrl() {
            return photourl;
        }

        public Rect getBounds() {
            return bounds;
        }

        @Nullable
        @Override
        public String getVideoUrl() {
            return null;
        }

        public void setBounds(Rect bounds) {
            this.bounds = bounds;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getMydynamicid() {
            return mydynamicid;
        }

        public void setMydynamicid(int mydynamicid) {
            this.mydynamicid = mydynamicid;
        }

        public String getPhotourl() {
            return photourl;
        }

        public void setPhotourl(String photourl) {
            this.photourl = photourl;
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel dest, int flags) {
            dest.writeInt(id);
            dest.writeInt(mydynamicid);
            dest.writeString(photourl);
            dest.writeParcelable(bounds, flags);
        }
    }
}

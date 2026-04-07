package com.linzi.xiguwen.fragment.shop.model.bean;

import android.graphics.Rect;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;

import com.previewlibrary.enitity.IThumbViewInfo;

import java.util.List;

/**
 * Created by pc on 2018/3/30.
 */

public class DongTaiBean {

    /**
     * dongtai : [{"id":20,"content":"你，一袭白纱，宛如皎洁明月，像一滴晶莹的雨露；似一只洁白的玉兔，悄然飘落在人间，融于手心，暖入我心[em_6][em_6]","create_ti":"2018-01-12 00:04:43","userid":16,"pv":23,"zan":12,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","commentnum":4,"contentm":"你，一袭白纱，宛如皎洁明月，像一滴晶莹的雨露；似一只洁白的玉兔，悄然飘落在人间，融于手心，暖入我心http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif ","contentmw":"你，一袭白纱，宛如皎洁明月，像一滴晶莹的雨露；似一只洁白的玉兔，悄然飘落在人间，融于手心，暖入我心","theteam":"杜卡基老师婚庆团队","photourl":[{"id":17,"mydynamicid":20,"photourl":"http://www.boyihunjia.com/uploads/20180112/dd1c765224a15560e0c66b677026e0d4.jpg"},{"id":18,"mydynamicid":20,"photourl":"http://www.boyihunjia.com/uploads/20180112/1a9f2462c33920be0d05719e1b717304.jpg"},{"id":19,"mydynamicid":20,"photourl":"http://www.boyihunjia.com/uploads/20180112/d133ad0a072479f1c23520abb269c9cf.jpg"},{"id":20,"mydynamicid":20,"photourl":"http://www.boyihunjia.com/uploads/20180112/b88ca04b755c51054cbc7e7edd4e7db6.jpg"},{"id":21,"mydynamicid":20,"photourl":"http://www.boyihunjia.com/uploads/20180112/e98c24a5d3e04471dc9324fc98ccb464.jpg"}]},{"id":21,"content":"遇见你之后，我的生命里从此阳光烂漫[em_13][em_13][em_13][em_13]","create_ti":"2018-01-13 09:39:39","userid":16,"pv":3,"zan":1,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","commentnum":0,"contentm":"遇见你之后，我的生命里从此阳光烂漫http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/13.gif http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/13.gif http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/13.gif http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/13.gif ","contentmw":"遇见你之后，我的生命里从此阳光烂漫","theteam":"杜卡基老师婚庆团队","photourl":[{"id":22,"mydynamicid":21,"photourl":"http://www.boyihunjia.com/uploads/20180113/83b4a053eef2dadb0328609e1e55023c.jpg"},{"id":23,"mydynamicid":21,"photourl":"http://www.boyihunjia.com/uploads/20180113/233d86f29b68fdf745e668a4cc06f88c.jpg"}]}]
     * num : 14
     */

    private int num;
    private List<DongtaiBean> dongtai;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<DongtaiBean> getDongtai() {
        return dongtai;
    }

    public void setDongtai(List<DongtaiBean> dongtai) {
        this.dongtai = dongtai;
    }

    public static class DongtaiBean implements Parcelable {
        /**
         * id : 20
         * content : 你，一袭白纱，宛如皎洁明月，像一滴晶莹的雨露；似一只洁白的玉兔，悄然飘落在人间，融于手心，暖入我心[em_6][em_6]
         * create_ti : 2018-01-12 00:04:43
         * userid : 16
         * pv : 23
         * zan : 12
         * nickname : 杜卡基老师
         * head : http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg
         * commentnum : 4
         * contentm : 你，一袭白纱，宛如皎洁明月，像一滴晶莹的雨露；似一只洁白的玉兔，悄然飘落在人间，融于手心，暖入我心http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif
         * contentmw : 你，一袭白纱，宛如皎洁明月，像一滴晶莹的雨露；似一只洁白的玉兔，悄然飘落在人间，融于手心，暖入我心
         * theteam : 杜卡基老师婚庆团队
         * photourl : [{"id":17,"mydynamicid":20,"photourl":"http://www.boyihunjia.com/uploads/20180112/dd1c765224a15560e0c66b677026e0d4.jpg"},{"id":18,"mydynamicid":20,"photourl":"http://www.boyihunjia.com/uploads/20180112/1a9f2462c33920be0d05719e1b717304.jpg"},{"id":19,"mydynamicid":20,"photourl":"http://www.boyihunjia.com/uploads/20180112/d133ad0a072479f1c23520abb269c9cf.jpg"},{"id":20,"mydynamicid":20,"photourl":"http://www.boyihunjia.com/uploads/20180112/b88ca04b755c51054cbc7e7edd4e7db6.jpg"},{"id":21,"mydynamicid":20,"photourl":"http://www.boyihunjia.com/uploads/20180112/e98c24a5d3e04471dc9324fc98ccb464.jpg"}]
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
        private String contentm;
        private String contentmw;
        private String theteam;
        private List<PhotourlBean> photourl;
        private String occupation;

        public String getOccupation() {
            return occupation;
        }

        public void setOccupation(String occupation) {
            this.occupation = occupation;
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

        public String getContentm() {
            return contentm;
        }

        public void setContentm(String contentm) {
            this.contentm = contentm;
        }

        public String getContentmw() {
            return contentmw;
        }

        public void setContentmw(String contentmw) {
            this.contentmw = contentmw;
        }

        public String getTheteam() {
            return theteam;
        }

        public void setTheteam(String theteam) {
            this.theteam = theteam;
        }

        public List<PhotourlBean> getPhotourl() {
            return photourl;
        }

        public void setPhotourl(List<PhotourlBean> photourl) {
            this.photourl = photourl;
        }

        public DongtaiBean() {
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeTypedList(this.photourl);
        }

        protected DongtaiBean(Parcel in) {

            this.photourl = in.createTypedArrayList(PhotourlBean.CREATOR);

        }

        public static final Creator<DongtaiBean> CREATOR = new Creator<DongtaiBean>() {
            @Override
            public DongtaiBean createFromParcel(Parcel source) {
                return new DongtaiBean(source);
            }

            @Override
            public DongtaiBean[] newArray(int size) {
                return new DongtaiBean[size];
            }
        };

        public static class PhotourlBean implements IThumbViewInfo {
            /**
             * id : 17
             * mydynamicid : 20
             * photourl : http://www.boyihunjia.com/uploads/20180112/dd1c765224a15560e0c66b677026e0d4.jpg
             */

            private String photourl;
            private Rect bounds;

            public String getPhotourl() {
                return photourl;
            }

            public void setPhotourl(String photourl) {
                this.photourl = photourl;
            }

            public PhotourlBean() {
            }


            public void setUrl(String url) {
                photourl = url;
            }

            @Override
            public String getUrl() {
                return photourl;
            }

            public void setBounds(Rect bounds) {
                this.bounds = bounds;
            }

            @Override
            public Rect getBounds() {
                return bounds;
            }

            @Nullable
            @Override
            public String getVideoUrl() {
                return null;
            }

            @Override
            public int describeContents() {
                return 0;
            }

            @Override
            public void writeToParcel(Parcel parcel, int i) {
                parcel.writeString(this.photourl);
                parcel.writeParcelable(this.bounds, i);
            }

            protected PhotourlBean(Parcel in) {
                this.photourl = in.readString();
                this.bounds = in.readParcelable(Rect.class.getClassLoader());
            }

            public static final Creator<PhotourlBean> CREATOR = new Creator<PhotourlBean>() {
                @Override
                public PhotourlBean createFromParcel(Parcel source) {
                    return new PhotourlBean(source);
                }

                @Override
                public PhotourlBean[] newArray(int size) {
                    return new PhotourlBean[size];
                }
            };
        }
    }
}

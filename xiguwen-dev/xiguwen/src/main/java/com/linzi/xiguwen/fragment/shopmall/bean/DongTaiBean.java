package com.linzi.xiguwen.fragment.shopmall.bean;

import android.graphics.Rect;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;

import com.previewlibrary.enitity.IThumbViewInfo;

import java.util.List;

/**
 * Created by pc on 2018/4/8.
 */

public class DongTaiBean {
    /**
     * data : [{"id":40,"content":"于千万人中遇见你，于千万年中遇见你，没有早一步，没有晚一步，就这样赶上了，美美的婚嫁礼服来了哦，需要的赶紧下单吧！<img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/3.gif' /><img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/3.gif' />","create_ti":"2018-02-08 12:03:47","userid":67,"pv":4,"zan":1,"nickname":"博艺婚嫁自营店","head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","commentnum":0,"contentm":"于千万人中遇见你，于千万年中遇见你，没有早一步，没有晚一步，就这样赶上了，美美的婚嫁礼服来了哦，需要的赶紧下单吧！http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/3.gif http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/3.gif ","contentmw":"于千万人中遇见你，于千万年中遇见你，没有早一步，没有晚一步，就这样赶上了，美美的婚嫁礼服来了哦，需要的赶紧下单吧！","theteam":"","photourl":[{"id":69,"mydynamicid":40,"photourl":"http://www.boyihunjia.com/uploads/20180208/7032ba588dd8f5f4588011ae4e4af975.jpg"},{"id":70,"mydynamicid":40,"photourl":"http://www.boyihunjia.com/uploads/20180208/26bddd5331f1a55cbe4aacd14f308bca.jpg"},{"id":71,"mydynamicid":40,"photourl":"http://www.boyihunjia.com/uploads/20180208/e2d004d867c3ba29da2d6b502024e12f.jpg"}],"follow":0},{"id":39,"content":"我爱你，时光无阻，所以如果你爱我，一定要风雨无阻。借我一生，与你看尽人间山水！新品，新品，看过来了哦！<img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif' /><img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif' />","create_ti":"2018-02-08 12:02:33","userid":67,"pv":3,"zan":0,"nickname":"博艺婚嫁自营店","head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","commentnum":0,"contentm":"我爱你，时光无阻，所以如果你爱我，一定要风雨无阻。借我一生，与你看尽人间山水！新品，新品，看过来了哦！http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif ","contentmw":"我爱你，时光无阻，所以如果你爱我，一定要风雨无阻。借我一生，与你看尽人间山水！新品，新品，看过来了哦！","theteam":"","photourl":[{"id":67,"mydynamicid":39,"photourl":"http://www.boyihunjia.com/uploads/20180208/fd81aa7113df9a7ad4ce82593aa0462f.jpg"},{"id":68,"mydynamicid":39,"photourl":"http://www.boyihunjia.com/uploads/20180208/0ae8d68ae4a4c60ea913162fd582f9e3.jpg"}],"follow":0}]
     * num : 2
     */

    private int num;
    private List<DataBean> data;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class DataBean implements Parcelable {
        /**
         * id : 40
         * content : 于千万人中遇见你，于千万年中遇见你，没有早一步，没有晚一步，就这样赶上了，美美的婚嫁礼服来了哦，需要的赶紧下单吧！<img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/3.gif' /><img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/3.gif' />
         * create_ti : 2018-02-08 12:03:47
         * userid : 67
         * pv : 4
         * zan : 1
         * nickname : 博艺婚嫁自营店
         * head : http://imgcache.boyihunjia.com/9769c201803120905146801.png
         * commentnum : 0
         * contentm : 于千万人中遇见你，于千万年中遇见你，没有早一步，没有晚一步，就这样赶上了，美美的婚嫁礼服来了哦，需要的赶紧下单吧！http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/3.gif http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/3.gif
         * contentmw : 于千万人中遇见你，于千万年中遇见你，没有早一步，没有晚一步，就这样赶上了，美美的婚嫁礼服来了哦，需要的赶紧下单吧！
         * theteam :
         * photourl : [{"id":69,"mydynamicid":40,"photourl":"http://www.boyihunjia.com/uploads/20180208/7032ba588dd8f5f4588011ae4e4af975.jpg"},{"id":70,"mydynamicid":40,"photourl":"http://www.boyihunjia.com/uploads/20180208/26bddd5331f1a55cbe4aacd14f308bca.jpg"},{"id":71,"mydynamicid":40,"photourl":"http://www.boyihunjia.com/uploads/20180208/e2d004d867c3ba29da2d6b502024e12f.jpg"}]
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
        private String contentm;
        private String contentmw;
        private String theteam;
        private int follow;
        private List<PhotourlBean> photourl;

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

        public DataBean() {
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeTypedList(this.photourl);
        }

        protected DataBean(Parcel in) {

            this.photourl = in.createTypedArrayList(PhotourlBean.CREATOR);

        }

        public static final Creator<DataBean> CREATOR = new Creator<DataBean>() {
            @Override
            public DataBean createFromParcel(Parcel source) {
                return new DataBean(source);
            }

            @Override
            public DataBean[] newArray(int size) {
                return new DataBean[size];
            }
        };

        public static class PhotourlBean implements IThumbViewInfo {
            /**
             * id : 69
             * mydynamicid : 40
             * photourl : http://www.boyihunjia.com/uploads/20180208/7032ba588dd8f5f4588011ae4e4af975.jpg
             */

            private int id;
            private int mydynamicid;
            private String photourl;
            private Rect bounds;

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

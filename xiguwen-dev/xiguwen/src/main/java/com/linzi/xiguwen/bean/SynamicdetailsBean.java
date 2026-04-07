package com.linzi.xiguwen.bean;

import android.graphics.Rect;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;

import com.previewlibrary.enitity.IThumbViewInfo;

import java.util.List;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/28  11:47
 *
 * @author luyongjiang
 * @version 1.0
 */
public class SynamicdetailsBean implements Parcelable {

    /**
     * id : 42
     * content : 于千万人中遇见你，于千万年中遇见你，没有早一步，没有晚一步，就这样赶上了，惟有轻轻问一声：要买2018春季新品吗？再来三款美的不得了的四件套，数量有限哦！<img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif' /><img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif' />
     * create_ti : 2018-02-08 15:35:50
     * userid : 13
     * pv : 16
     * zan : 2
     * nickname : 爱诺寐铺家纺店
     * head : http://www.boyihunjia.com/uploads/20180208/19819c2510bc8adf5b275d58cbfec355.jpg
     * commentnum : 7
     * theteam : 杜卡基老师婚庆团队
     * photourl : [{"id":75,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/c8b602e3d48da8b3dc896a50a64e1a49.jpg"},{"id":76,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/e6bc7da99e88c23ac43946e9cdc623ae.jpg"},{"id":77,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/d655ae189fafa5b5923a59cbb7a0f85e.jpg"},{"id":78,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/ccdbbb3f234cd5de325161fbd6501776.jpg"},{"id":79,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/3e292b08cf9bb06a4aac7c1ff1866a41.jpg"},{"id":80,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/51e6de5f7ccda0d9e70480790372396d.jpg"}]
     * follow : 0
     * myzan : 0
     * commentlist : [{"comm":"年后萨斯","id":85,"create_ti":"2018-03-28 11:14:33","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","nickname":"杜卡基老师","userid":16,"pid":0,"xiaji":[]},{"comm":"撒旦法撒旦法撒","id":86,"create_ti":"2018-03-28 11:14:37","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","nickname":"杜卡基老师","userid":16,"pid":0,"xiaji":[{"comm":"大夫敢死队风格都市感","pid":86,"nickname":"杜卡基老师"},{"comm":"跌幅高达沙发","pid":86,"nickname":"杜卡基老师"}]},{"comm":"法规和肺结核","id":87,"create_ti":"2018-03-28 11:14:39","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","nickname":"杜卡基老师","userid":16,"pid":0,"xiaji":[]},{"comm":"5tyre人员","id":88,"create_ti":"2018-03-28 11:14:41","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","nickname":"杜卡基老师","userid":16,"pid":0,"xiaji":[{"comm":"独特风格都市风格","pid":88,"nickname":"杜卡基老师"}]}]
     * zanlist : [{"head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","nickname":"杜卡基老师"},{"head":"http://imgcache.boyitongcheng.com/62720201803061521234360.ico","nickname":"用户12544448888"}]
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
    private int myzan;
    private String occupation;
    private List<PhotourlBean> photourl;
    private List<CommentlistBean> commentlist;
    private List<ZanlistBean> zanlist;



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

    public int getMyzan() {
        return myzan;
    }

    public void setMyzan(int myzan) {
        this.myzan = myzan;
    }

    public List<PhotourlBean> getPhotourl() {
        return photourl;
    }

    public void setPhotourl(List<PhotourlBean> photourl) {
        this.photourl = photourl;
    }

    public List<CommentlistBean> getCommentlist() {
        return commentlist;
    }

    public void setCommentlist(List<CommentlistBean> commentlist) {
        this.commentlist = commentlist;
    }

    public List<ZanlistBean> getZanlist() {
        return zanlist;
    }

    public void setZanlist(List<ZanlistBean> zanlist) {
        this.zanlist = zanlist;
    }

    public static class PhotourlBean implements IThumbViewInfo {
        /**
         * id : 75
         * mydynamicid : 42
         * photourl : http://www.boyihunjia.com/uploads/20180208/c8b602e3d48da8b3dc896a50a64e1a49.jpg
         */

        private int id;
        private int mydynamicid;
        private String photourl;
        private Rect bounds;

        public Rect getBounds() {
            return bounds;
        }

        @Nullable
        @Override
        public String getVideoUrl() {
            return null;
        }

        public void setBounds(Rect bound) {
            this.bounds = bound;
        }

        public String getUrl() {
            return photourl;
        }

        public void setUrl(String url) {
            photourl = url;
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

        public PhotourlBean() {
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel dest, int flags) {
            dest.writeInt(this.id);
            dest.writeInt(this.mydynamicid);
            dest.writeString(this.photourl);
            dest.writeParcelable(this.bounds, flags);
        }

        protected PhotourlBean(Parcel in) {
            this.id = in.readInt();
            this.mydynamicid = in.readInt();
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

    public static class CommentlistBean implements Parcelable {
        /**
         * comm : 年后萨斯
         * id : 85
         * create_ti : 2018-03-28 11:14:33
         * head : http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg
         * nickname : 杜卡基老师
         * userid : 16
         * pid : 0
         * xiaji : []
         */

        private String comm;
        private int id;
        private String create_ti;
        private String head;
        private String nickname;
        private int userid;
        private int pid;
        private List<commentChildEntity> xiaji;

        protected CommentlistBean(Parcel in) {
            comm = in.readString();
            id = in.readInt();
            create_ti = in.readString();
            head = in.readString();
            nickname = in.readString();
            userid = in.readInt();
            pid = in.readInt();
            xiaji = in.createTypedArrayList(commentChildEntity.CREATOR);
        }

        @Override
        public void writeToParcel(Parcel dest, int flags) {
            dest.writeString(comm);
            dest.writeInt(id);
            dest.writeString(create_ti);
            dest.writeString(head);
            dest.writeString(nickname);
            dest.writeInt(userid);
            dest.writeInt(pid);
            dest.writeTypedList(xiaji);
        }

        @Override
        public int describeContents() {
            return 0;
        }

        public static final Creator<CommentlistBean> CREATOR = new Creator<CommentlistBean>() {
            @Override
            public CommentlistBean createFromParcel(Parcel in) {
                return new CommentlistBean(in);
            }

            @Override
            public CommentlistBean[] newArray(int size) {
                return new CommentlistBean[size];
            }
        };

        public List<commentChildEntity> getXiaji() {
            return xiaji;
        }

        public void setXiaji(List<commentChildEntity> xiaji) {
            this.xiaji = xiaji;
        }

        public String getComm() {
            return comm;
        }

        public void setComm(String comm) {
            this.comm = comm;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getCreate_ti() {
            return create_ti;
        }

        public void setCreate_ti(String create_ti) {
            this.create_ti = create_ti;
        }

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public int getPid() {
            return pid;
        }

        public void setPid(int pid) {
            this.pid = pid;
        }

        public CommentlistBean() {
        }


    }

    public static class ZanlistBean implements Parcelable {
        /**
         * head : http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg
         * nickname : 杜卡基老师
         */

        private String head;
        private String nickname;


        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel dest, int flags) {
            dest.writeString(this.head);
            dest.writeString(this.nickname);
        }

        public ZanlistBean() {
        }

        protected ZanlistBean(Parcel in) {
            this.head = in.readString();
            this.nickname = in.readString();
        }

        public static final Creator<ZanlistBean> CREATOR = new Creator<ZanlistBean>() {
            @Override
            public ZanlistBean createFromParcel(Parcel source) {
                return new ZanlistBean(source);
            }

            @Override
            public ZanlistBean[] newArray(int size) {
                return new ZanlistBean[size];
            }
        };
    }

    public SynamicdetailsBean() {
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.id);
        dest.writeString(this.content);
        dest.writeString(this.create_ti);
        dest.writeInt(this.userid);
        dest.writeInt(this.pv);
        dest.writeInt(this.zan);
        dest.writeString(this.nickname);
        dest.writeString(this.head);
        dest.writeInt(this.commentnum);
        dest.writeString(this.theteam);
        dest.writeInt(this.follow);
        dest.writeInt(this.myzan);
        dest.writeString(this.occupation);
        dest.writeTypedList(this.photourl);
        dest.writeTypedList(this.commentlist);
        dest.writeTypedList(this.zanlist);
    }

    protected SynamicdetailsBean(Parcel in) {
        this.id = in.readInt();
        this.content = in.readString();
        this.create_ti = in.readString();
        this.userid = in.readInt();
        this.pv = in.readInt();
        this.zan = in.readInt();
        this.nickname = in.readString();
        this.head = in.readString();
        this.commentnum = in.readInt();
        this.theteam = in.readString();
        this.follow = in.readInt();
        this.myzan = in.readInt();
        this.occupation = in.readString();
        this.photourl = in.createTypedArrayList(PhotourlBean.CREATOR);
        this.commentlist = in.createTypedArrayList(CommentlistBean.CREATOR);
        this.zanlist = in.createTypedArrayList(ZanlistBean.CREATOR);
    }

    public static final Creator<SynamicdetailsBean> CREATOR = new Creator<SynamicdetailsBean>() {
        @Override
        public SynamicdetailsBean createFromParcel(Parcel source) {
            return new SynamicdetailsBean(source);
        }

        @Override
        public SynamicdetailsBean[] newArray(int size) {
            return new SynamicdetailsBean[size];
        }
    };


    public static class commentChildEntity implements Parcelable{
//"comm":"dfgsdfgfg",
//        　　　　　　　　　　　　"pid":46,
//        　　　　　　　　　　　　"nickname":"杜卡基老师"
        private String comm;
        private int pid;
        private String nickname;

        protected commentChildEntity(Parcel in) {
            comm = in.readString();
            pid = in.readInt();
            nickname = in.readString();
        }

        public static final Creator<commentChildEntity> CREATOR = new Creator<commentChildEntity>() {
            @Override
            public commentChildEntity createFromParcel(Parcel in) {
                return new commentChildEntity(in);
            }

            @Override
            public commentChildEntity[] newArray(int size) {
                return new commentChildEntity[size];
            }
        };

        public String getComm() {
            return comm;
        }

        public void setComm(String comm) {
            this.comm = comm;
        }

        public int getPid() {
            return pid;
        }

        public void setPid(int pid) {
            this.pid = pid;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel dest, int flags) {
            dest.writeString(comm);
            dest.writeInt(pid);
            dest.writeString(nickname);
        }
    }
}

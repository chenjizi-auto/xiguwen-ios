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
 * CreateTime:2018/3/23  19:32
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ShetuanIndexBean {

    /**
     * info : {"id":8,"name":"杜卡基老师婚庆团队","type":2,"provinceid":24,"cityid":273,"countyid":2639,"address":"云华路333号7栋307","profile":"2009年6月，古今缘传统婚礼策划公司成立于四川成都，发展至今古今缘（中国）传统婚礼文化、成都古今缘婚庆礼仪有限公司，已成为中国知名传统中、汉式婚礼连锁品牌服务机构，亦是中国很早专业从事中、汉式婚礼研发与推广的研发型策划公司。","logourl":"http://www.boyihunjia.com/uploads/20180125/08392e6129286bf0381f7dde9dc5a7d8.jpg","appphotourl":"http://www.boyihunjia.com/uploads/20180125/89b956f439ceb43342a20c65e05c3fb9.jpg","userid":16,"username":"18581882801","create_ti":1515391982,"update_ti":1517838754,"clicked":480}
     * quanbudongtai : 15
     * dynamiclist : [{"usertype":1,"id":42,"content":"于千万人中遇见你，于千万年中遇见你，没有早一步，没有晚一步，就这样赶上了，惟有轻轻问一声：要买2018春季新品吗？再来三款美的不得了的四件套，数量有限哦！<img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif' /><img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif' />","create_ti":"2018-02-08 15:35:50","userid":13,"pv":12,"zan":2,"nickname":"爱诺寐铺家纺店","head":"http://www.boyihunjia.com/uploads/20180208/19819c2510bc8adf5b275d58cbfec355.jpg","pls":0,"pics":[{"id":75,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/c8b602e3d48da8b3dc896a50a64e1a49.jpg"},{"id":76,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/e6bc7da99e88c23ac43946e9cdc623ae.jpg"},{"id":77,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/d655ae189fafa5b5923a59cbb7a0f85e.jpg"},{"id":78,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/ccdbbb3f234cd5de325161fbd6501776.jpg"},{"id":79,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/3e292b08cf9bb06a4aac7c1ff1866a41.jpg"},{"id":80,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/51e6de5f7ccda0d9e70480790372396d.jpg"}],"follow":0,"myzan":0},{"usertype":1,"id":41,"content":"我爱你，时光无阻，所以如果你爱我，一定要风雨无阻。借我一生，与你看尽人间山水！上新品了，上新品了，看过来哦！<img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/3.gif' /><img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/3.gif' />","create_ti":"2018-02-08 15:34:33","userid":13,"pv":4,"zan":0,"nickname":"爱诺寐铺家纺店","head":"http://www.boyihunjia.com/uploads/20180208/19819c2510bc8adf5b275d58cbfec355.jpg","pls":0,"pics":[{"id":72,"mydynamicid":41,"photourl":"http://www.boyihunjia.com/uploads/20180208/88ec73ed988b819d9a3a105c3e256aa7.jpg"},{"id":73,"mydynamicid":41,"photourl":"http://www.boyihunjia.com/uploads/20180208/a8ce47f0bcb48d1164e10b9f6c5050de.jpg"},{"id":74,"mydynamicid":41,"photourl":"http://www.boyihunjia.com/uploads/20180208/eccefc1d5ffffc1cc5f6ea5141aae797.jpg"}],"follow":0,"myzan":0},{"usertype":2,"id":35,"content":"你，一袭白纱，宛如皎洁明月，像一滴晶莹的雨露；似一只洁白的玉兔，悄然飘落在人间，融于手心，暖入我心","create_ti":"2018-02-04 19:55:55","userid":16,"pv":15,"zan":1,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","pls":2,"pics":[{"id":59,"mydynamicid":35,"photourl":"http://www.boyihunjia.com/uploads/20180204/b57c1075185291673018f5feaeabac95.png"},{"id":60,"mydynamicid":35,"photourl":"http://www.boyihunjia.com/uploads/20180204/7501d9b9e4c8fb77d1143500e3a2621c.png"}],"follow":0,"myzan":0},{"usertype":2,"id":34,"content":"你，一袭白纱，宛如皎洁明月，像一滴晶莹的雨露；似一只洁白的玉兔，悄然飘落在人间，融于手心，暖入我心","create_ti":"2018-02-04 19:53:15","userid":16,"pv":25,"zan":1,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","pls":0,"pics":[{"id":56,"mydynamicid":34,"photourl":"http://www.boyihunjia.com/uploads/20180204/ebc3c713540f25ef1130390e3b4a7615.jpg"},{"id":58,"mydynamicid":34,"photourl":"http://www.boyihunjia.com/uploads/20180204/4557adb7411ad8eda1d3a996aa9d4d01.jpg"},{"id":57,"mydynamicid":34,"photourl":"http://www.boyihunjia.com/uploads/20180204/43fc159b5d048e556ef1b9f694256ba3.jpg"}],"follow":0,"myzan":0},{"usertype":2,"id":33,"content":"夜已深，妻子那边床头的台灯已经熄灭，我这边的独亮。黄色的灯光被帆布质地的灯罩过滤后显得更加柔和。夜读的人一般都会喜欢拿个靠枕放在颈后，来一个舒服的半躺姿势，因为这样最放松，思想最纯净，没有了白天琐事的纷扰","create_ti":"2018-02-04 19:52:51","userid":16,"pv":3,"zan":1,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","pls":0,"pics":[{"id":54,"mydynamicid":33,"photourl":"http://www.boyihunjia.com/uploads/20180204/13dda89f46196abf3caa803839a8e72b.png"},{"id":55,"mydynamicid":33,"photourl":"http://www.boyihunjia.com/uploads/20180204/8c8414d087f110708b5ea556cb48782a.png"}],"follow":0,"myzan":0},{"usertype":2,"id":32,"content":"第一阶段三天课程结束。从主持人性格养成到善于发现，展开联想，到措辞迅速、精炼，我们经历了一番蝉蜕般的修炼。","create_ti":"2018-02-04 19:52:29","userid":16,"pv":3,"zan":1,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","pls":0,"pics":[{"id":52,"mydynamicid":32,"photourl":"http://www.boyihunjia.com/uploads/20180204/849866275b30002faf7c02f95d9f0582.png"},{"id":53,"mydynamicid":32,"photourl":"http://www.boyihunjia.com/uploads/20180204/887c6632c549f0f6cf62c0dcefed1997.png"}],"follow":0,"myzan":0},{"usertype":2,"id":30,"content":"因为相爱，每一天都是良辰吉日；因为相爱，即使只为你唱一首歌也是一种仪式。<img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/52.gif' /><img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/62.gif' />","create_ti":"2018-01-13 15:41:34","userid":16,"pv":45,"zan":140,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","pls":12,"pics":[{"id":48,"mydynamicid":30,"photourl":"http://www.boyihunjia.com/uploads/20180113/d2b8d13a8c16dad64468026f2ee0e996.jpg"},{"id":45,"mydynamicid":30,"photourl":"http://www.boyihunjia.com/uploads/20180113/2427dca682547c0c72f574945e93c0ca.jpg"},{"id":46,"mydynamicid":30,"photourl":"http://www.boyihunjia.com/uploads/20180113/b8c3bd146e52407a6b3bee2e8c4da1b7.jpg"},{"id":47,"mydynamicid":30,"photourl":"http://www.boyihunjia.com/uploads/20180113/8f811b0c2bfe63914f7677d71ead4b37.jpg"}],"follow":0,"myzan":0},{"usertype":2,"id":29,"content":"是一份什么样的动力才能让一对新人，两位策划师，一位主持人，畅聊到深夜？我想答案只有一个，那就是对这场婚礼的期待。 感谢摄影师～低调的，不爱出镜的，主持人走的时候，她依然要继续沟通的熊猫婶婶.","create_ti":"2018-01-13 11:29:49","userid":16,"pv":35,"zan":1,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","pls":3,"pics":[{"id":40,"mydynamicid":29,"photourl":"http://www.boyihunjia.com/uploads/20180113/0bb764b7789361fcc1da85edc71857aa.jpg"},{"id":41,"mydynamicid":29,"photourl":"http://www.boyihunjia.com/uploads/20180113/9e2374fe78673a03189cd19a9cfe5cd2.jpg"},{"id":42,"mydynamicid":29,"photourl":"http://www.boyihunjia.com/uploads/20180113/e50bde4e1679787a118a1455df7e4ce2.jpg"},{"id":43,"mydynamicid":29,"photourl":"http://www.boyihunjia.com/uploads/20180113/36af9c530ae145d80777c653dd9a185c.jpg"},{"id":44,"mydynamicid":29,"photourl":"http://www.boyihunjia.com/uploads/20180113/61fa319ff80f45c627405ca711a28420.jpg"}],"follow":0,"myzan":0},{"usertype":2,"id":26,"content":"第一阶段三天课程结束。从主持人性格养成到善于发现，展开联想，到措辞迅速、精炼，我们经历了一番蝉蜕般的修炼。每个人都是那么出色！尤其是嘉嘉的惊人进步，让我感到了巨大的压力。我要多多地加油了！！我是星越，一名爱美食懂生活的主持人。最后一张是我做的糖醋排骨。","create_ti":"2018-01-13 10:50:01","userid":16,"pv":16,"zan":1,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","pls":2,"pics":[{"id":31,"mydynamicid":26,"photourl":"http://www.boyihunjia.com/uploads/20180113/73539e403d3f87459c3235874770300d.jpg"},{"id":32,"mydynamicid":26,"photourl":"http://www.boyihunjia.com/uploads/20180113/b1e4077e2e996e260d145e931a9c432c.jpg"},{"id":33,"mydynamicid":26,"photourl":"http://www.boyihunjia.com/uploads/20180113/33556ed004fa46dc20a5380aa51c886e.jpg"},{"id":34,"mydynamicid":26,"photourl":"http://www.boyihunjia.com/uploads/20180113/92536029ecd161f3e0ca0e3df7087b87.jpg"}],"follow":0,"myzan":0},{"usertype":2,"id":25,"content":"夜已深，妻子那边床头的台灯已经熄灭，我这边的独亮。黄色的灯光被帆布质地的灯罩过滤后显得更加柔和。夜读的人一般都会喜欢拿个靠枕放在颈后，来一个舒服的半躺姿势，因为这样最放松，思想最纯净，没有了白天琐事的纷扰，可以静静地看着这些文字在纸面上跳舞，而不必非得理解它们舞蹈的意义。每一本书都有它们自己诞生的意义，人也一样。如果我们还没有能力快速地阅读一个人，那么我们完全可以先去读一本书，在这样的一个夜里，舒服地读书。说到这，我突然有点困了，你也该睡了。晚安，夜里晚睡的人。","create_ti":"2018-01-13 09:44:03","userid":16,"pv":17,"zan":34,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","pls":0,"pics":[{"id":29,"mydynamicid":25,"photourl":"http://www.boyihunjia.com/uploads/20180113/f3bcb4f19d3d8b0a83229e66235f60fd.jpg"},{"id":30,"mydynamicid":25,"photourl":"http://www.boyihunjia.com/uploads/20180113/b40c29e7cfdd03bb02c297123c4f9d23.jpg"}],"follow":0,"myzan":0}]
     */

    private InfoBean info;
    private int quanbudongtai;
    private List<DynamiclistBean> dynamiclist;

    public InfoBean getInfo() {
        return info;
    }

    public void setInfo(InfoBean info) {
        this.info = info;
    }

    public int getQuanbudongtai() {
        return quanbudongtai;
    }

    public void setQuanbudongtai(int quanbudongtai) {
        this.quanbudongtai = quanbudongtai;
    }

    public List<DynamiclistBean> getDynamiclist() {
        return dynamiclist;
    }

    public void setDynamiclist(List<DynamiclistBean> dynamiclist) {
        this.dynamiclist = dynamiclist;
    }

    public static class InfoBean {
        /**
         * id : 8
         * name : 杜卡基老师婚庆团队
         * type : 2
         * provinceid : 24
         * cityid : 273
         * countyid : 2639
         * address : 云华路333号7栋307
         * profile : 2009年6月，古今缘传统婚礼策划公司成立于四川成都，发展至今古今缘（中国）传统婚礼文化、成都古今缘婚庆礼仪有限公司，已成为中国知名传统中、汉式婚礼连锁品牌服务机构，亦是中国很早专业从事中、汉式婚礼研发与推广的研发型策划公司。
         * logourl : http://www.boyihunjia.com/uploads/20180125/08392e6129286bf0381f7dde9dc5a7d8.jpg
         * appphotourl : http://www.boyihunjia.com/uploads/20180125/89b956f439ceb43342a20c65e05c3fb9.jpg
         * userid : 16
         * username : 18581882801
         * create_ti : 1515391982
         * update_ti : 1517838754
         * clicked : 480
         */

        private int id;
        private String name;
        private int type;
        private int provinceid;
        private int cityid;
        private int countyid;
        private String address;
        private String profile;
        private String logourl;
        private String appphotourl;
        private int userid;
        private String username;
        private int create_ti;
        private int update_ti;
        private int clicked;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public int getType() {
            return type;
        }

        public void setType(int type) {
            this.type = type;
        }

        public int getProvinceid() {
            return provinceid;
        }

        public void setProvinceid(int provinceid) {
            this.provinceid = provinceid;
        }

        public int getCityid() {
            return cityid;
        }

        public void setCityid(int cityid) {
            this.cityid = cityid;
        }

        public int getCountyid() {
            return countyid;
        }

        public void setCountyid(int countyid) {
            this.countyid = countyid;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getProfile() {
            return profile;
        }

        public void setProfile(String profile) {
            this.profile = profile;
        }

        public String getLogourl() {
            return logourl;
        }

        public void setLogourl(String logourl) {
            this.logourl = logourl;
        }

        public String getAppphotourl() {
            return appphotourl;
        }

        public void setAppphotourl(String appphotourl) {
            this.appphotourl = appphotourl;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public int getCreate_ti() {
            return create_ti;
        }

        public void setCreate_ti(int create_ti) {
            this.create_ti = create_ti;
        }

        public int getUpdate_ti() {
            return update_ti;
        }

        public void setUpdate_ti(int update_ti) {
            this.update_ti = update_ti;
        }

        public int getClicked() {
            return clicked;
        }

        public void setClicked(int clicked) {
            this.clicked = clicked;
        }
    }

    public static class DynamiclistBean implements Parcelable {

        /**
         * usertype : 1
         * id : 42
         * content : 于千万人中遇见你，于千万年中遇见你，没有早一步，没有晚一步，就这样赶上了，惟有轻轻问一声：要买2018春季新品吗？再来三款美的不得了的四件套，数量有限哦！<img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif' /><img src='http://www.boyihunjia.com/shopadmin/vendor/qqFace/arclist/6.gif' />
         * create_ti : 2018-02-08 15:35:50
         * userid : 13
         * pv : 12
         * zan : 2
         * nickname : 爱诺寐铺家纺店
         * head : http://www.boyihunjia.com/uploads/20180208/19819c2510bc8adf5b275d58cbfec355.jpg
         * pls : 0
         * pics : [{"id":75,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/c8b602e3d48da8b3dc896a50a64e1a49.jpg"},{"id":76,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/e6bc7da99e88c23ac43946e9cdc623ae.jpg"},{"id":77,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/d655ae189fafa5b5923a59cbb7a0f85e.jpg"},{"id":78,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/ccdbbb3f234cd5de325161fbd6501776.jpg"},{"id":79,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/3e292b08cf9bb06a4aac7c1ff1866a41.jpg"},{"id":80,"mydynamicid":42,"photourl":"http://www.boyihunjia.com/uploads/20180208/51e6de5f7ccda0d9e70480790372396d.jpg"}]
         * follow : 0
         * myzan : 0
         */

        private String occupationid;//职业
        private String association;//社团


        public String getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(String occupationid) {
            this.occupationid = occupationid;
        }

        public String getAssociation() {
            return association;
        }

        public void setAssociation(String association) {
            this.association = association;
        }

        private int usertype;
        private int id;
        private String content;
        private String create_ti;
        private int userid;
        private int pv;
        private int zan;
        private String nickname;
        private String head;
        private int pls;
        private int follow;
        private int myzan;
        private List<PicsBean> pics;

        public int getUsertype() {
            return usertype;
        }

        public void setUsertype(int usertype) {
            this.usertype = usertype;
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

        public int getPls() {
            return pls;
        }

        public void setPls(int pls) {
            this.pls = pls;
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

        public List<PicsBean> getPics() {
            return pics;
        }

        public void setPics(List<PicsBean> pics) {
            this.pics = pics;
        }

        public static class PicsBean implements IThumbViewInfo {



            /**
             * id : 75
             * mydynamicid : 42
             * photourl : http://www.boyihunjia.com/uploads/20180208/c8b602e3d48da8b3dc896a50a64e1a49.jpg
             */

            private int id;
            private int mydynamicid;
            private String photourl;

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

            public PicsBean() {
            }


            public void setUrl(String url) {
                photourl = url;
            }

            private Rect bounds;

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
            public void writeToParcel(Parcel dest, int flags) {
                dest.writeInt(this.id);
                dest.writeInt(this.mydynamicid);
                dest.writeString(this.photourl);
                dest.writeParcelable(this.bounds, flags);
            }

            protected PicsBean(Parcel in) {
                this.id = in.readInt();
                this.mydynamicid = in.readInt();
                this.photourl = in.readString();
                this.bounds = in.readParcelable(Rect.class.getClassLoader());
            }

            public static final Creator<PicsBean> CREATOR = new Creator<PicsBean>() {
                @Override
                public PicsBean createFromParcel(Parcel source) {
                    return new PicsBean(source);
                }

                @Override
                public PicsBean[] newArray(int size) {
                    return new PicsBean[size];
                }
            };
        }

        public DynamiclistBean() {
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel dest, int flags) {
            dest.writeString(this.occupationid);
            dest.writeString(this.association);
            dest.writeInt(this.usertype);
            dest.writeInt(this.id);
            dest.writeString(this.content);
            dest.writeString(this.create_ti);
            dest.writeInt(this.userid);
            dest.writeInt(this.pv);
            dest.writeInt(this.zan);
            dest.writeString(this.nickname);
            dest.writeString(this.head);
            dest.writeInt(this.pls);
            dest.writeInt(this.follow);
            dest.writeInt(this.myzan);
            dest.writeTypedList(this.pics);
        }

        protected DynamiclistBean(Parcel in) {
            this.occupationid = in.readString();
            this.association = in.readString();
            this.usertype = in.readInt();
            this.id = in.readInt();
            this.content = in.readString();
            this.create_ti = in.readString();
            this.userid = in.readInt();
            this.pv = in.readInt();
            this.zan = in.readInt();
            this.nickname = in.readString();
            this.head = in.readString();
            this.pls = in.readInt();
            this.follow = in.readInt();
            this.myzan = in.readInt();
            this.pics = in.createTypedArrayList(PicsBean.CREATOR);
        }

        public static final Creator<DynamiclistBean> CREATOR = new Creator<DynamiclistBean>() {
            @Override
            public DynamiclistBean createFromParcel(Parcel source) {
                return new DynamiclistBean(source);
            }

            @Override
            public DynamiclistBean[] newArray(int size) {
                return new DynamiclistBean[size];
            }
        };
    }
}

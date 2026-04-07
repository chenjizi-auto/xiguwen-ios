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

public class EvaluateBean {

    /**
     * pinlun : [{"comment_id":17,"user_id":76,"seller_id":16,"order_id":417,"goods_id":null,"rec_id":null,"content":"垃圾","created_at":"2018-03-30 10:33:39","updated_at":null,"parent_id":null,"pictures":["http://imgcache.boyihunjia.com/063ae201803301033185079.png","http://imgcache.boyihunjia.com/05d0e201803301033198968.png"],"order_score":2,"replay_user_id":null,"replay_content":null,"replay_time":"1970-01-01 08:00:00","anonymous":2,"pid":50,"userid":76,"usertype":3,"occupationid":0,"username":"18888888888","register":null,"authentication":0,"name":null,"identitynum":null,"vouchers":"0.00","payvouchers":"0.00","pvouchers":"0.00","nickname":"18888888888","head":"http://www.boyihunjia.com/home/default/imghead.png","mobile":"18888888888","sex":"1","birthday":604800,"provinceid":24,"cityid":285,"countyid":2751,"logintime":1522376478,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":0,"evaluate":0,"site":null,"pv":0,"price":"0.00","num":0,"goodscore":100,"isuserivip":1,"userivipstat":0,"userivipendt":0,"sign":1,"height":0,"weight":0,"age":0,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":0},{"comment_id":16,"user_id":67,"seller_id":16,"order_id":366,"goods_id":null,"rec_id":null,"content":"不是很好","created_at":"2018-03-27 09:22:36","updated_at":null,"parent_id":null,"pictures":["http://imgcache.boyihunjia.com/00b16201803270922345449.png"],"order_score":1,"replay_user_id":16,"replay_content":"那里不好了？","replay_time":"2018-03-27 09:23:27","anonymous":1,"pid":0,"userid":67,"usertype":1,"occupationid":0,"username":"13551862869","register":null,"authentication":1,"name":"测试","identitynum":"1231431","vouchers":"100100.00","payvouchers":"100000.00","pvouchers":"100100.00","nickname":"博艺婚嫁自营店","head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","mobile":"13551862869","sex":"1","birthday":649987200,"provinceid":24,"cityid":273,"countyid":2636,"logintime":1522379510,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":2,"evaluate":0,"site":"武侯区环球东路","pv":372,"price":"0.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":2,"height":0,"weight":0,"age":111,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":3},{"comment_id":14,"user_id":541,"seller_id":16,"order_id":301,"goods_id":null,"rec_id":null,"content":"杜老师特别优秀！不错","created_at":"2018-03-23 10:21:32","updated_at":null,"parent_id":null,"pictures":[],"order_score":5,"replay_user_id":null,"replay_content":null,"replay_time":"1970-01-01 08:00:00","anonymous":1,"pid":0,"userid":541,"usertype":2,"occupationid":1,"username":"13880700685","register":null,"authentication":1,"name":"廖斌","identitynum":"513322198304170038","vouchers":"150.00","payvouchers":"0.00","pvouchers":"150.00","nickname":"墨修成","head":"http://www.boyihunjia.com/Index/admin/image/180222/d4Md0279000001519271679.png","mobile":"13880700685","sex":"0","birthday":419356800,"provinceid":24,"cityid":273,"countyid":2637,"logintime":1522221005,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":1,"evaluate":0,"site":"财富领地3栋12楼","pv":568,"price":"600.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":null,"height":0,"weight":0,"age":0,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":2},{"comment_id":12,"user_id":67,"seller_id":16,"order_id":119,"goods_id":null,"rec_id":null,"content":"dfgbcfgbdfgds","created_at":"2018-03-05 14:47:03","updated_at":null,"parent_id":null,"pictures":[],"order_score":5,"replay_user_id":null,"replay_content":null,"replay_time":"1970-01-01 08:00:00","anonymous":1,"pid":0,"userid":67,"usertype":1,"occupationid":0,"username":"13551862869","register":null,"authentication":1,"name":"测试","identitynum":"1231431","vouchers":"100100.00","payvouchers":"100000.00","pvouchers":"100100.00","nickname":"博艺婚嫁自营店","head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","mobile":"13551862869","sex":"1","birthday":649987200,"provinceid":24,"cityid":273,"countyid":2636,"logintime":1522379510,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":2,"evaluate":0,"site":"武侯区环球东路","pv":372,"price":"0.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":2,"height":0,"weight":0,"age":111,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":3},{"comment_id":11,"user_id":67,"seller_id":16,"order_id":76,"goods_id":null,"rec_id":null,"content":"服务好，非常不错","created_at":"2018-03-02 10:08:57","updated_at":null,"parent_id":null,"pictures":["http://www.boyihunjia.com/uploads/20180302/16bf400af6e8a3daa6a6e27f75e1c211.jpg","http://www.boyihunjia.com/uploads/20180302/5c10179aedfaaa19fcccf2f9be930681.jpg","http://www.boyihunjia.com/uploads/20180302/f83bbfde568cf9ea6275c687ed946a3b.jpg","http://www.boyihunjia.com/uploads/20180302/dda0e4559d86ac9283b91badca7f7079.jpg"],"order_score":5,"replay_user_id":null,"replay_content":null,"replay_time":"1970-01-01 08:00:00","anonymous":1,"pid":0,"userid":67,"usertype":1,"occupationid":0,"username":"13551862869","register":null,"authentication":1,"name":"测试","identitynum":"1231431","vouchers":"100100.00","payvouchers":"100000.00","pvouchers":"100100.00","nickname":"博艺婚嫁自营店","head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","mobile":"13551862869","sex":"1","birthday":649987200,"provinceid":24,"cityid":273,"countyid":2636,"logintime":1522379510,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":2,"evaluate":0,"site":"武侯区环球东路","pv":372,"price":"0.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":2,"height":0,"weight":0,"age":111,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":3}]
     * num : 10
     */

    private int num;
    private List<PinlunBean> pinlun;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<PinlunBean> getPinlun() {
        return pinlun;
    }

    public void setPinlun(List<PinlunBean> pinlun) {
        this.pinlun = pinlun;
    }

    public static class PinlunBean implements Parcelable {
        /**
         * comment_id : 17
         * user_id : 76
         * seller_id : 16
         * order_id : 417
         * goods_id : null
         * rec_id : null
         * content : 垃圾
         * created_at : 2018-03-30 10:33:39
         * updated_at : null
         * parent_id : null
         * pictures : ["http://imgcache.boyihunjia.com/063ae201803301033185079.png","http://imgcache.boyihunjia.com/05d0e201803301033198968.png"]
         * order_score : 2
         * replay_user_id : null
         * replay_content : null
         * replay_time : 1970-01-01 08:00:00
         * anonymous : 2
         * pid : 50
         * userid : 76
         * usertype : 3
         * occupationid : 0
         * username : 18888888888
         * register : null
         * authentication : 0
         * name : null
         * identitynum : null
         * vouchers : 0.00
         * payvouchers : 0.00
         * pvouchers : 0.00
         * nickname : 18888888888
         * head : http://www.boyihunjia.com/home/default/imghead.png
         * mobile : 18888888888
         * sex : 1
         * birthday : 604800
         * provinceid : 24
         * cityid : 285
         * countyid : 2751
         * logintime : 1522376478
         * state : 1
         * weixin : null
         * createtime : 1520310601
         * score : 100
         * fans : 0
         * evaluate : 0
         * site : null
         * pv : 0
         * price : 0.00
         * num : 0
         * goodscore : 100
         * isuserivip : 1
         * userivipstat : 0
         * userivipendt : 0
         * sign : 1
         * height : 0
         * weight : 0
         * age : 0
         * email :
         * isuseriviptoken :
         * onlinestatus : 1
         * inviter :
         * sort : 0
         */

        private int comment_id;
        private int user_id;
        private int seller_id;
        private int order_id;
        private Object goods_id;
        private Object rec_id;
        private String content;
        private String created_at;
        private Object updated_at;
        private Object parent_id;
        private int order_score;
        private Object replay_user_id;
        private Object replay_content;
        private String replay_time;
        private int anonymous;
        private int pid;
        private int userid;
        private int usertype;
        private int occupationid;
        private String username;
        private Object register;
        private int authentication;
        private Object name;
        private Object identitynum;
        private String vouchers;
        private String payvouchers;
        private String pvouchers;
        private String nickname;
        private String head;
        private String mobile;
        private String sex;
        private int birthday;
        private int provinceid;
        private int cityid;
        private int countyid;
        private int logintime;
        private int state;
        private Object weixin;
        private int createtime;
        private int score;
        private int fans;
        private int evaluate;
        private Object site;
        private int pv;
        private String price;
        private int num;
        private int goodscore;
        private int isuserivip;
        private int userivipstat;
        private int userivipendt;
        private int sign;
        private int height;
        private int weight;
        private int age;
        private String email;
        private String isuseriviptoken;
        private int onlinestatus;
        private String inviter;
        private int sort;
        private List<String> pictures;
        private List<PicsBean> pics;

        public List<PicsBean> getPics() {
            return pics;
        }

        public void setPics(List<PicsBean> pics) {
            this.pics = pics;
        }

        public int getComment_id() {
            return comment_id;
        }

        public void setComment_id(int comment_id) {
            this.comment_id = comment_id;
        }

        public int getUser_id() {
            return user_id;
        }

        public void setUser_id(int user_id) {
            this.user_id = user_id;
        }

        public int getSeller_id() {
            return seller_id;
        }

        public void setSeller_id(int seller_id) {
            this.seller_id = seller_id;
        }

        public int getOrder_id() {
            return order_id;
        }

        public void setOrder_id(int order_id) {
            this.order_id = order_id;
        }

        public Object getGoods_id() {
            return goods_id;
        }

        public void setGoods_id(Object goods_id) {
            this.goods_id = goods_id;
        }

        public Object getRec_id() {
            return rec_id;
        }

        public void setRec_id(Object rec_id) {
            this.rec_id = rec_id;
        }

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }

        public String getCreated_at() {
            return created_at;
        }

        public void setCreated_at(String created_at) {
            this.created_at = created_at;
        }

        public Object getUpdated_at() {
            return updated_at;
        }

        public void setUpdated_at(Object updated_at) {
            this.updated_at = updated_at;
        }

        public Object getParent_id() {
            return parent_id;
        }

        public void setParent_id(Object parent_id) {
            this.parent_id = parent_id;
        }

        public int getOrder_score() {
            return order_score;
        }

        public void setOrder_score(int order_score) {
            this.order_score = order_score;
        }

        public Object getReplay_user_id() {
            return replay_user_id;
        }

        public void setReplay_user_id(Object replay_user_id) {
            this.replay_user_id = replay_user_id;
        }

        public Object getReplay_content() {
            return replay_content;
        }

        public void setReplay_content(Object replay_content) {
            this.replay_content = replay_content;
        }

        public String getReplay_time() {
            return replay_time;
        }

        public void setReplay_time(String replay_time) {
            this.replay_time = replay_time;
        }

        public int getAnonymous() {
            return anonymous;
        }

        public void setAnonymous(int anonymous) {
            this.anonymous = anonymous;
        }

        public int getPid() {
            return pid;
        }

        public void setPid(int pid) {
            this.pid = pid;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public int getUsertype() {
            return usertype;
        }

        public void setUsertype(int usertype) {
            this.usertype = usertype;
        }

        public int getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(int occupationid) {
            this.occupationid = occupationid;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public Object getRegister() {
            return register;
        }

        public void setRegister(Object register) {
            this.register = register;
        }

        public int getAuthentication() {
            return authentication;
        }

        public void setAuthentication(int authentication) {
            this.authentication = authentication;
        }

        public Object getName() {
            return name;
        }

        public void setName(Object name) {
            this.name = name;
        }

        public Object getIdentitynum() {
            return identitynum;
        }

        public void setIdentitynum(Object identitynum) {
            this.identitynum = identitynum;
        }

        public String getVouchers() {
            return vouchers;
        }

        public void setVouchers(String vouchers) {
            this.vouchers = vouchers;
        }

        public String getPayvouchers() {
            return payvouchers;
        }

        public void setPayvouchers(String payvouchers) {
            this.payvouchers = payvouchers;
        }

        public String getPvouchers() {
            return pvouchers;
        }

        public void setPvouchers(String pvouchers) {
            this.pvouchers = pvouchers;
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

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }

        public String getSex() {
            return sex;
        }

        public void setSex(String sex) {
            this.sex = sex;
        }

        public int getBirthday() {
            return birthday;
        }

        public void setBirthday(int birthday) {
            this.birthday = birthday;
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

        public int getLogintime() {
            return logintime;
        }

        public void setLogintime(int logintime) {
            this.logintime = logintime;
        }

        public int getState() {
            return state;
        }

        public void setState(int state) {
            this.state = state;
        }

        public Object getWeixin() {
            return weixin;
        }

        public void setWeixin(Object weixin) {
            this.weixin = weixin;
        }

        public int getCreatetime() {
            return createtime;
        }

        public void setCreatetime(int createtime) {
            this.createtime = createtime;
        }

        public int getScore() {
            return score;
        }

        public void setScore(int score) {
            this.score = score;
        }

        public int getFans() {
            return fans;
        }

        public void setFans(int fans) {
            this.fans = fans;
        }

        public int getEvaluate() {
            return evaluate;
        }

        public void setEvaluate(int evaluate) {
            this.evaluate = evaluate;
        }

        public Object getSite() {
            return site;
        }

        public void setSite(Object site) {
            this.site = site;
        }

        public int getPv() {
            return pv;
        }

        public void setPv(int pv) {
            this.pv = pv;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public int getNum() {
            return num;
        }

        public void setNum(int num) {
            this.num = num;
        }

        public int getGoodscore() {
            return goodscore;
        }

        public void setGoodscore(int goodscore) {
            this.goodscore = goodscore;
        }

        public int getIsuserivip() {
            return isuserivip;
        }

        public void setIsuserivip(int isuserivip) {
            this.isuserivip = isuserivip;
        }

        public int getUserivipstat() {
            return userivipstat;
        }

        public void setUserivipstat(int userivipstat) {
            this.userivipstat = userivipstat;
        }

        public int getUserivipendt() {
            return userivipendt;
        }

        public void setUserivipendt(int userivipendt) {
            this.userivipendt = userivipendt;
        }

        public int getSign() {
            return sign;
        }

        public void setSign(int sign) {
            this.sign = sign;
        }

        public int getHeight() {
            return height;
        }

        public void setHeight(int height) {
            this.height = height;
        }

        public int getWeight() {
            return weight;
        }

        public void setWeight(int weight) {
            this.weight = weight;
        }

        public int getAge() {
            return age;
        }

        public void setAge(int age) {
            this.age = age;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getIsuseriviptoken() {
            return isuseriviptoken;
        }

        public void setIsuseriviptoken(String isuseriviptoken) {
            this.isuseriviptoken = isuseriviptoken;
        }

        public int getOnlinestatus() {
            return onlinestatus;
        }

        public void setOnlinestatus(int onlinestatus) {
            this.onlinestatus = onlinestatus;
        }

        public String getInviter() {
            return inviter;
        }

        public void setInviter(String inviter) {
            this.inviter = inviter;
        }

        public int getSort() {
            return sort;
        }

        public void setSort(int sort) {
            this.sort = sort;
        }

        public List<String> getPictures() {
            return pictures;
        }

        public void setPictures(List<String> pictures) {
            this.pictures = pictures;
        }

        public static class PicsBean implements IThumbViewInfo {

            private String photourl;

            private Rect bounds;

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
                dest.writeString(this.photourl);
                dest.writeParcelable(this.bounds, flags);
            }

            protected PicsBean(Parcel in) {
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

        public PinlunBean() {
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeTypedList(this.pics);
        }

        protected PinlunBean(Parcel in) {
            this.pics = in.createTypedArrayList(PicsBean.CREATOR);
        }


        public static final Creator<PinlunBean> CREATOR = new Creator<PinlunBean>() {
            @Override
            public PinlunBean createFromParcel(Parcel source) {
                return new PinlunBean(source);
            }

            @Override
            public PinlunBean[] newArray(int size) {
                return new PinlunBean[size];
            }
        };
    }
}

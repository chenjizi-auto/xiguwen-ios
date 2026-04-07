package com.linzi.xiguwen.bean;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.ArrayList;
import java.util.List;

/**
 * Title:
 * Description:社团列表的数据模型
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  13:22
 *
 * @author luyongjiang
 * @version 1.0
 */
public class AssociationBean {


    private List<ShetuanBean> shetuan = new ArrayList<>();

    public List<ShetuanBean> getShetuan() {
        return shetuan;
    }

    public void setShetuan(List<ShetuanBean> shetuan) {
        this.shetuan = shetuan;
    }

    public static class ShetuanBean implements Parcelable {


        /**
         * id : 10
         * name : 九亦影视
         * type : 摄像师
         * provinceid : 24
         * cityid : 273
         * countyid : 2638
         * address : [金牛区]青羊区 北大街 财富领地 3栋12楼
         * profile : 组织文化交流活动，婚庆服务，摄影服务，摄像服务，展览展示服务，企业营销策划，企业管理咨询，文艺演出策划（不含营业性演出），舞台搭建设计服务，影视节目制作。（依法须经批准的项目，经相关部门批准后方可开展经营活动）。
         * logourl : http://imgcache.boyihunjia.com/b8b4f201803200849221271.jpg
         * appphotourl : http://imgcache.boyihunjia.com/9771f201803151710378936.jpg
         * userid : 646
         * username : 18080861991
         * create_ti : 1521083736
         * update_ti : 1521105098
         * clicked : 19
         * membersnum : 3
         * minimumprice : 800.00
         */

        private int id;
        private String name;
        private String type;
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
        private int membersnum;
        private String minimumprice;

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

        public String getType() {
            return type;
        }

        public void setType(String type) {
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

        public int getMembersnum() {
            return membersnum;
        }

        public void setMembersnum(int membersnum) {
            this.membersnum = membersnum;
        }

        public String getMinimumprice() {
            return minimumprice;
        }

        public void setMinimumprice(String minimumprice) {
            this.minimumprice = minimumprice;
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel dest, int flags) {
            dest.writeInt(this.id);
            dest.writeString(this.name);
            dest.writeString(this.type);
            dest.writeInt(this.provinceid);
            dest.writeInt(this.cityid);
            dest.writeInt(this.countyid);
            dest.writeString(this.address);
            dest.writeString(this.profile);
            dest.writeString(this.logourl);
            dest.writeString(this.appphotourl);
            dest.writeInt(this.userid);
            dest.writeString(this.username);
            dest.writeInt(this.create_ti);
            dest.writeInt(this.update_ti);
            dest.writeInt(this.clicked);
            dest.writeInt(this.membersnum);
            dest.writeString(this.minimumprice);
        }

        public ShetuanBean() {
        }

        protected ShetuanBean(Parcel in) {
            this.id = in.readInt();
            this.name = in.readString();
            this.type = in.readString();
            this.provinceid = in.readInt();
            this.cityid = in.readInt();
            this.countyid = in.readInt();
            this.address = in.readString();
            this.profile = in.readString();
            this.logourl = in.readString();
            this.appphotourl = in.readString();
            this.userid = in.readInt();
            this.username = in.readString();
            this.create_ti = in.readInt();
            this.update_ti = in.readInt();
            this.clicked = in.readInt();
            this.membersnum = in.readInt();
            this.minimumprice = in.readString();
        }

        public static final Parcelable.Creator<ShetuanBean> CREATOR = new Parcelable.Creator<ShetuanBean>() {
            @Override
            public ShetuanBean createFromParcel(Parcel source) {
                return new ShetuanBean(source);
            }

            @Override
            public ShetuanBean[] newArray(int size) {
                return new ShetuanBean[size];
            }
        };
    }
}

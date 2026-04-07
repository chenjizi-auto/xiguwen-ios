package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by PC on 2018-04-09.
 * 我的需求详情对象
 */

public class MineNeedDetailBean implements Serializable{
    /**
     *  "jiedanren": [
     {
     "cid": 2,
     "create_ti": "2018-01-27 14:26:29",
     "demandid": 15,
     "goodscore": 100,
     "head": "http://boyiapi.xxwlb.com/uploads/20180126/2d666f73e9f22791b203d7e275a71c23.jpg",
     "jdshuoming": "我我的撒旦飞洒的",
     "minimumprice": 0,
     "nickname": "13551862863",
     "num": 0,
     "occupationid": 1,
     "pv": 0,
     "selected_time": 1,
     "status_j": 1,
     "userid": 67,
     "username": "13551862863"
     }
     ],
     "xuquxiangqing": {
     "id": 24,
     "code": "20180207151793708828",
     "status": 2,
     "title": "123123",
     "type": "商城",
     "price": 123,
     "provinceid": 2,
     "cityid": 2,
     "countyid": 378,
     "address": "北京市北京市东城区",
     "details": "123",
     "openphone": 1,
     "openmessage": 1,
     "browsingvolume": 9,
     "userid": 76,
     "username": null,
     "create_ti": "2018-02-07 01:11:28",
     "create_nyr": 1517932800,
     "update_ti": 0,
     "daoqitime": "2018-02-09 01:11:28",
     "countdown": 0,
     "renshu": 0,
     "dizhi": "北京市-北京市-东城区"
     }
     },
     */


    private List<AffiliatedPerson> jiedanren; // 参与人列表
    private NeedDetail xuquxiangqing; // 需求详情

    public List<AffiliatedPerson> getJiedanren() {
        return jiedanren;
    }

    public void setJiedanren(List<AffiliatedPerson> jiedanren) {
        this.jiedanren = jiedanren;
    }

    public NeedDetail getXuquxiangqing() {
        return xuquxiangqing;
    }

    public void setXuquxiangqing(NeedDetail xuquxiangqing) {
        this.xuquxiangqing = xuquxiangqing;
    }

    /**
     * 参与人员
     */
    public static class AffiliatedPerson implements Serializable{

        public static final int STATUS_BINGO = 1;

        private int cid;                    //参与id
        private String create_ti;
        private int demandid;
        private int goodscore;
        private String head;                //参与人头像
        private String jdshuoming;
        private String minimumprice;           //最低起价，100元起
        private String nickname;            //参与人昵称
        private int num;
        private String occupationid;           //职业
        private int pv;
        private long selected_time;
        private int status_j;               //是否中标， 1已中标  2未中标  3进行中
        private long userid;                 //参与人id
        private String username;

        public int getCid() {
            return cid;
        }

        public void setCid(int cid) {
            this.cid = cid;
        }

        public String getCreate_ti() {
            return create_ti;
        }

        public void setCreate_ti(String create_ti) {
            this.create_ti = create_ti;
        }

        public int getDemandid() {
            return demandid;
        }

        public void setDemandid(int demandid) {
            this.demandid = demandid;
        }

        public int getGoodscore() {
            return goodscore;
        }

        public void setGoodscore(int goodscore) {
            this.goodscore = goodscore;
        }

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public String getJdshuoming() {
            return jdshuoming;
        }

        public void setJdshuoming(String jdshuoming) {
            this.jdshuoming = jdshuoming;
        }

        public String getMinimumprice() {
            return minimumprice;
        }

        public void setMinimumprice(String minimumprice) {
            this.minimumprice = minimumprice;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public int getNum() {
            return num;
        }

        public void setNum(int num) {
            this.num = num;
        }

        public String getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(String occupationid) {
            this.occupationid = occupationid;
        }

        public int getPv() {
            return pv;
        }

        public void setPv(int pv) {
            this.pv = pv;
        }

        public long getSelected_time() {
            return selected_time;
        }

        public void setSelected_time(long selected_time) {
            this.selected_time = selected_time;
        }

        public int getStatus_j() {
            return status_j;
        }

        public void setStatus_j(int status_j) {
            this.status_j = status_j;
        }

        public long getUserid() {
            return userid;
        }

        public void setUserid(long userid) {
            this.userid = userid;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }
    }

    /**
     * 需求详情
     */
    public static class NeedDetail {

        private int id;
        private String code;
        private int status;
        private String title;               //	标题
        private String type;
        private float price;                  //价格
        private int provinceid;
        private int cityid;
        private int countyid;
        private String address;
        private String details;             //	需求详情
        private int openphone;
        private int openmessage;
        private int browsingvolume;         //浏览量
        private int userid;
        private String username;
        private String create_ti;
        private long create_nyr;
        private long update_ti;
        private String daoqitime;           //剩余时间
        private long countdown;              // 倒计时
        private int renshu;                 //参与人数
        private String dizhi;
        private String mobile;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getCode() {
            return code;
        }

        public void setCode(String code) {
            this.code = code;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public float getPrice() {
            return price;
        }

        public void setPrice(float price) {
            this.price = price;
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

        public String getDetails() {
            return details;
        }

        public void setDetails(String details) {
            this.details = details;
        }

        public int getOpenphone() {
            return openphone;
        }

        public void setOpenphone(int openphone) {
            this.openphone = openphone;
        }

        public int getOpenmessage() {
            return openmessage;
        }

        public void setOpenmessage(int openmessage) {
            this.openmessage = openmessage;
        }

        public int getBrowsingvolume() {
            return browsingvolume;
        }

        public void setBrowsingvolume(int browsingvolume) {
            this.browsingvolume = browsingvolume;
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

        public String getCreate_ti() {
            return create_ti;
        }

        public void setCreate_ti(String create_ti) {
            this.create_ti = create_ti;
        }

        public long getCreate_nyr() {
            return create_nyr;
        }

        public void setCreate_nyr(long create_nyr) {
            this.create_nyr = create_nyr;
        }

        public long getUpdate_ti() {
            return update_ti;
        }

        public void setUpdate_ti(long update_ti) {
            this.update_ti = update_ti;
        }

        public String getDaoqitime() {
            return daoqitime;
        }

        public void setDaoqitime(String daoqitime) {
            this.daoqitime = daoqitime;
        }

        public long getCountdown() {
            return countdown;
        }

        public void setCountdown(long countdown) {
            this.countdown = countdown;
        }

        public int getRenshu() {
            return renshu;
        }

        public void setRenshu(int renshu) {
            this.renshu = renshu;
        }

        public String getDizhi() {
            return dizhi;
        }

        public void setDizhi(String dizhi) {
            this.dizhi = dizhi;
        }

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }
    }
}

package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/4/1.
 */

public class HotBean {

    /**
     * guanggaolunbo : [{"adid":1,"title":"热门轮播1","adtypeid":19,"aptid":16,"aptype":1,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180216/zPGm0706898001518790164.jpeg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":1,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"100.00","text":"我是平面中的点，你则是那颗圆心，我的所有轨迹皆是你...","createtime":1520819724},{"adid":2,"title":"热门轮播2","adtypeid":19,"aptid":61,"aptype":6,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180216/AGgl0878773001518790176.jpeg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":2,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"120.00","text":"我是平面中的点，你则是那颗圆心，我的所有轨迹皆是你...","createtime":1518790178}]
     * remensj : [{"occupationid":"摄像师","team":2,"usertype":2,"userid":540,"nickname":"成都墨家影视文化传播","head":"http://imgcache.boyihunjia.com/a7d33201803121826421369.jpg","evaluate":0,"isshopvip":1,"sincerity":0,"platform":1,"college":1,"team2":1,"shopnum":0,"anlinum":0,"zuidijia":"900.00","shiming":0,"xueyuan":0,"xueyuanname":""},{"occupationid":"摄像师","team":2,"usertype":2,"userid":646,"nickname":"九亦影视","head":"http://imgcache.boyihunjia.com/b28cd201803190823518799.jpg","evaluate":0,"isshopvip":1,"sincerity":0,"platform":1,"college":1,"team2":1,"shopnum":0,"anlinum":0,"zuidijia":"800.00","shiming":0,"xueyuan":0,"xueyuanname":""},{"occupationid":"摄像师","team":1,"usertype":2,"userid":1125,"nickname":"九亦影视\u2014Superduty土豆","head":"http://imgcache.boyihunjia.com/98bd0201803131444008355.jpg","evaluate":0,"isshopvip":1,"sincerity":0,"platform":1,"college":1,"team2":0,"shopnum":0,"anlinum":0,"zuidijia":"800.00","shiming":1,"xueyuan":7,"xueyuanname":"中级认证"},{"occupationid":"摄像师","team":1,"usertype":2,"userid":1124,"nickname":"九亦影视\u2014枫子","head":"http://imgcache.boyihunjia.com/fdeba201803151256148515.jpg","evaluate":0,"isshopvip":1,"sincerity":0,"platform":1,"college":1,"team2":0,"shopnum":0,"anlinum":0,"zuidijia":"800.00","shiming":1,"xueyuan":7,"xueyuanname":"中级认证"},{"occupationid":"花艺师","team":1,"usertype":2,"userid":16,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","evaluate":0,"isshopvip":0,"sincerity":1,"platform":1,"college":1,"team2":0,"shopnum":0,"anlinum":2,"zuidijia":"0.03","shiming":0,"xueyuan":0,"xueyuanname":""},{"occupationid":"摄影师","team":2,"usertype":2,"userid":537,"nickname":"左右视觉-大川摄影","head":"http://imgcache.boyitongcheng.com/30bc0201803071128143963.jpg","evaluate":0,"isshopvip":0,"sincerity":0,"platform":1,"college":1,"team2":0,"shopnum":0,"anlinum":4,"zuidijia":"900.00","shiming":1,"xueyuan":0,"xueyuanname":""},{"occupationid":null,"team":1,"usertype":2,"userid":647,"nickname":"九一影视文化传媒\u2014老廖","head":"http://www.boyihunjia.com/home/default/imghead.png","evaluate":0,"isshopvip":1,"sincerity":0,"platform":1,"college":1,"team2":0,"shopnum":0,"anlinum":0,"zuidijia":0,"shiming":0,"xueyuan":7,"xueyuanname":"中级认证"},{"occupationid":"策划师","team":1,"usertype":2,"userid":1269,"nickname":"沙湾大红灯笼婚礼文化","head":"http://imgcache.boyihunjia.com/5d0f2201803141442566774.png","evaluate":0,"isshopvip":0,"sincerity":0,"platform":1,"college":0,"team2":0,"shopnum":0,"anlinum":0,"zuidijia":0,"shiming":1,"xueyuan":0,"xueyuanname":""},{"occupationid":"策划师","team":2,"usertype":2,"userid":1272,"nickname":"用户15902886110","head":"http://imgcache.boyihunjia.com/76fca201803121334194595.png","evaluate":0,"isshopvip":0,"sincerity":0,"platform":1,"college":0,"team2":0,"shopnum":0,"anlinum":0,"zuidijia":0,"shiming":1,"xueyuan":0,"xueyuanname":""},{"occupationid":"婚庆公司","team":2,"usertype":2,"userid":1322,"nickname":"好心情婚礼定制","head":"http://imgcache.boyihunjia.com/b5a70201803231725202081.png","evaluate":0,"isshopvip":0,"sincerity":0,"platform":1,"college":0,"team2":0,"shopnum":0,"anlinum":2,"zuidijia":"1500.00","shiming":1,"xueyuan":0,"xueyuanname":""}]
     * num : 622
     */

    private int num;
    private List<GuanggaolunboBean> guanggaolunbo;
    private List<RemensjBean> remensj;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<GuanggaolunboBean> getGuanggaolunbo() {
        return guanggaolunbo;
    }

    public void setGuanggaolunbo(List<GuanggaolunboBean> guanggaolunbo) {
        this.guanggaolunbo = guanggaolunbo;
    }

    public List<RemensjBean> getRemensj() {
        return remensj;
    }

    public void setRemensj(List<RemensjBean> remensj) {
        this.remensj = remensj;
    }

    public static class GuanggaolunboBean {
        /**
         * adid : 1
         * title : 热门轮播1
         * adtypeid : 19
         * aptid : 16
         * aptype : 1
         * wapimg : http://www.boyihunjia.com/Index/admin/image/180216/zPGm0706898001518790164.jpeg
         * src : http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg
         * site :
         * weigh : 1
         * status : 1
         * provinceid : 24
         * cityid : 273
         * countyid : 0
         * price : 100.00
         * text : 我是平面中的点，你则是那颗圆心，我的所有轨迹皆是你...
         * createtime : 1520819724
         */

        private int adid;
        private String title;
        private int adtypeid;
        private int aptid;
        private int aptype;
        private String wapimg;
        private String src;
        private String site;
        private int weigh;
        private int status;
        private int provinceid;
        private int cityid;
        private int countyid;
        private String price;
        private String text;
        private int createtime;

        public int getAdid() {
            return adid;
        }

        public void setAdid(int adid) {
            this.adid = adid;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public int getAdtypeid() {
            return adtypeid;
        }

        public void setAdtypeid(int adtypeid) {
            this.adtypeid = adtypeid;
        }

        public int getAptid() {
            return aptid;
        }

        public void setAptid(int aptid) {
            this.aptid = aptid;
        }

        public int getAptype() {
            return aptype;
        }

        public void setAptype(int aptype) {
            this.aptype = aptype;
        }

        public String getWapimg() {
            return wapimg;
        }

        public void setWapimg(String wapimg) {
            this.wapimg = wapimg;
        }

        public String getSrc() {
            return src;
        }

        public void setSrc(String src) {
            this.src = src;
        }

        public String getSite() {
            return site;
        }

        public void setSite(String site) {
            this.site = site;
        }

        public int getWeigh() {
            return weigh;
        }

        public void setWeigh(int weigh) {
            this.weigh = weigh;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
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

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public int getCreatetime() {
            return createtime;
        }

        public void setCreatetime(int createtime) {
            this.createtime = createtime;
        }
    }

    public static class RemensjBean {
        /**
         * occupationid : 摄像师
         * team : 2
         * usertype : 2
         * userid : 540
         * nickname : 成都墨家影视文化传播
         * head : http://imgcache.boyihunjia.com/a7d33201803121826421369.jpg
         * evaluate : 0
         * isshopvip : 1
         * sincerity : 0
         * platform : 1
         * college : 1
         * team2 : 1
         * shopnum : 0
         * anlinum : 0
         * zuidijia : 900.00
         * shiming : 0
         * xueyuan : 0
         * xueyuanname :
         */

        private String occupationid;
        private int team;
        private int usertype;
        private int userid;
        private String nickname;
        private String head;
        private int evaluate;
        private int isshopvip;
        private int sincerity;
        private int platform;
        private int college;
        private int team2;
        private int shopnum;
        private int anlinum;
        private String zuidijia;
        private int shiming;
        private int xueyuan;
        private String xueyuanname;

        public String getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(String occupationid) {
            this.occupationid = occupationid;
        }

        public int getTeam() {
            return team;
        }

        public void setTeam(int team) {
            this.team = team;
        }

        public int getUsertype() {
            return usertype;
        }

        public void setUsertype(int usertype) {
            this.usertype = usertype;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
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

        public int getEvaluate() {
            return evaluate;
        }

        public void setEvaluate(int evaluate) {
            this.evaluate = evaluate;
        }

        public int getIsshopvip() {
            return isshopvip;
        }

        public void setIsshopvip(int isshopvip) {
            this.isshopvip = isshopvip;
        }

        public int getSincerity() {
            return sincerity;
        }

        public void setSincerity(int sincerity) {
            this.sincerity = sincerity;
        }

        public int getPlatform() {
            return platform;
        }

        public void setPlatform(int platform) {
            this.platform = platform;
        }

        public int getCollege() {
            return college;
        }

        public void setCollege(int college) {
            this.college = college;
        }

        public int getTeam2() {
            return team2;
        }

        public void setTeam2(int team2) {
            this.team2 = team2;
        }

        public int getShopnum() {
            return shopnum;
        }

        public void setShopnum(int shopnum) {
            this.shopnum = shopnum;
        }

        public int getAnlinum() {
            return anlinum;
        }

        public void setAnlinum(int anlinum) {
            this.anlinum = anlinum;
        }

        public String getZuidijia() {
            return zuidijia;
        }

        public void setZuidijia(String zuidijia) {
            this.zuidijia = zuidijia;
        }

        public int getShiming() {
            return shiming;
        }

        public void setShiming(int shiming) {
            this.shiming = shiming;
        }

        public int getXueyuan() {
            return xueyuan;
        }

        public void setXueyuan(int xueyuan) {
            this.xueyuan = xueyuan;
        }

        public String getXueyuanname() {
            return xueyuanname;
        }

        public void setXueyuanname(String xueyuanname) {
            this.xueyuanname = xueyuanname;
        }
    }
}

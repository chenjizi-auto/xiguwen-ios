package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/3/30.
 */

public class OffoerDetailsBean {

    /**
     * userf : 0
     * baojia : {"quotationid":326,"userid":1398,"uname":"15023540369","name":"婚礼策划","price":"2000.00","deposit":"0.00","company":"","deductible":"0.00","weigh":1,"imglist":["http://imgcache.boyihunjia.com/ae9e420180326113605740.jpg"],"content":"","rule1key":null,"rule2key":null,"rule3key":null,"state":2,"statecontent":"审核通过","status":1,"createtime":1522035367,"statetime":1522035556,"number":0,"temporarypay":"1000.00","rule1val":null,"rule2val":null,"rule3val":null,"num":0,"pv":4,"haopin":100}
     * user : {"team":2,"mobile":"15023540369","evaluate":0,"provinceid":23,"cityid":270,"head":"http://imgcache.boyihunjia.com/9521e201803231803486115.png","userid":1398,"nickname":"万州区麦琪婚礼花艺馆","occupationid":26,"goodscore":100,"fans":0,"num":0,"sincerity":0,"platform":1,"college":0,"team2":0,"occupation":"婚庆公司","addr":"重庆市重庆市","shiming":1,"xueyuan":0,"xueyuanname":""}
     * youlike : [{"quotationid":133,"name":"佳能单反、单机位拍摄","price":"900.00","imglist":["http://imgcache.boyihunjia.com/70c5f201803121753185422.png"],"num":0},{"quotationid":134,"name":"佳能单反，双机位拍摄","price":"1800.00","imglist":["http://imgcache.boyihunjia.com/40248201803121754025077.png"],"num":0},{"quotationid":135,"name":"单反双机位拍摄加8米摇臂","price":"3500.00","imglist":["http://imgcache.boyihunjia.com/c7817201803121757019741.png"],"num":0},{"quotationid":136,"name":"个人形象MV","price":"3888.00","imglist":["http://imgcache.boyihunjia.com/3e3de201803121800067804.png"],"num":0},{"quotationid":137,"name":"摄像单机","price":"800.00","imglist":["http://imgcache.boyihunjia.com/6f46b201803121803293398.jpg"],"num":0},{"quotationid":138,"name":"15秒-30秒广告","price":"13888.00","imglist":["http://imgcache.boyihunjia.com/5f6ed201803121803159776.png"],"num":0},{"quotationid":139,"name":"宣传片拍摄","price":"18888.00","imglist":["http://imgcache.boyihunjia.com/01abf201803121806077705.png"],"num":0},{"quotationid":140,"name":"摄像双机","price":"1600.00","imglist":["http://imgcache.boyihunjia.com/eb752201803121808234460.jpg"],"num":0}]
     */

    private int userf;
    private BaojiaBean baojia;
    private UserBean user;
    private List<YoulikeBean> youlike;

    public int getUserf() {
        return userf;
    }

    public void setUserf(int userf) {
        this.userf = userf;
    }

    public BaojiaBean getBaojia() {
        return baojia;
    }

    public void setBaojia(BaojiaBean baojia) {
        this.baojia = baojia;
    }

    public UserBean getUser() {
        return user;
    }

    public void setUser(UserBean user) {
        this.user = user;
    }

    public List<YoulikeBean> getYoulike() {
        return youlike;
    }

    public void setYoulike(List<YoulikeBean> youlike) {
        this.youlike = youlike;
    }

    public static class BaojiaBean {
        /**
         * quotationid : 326
         * userid : 1398
         * uname : 15023540369
         * name : 婚礼策划
         * price : 2000.00
         * deposit : 0.00
         * company :
         * deductible : 0.00
         * weigh : 1
         * imglist : ["http://imgcache.boyihunjia.com/ae9e420180326113605740.jpg"]
         * content :
         * rule1key : null
         * rule2key : null
         * rule3key : null
         * state : 2
         * statecontent : 审核通过
         * status : 1
         * createtime : 1522035367
         * statetime : 1522035556
         * number : 0
         * temporarypay : 1000.00
         * rule1val : null
         * rule2val : null
         * rule3val : null
         * num : 0
         * pv : 4
         * haopin : 100
         */

        private int quotationid;
        private int userid;
        private String uname;
        private String name;
        private String price;
        private String deposit;
        private String company;
        private String deductible;
        private int weigh;
        private String content;
        private Object rule1key;
        private Object rule2key;
        private Object rule3key;
        private int state;
        private String statecontent;
        private int status;
        private int createtime;
        private int statetime;
        private int number;
        private String temporarypay;
        private Object rule1val;
        private Object rule2val;
        private Object rule3val;
        private int num;
        private int pv;
        private int haopin;
        private List<String> imglist;
        private List<PicsBean> picsBean;

        public List<PicsBean> getPicsBean() {
            return picsBean;
        }

        public void setPicsBean(List<PicsBean> picsBean) {
            this.picsBean = picsBean;
        }

        public int getQuotationid() {
            return quotationid;
        }

        public void setQuotationid(int quotationid) {
            this.quotationid = quotationid;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public String getUname() {
            return uname;
        }

        public void setUname(String uname) {
            this.uname = uname;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public String getDeposit() {
            return deposit;
        }

        public void setDeposit(String deposit) {
            this.deposit = deposit;
        }

        public String getCompany() {
            return company;
        }

        public void setCompany(String company) {
            this.company = company;
        }

        public String getDeductible() {
            return deductible;
        }

        public void setDeductible(String deductible) {
            this.deductible = deductible;
        }

        public int getWeigh() {
            return weigh;
        }

        public void setWeigh(int weigh) {
            this.weigh = weigh;
        }

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }

        public Object getRule1key() {
            return rule1key;
        }

        public void setRule1key(Object rule1key) {
            this.rule1key = rule1key;
        }

        public Object getRule2key() {
            return rule2key;
        }

        public void setRule2key(Object rule2key) {
            this.rule2key = rule2key;
        }

        public Object getRule3key() {
            return rule3key;
        }

        public void setRule3key(Object rule3key) {
            this.rule3key = rule3key;
        }

        public int getState() {
            return state;
        }

        public void setState(int state) {
            this.state = state;
        }

        public String getStatecontent() {
            return statecontent;
        }

        public void setStatecontent(String statecontent) {
            this.statecontent = statecontent;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getCreatetime() {
            return createtime;
        }

        public void setCreatetime(int createtime) {
            this.createtime = createtime;
        }

        public int getStatetime() {
            return statetime;
        }

        public void setStatetime(int statetime) {
            this.statetime = statetime;
        }

        public int getNumber() {
            return number;
        }

        public void setNumber(int number) {
            this.number = number;
        }

        public String getTemporarypay() {
            return temporarypay;
        }

        public void setTemporarypay(String temporarypay) {
            this.temporarypay = temporarypay;
        }

        public Object getRule1val() {
            return rule1val;
        }

        public void setRule1val(Object rule1val) {
            this.rule1val = rule1val;
        }

        public Object getRule2val() {
            return rule2val;
        }

        public void setRule2val(Object rule2val) {
            this.rule2val = rule2val;
        }

        public Object getRule3val() {
            return rule3val;
        }

        public void setRule3val(Object rule3val) {
            this.rule3val = rule3val;
        }

        public int getNum() {
            return num;
        }

        public void setNum(int num) {
            this.num = num;
        }

        public int getPv() {
            return pv;
        }

        public void setPv(int pv) {
            this.pv = pv;
        }

        public int getHaopin() {
            return haopin;
        }

        public void setHaopin(int haopin) {
            this.haopin = haopin;
        }

        public List<String> getImglist() {
            return imglist;
        }

        public void setImglist(List<String> imglist) {
            this.imglist = imglist;
        }

        public static class PicsBean {
            private String imgurl;

            public String getImgurl() {
                return imgurl;
            }

            public void setImgurl(String imgurl) {
                this.imgurl = imgurl;
            }
        }
    }

    public static class UserBean {
        /**
         * team : 2
         * mobile : 15023540369
         * evaluate : 0
         * provinceid : 23
         * cityid : 270
         * head : http://imgcache.boyihunjia.com/9521e201803231803486115.png
         * userid : 1398
         * nickname : 万州区麦琪婚礼花艺馆
         * occupationid : 26
         * goodscore : 100
         * fans : 0
         * num : 0
         * sincerity : 0
         * platform : 1
         * college : 0
         * team2 : 0
         * occupation : 婚庆公司
         * addr : 重庆市重庆市
         * shiming : 1
         * xueyuan : 0
         * xueyuanname :
         */

        private int team;
        private String mobile;
        private int evaluate;
        private int provinceid;
        private int cityid;
        private String head;
        private int userid;
        private String nickname;
        private int occupationid;
        private int goodscore;
        private int fans;
        private int num;
        private int sincerity;
        private int platform;
        private int college;
        private int team2;
        private String occupation;
        private String addr;
        private int shiming;
        private int xueyuan;
        private String xueyuanname;

        public int getTeam() {
            return team;
        }

        public void setTeam(int team) {
            this.team = team;
        }

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }

        public int getEvaluate() {
            return evaluate;
        }

        public void setEvaluate(int evaluate) {
            this.evaluate = evaluate;
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

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
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

        public int getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(int occupationid) {
            this.occupationid = occupationid;
        }

        public int getGoodscore() {
            return goodscore;
        }

        public void setGoodscore(int goodscore) {
            this.goodscore = goodscore;
        }

        public int getFans() {
            return fans;
        }

        public void setFans(int fans) {
            this.fans = fans;
        }

        public int getNum() {
            return num;
        }

        public void setNum(int num) {
            this.num = num;
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

        public String getOccupation() {
            return occupation;
        }

        public void setOccupation(String occupation) {
            this.occupation = occupation;
        }

        public String getAddr() {
            return addr;
        }

        public void setAddr(String addr) {
            this.addr = addr;
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

    public static class YoulikeBean {
        /**
         * quotationid : 133
         * name : 佳能单反、单机位拍摄
         * price : 900.00
         * imglist : ["http://imgcache.boyihunjia.com/70c5f201803121753185422.png"]
         * num : 0
         */

        private int quotationid;
        private String name;
        private String price;
        private int num;
        private List<String> imglist;

        public int getQuotationid() {
            return quotationid;
        }

        public void setQuotationid(int quotationid) {
            this.quotationid = quotationid;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
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

        public List<String> getImglist() {
            return imglist;
        }

        public void setImglist(List<String> imglist) {
            this.imglist = imglist;
        }
    }
}

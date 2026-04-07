package com.linzi.xiguwen.bean;

/**
 * Created by jiang on 2018/1/31.
 */

public class LoginBean {

    /**
     * code : 0
     * message : 登录成功！
     * data : {"token":{"token":"eebd00e68cae169cfc1b1f65991b2c56523e1429","userid":137,"login_time":1517390356,"type":"0"},"user":{"userid":137,"usertype":2,"pid":0,"occupationid":0,"username":"18482180351","register":null,"authentication":0,"name":"","identitynum":null,"money":"0.00","vouchers":"0.00","payvouchers":"0.00","pvouchers":"0.00","nickname":"林子","head":"http://boyiapi.xxwlb.com/home/default/imghead.png","mobile":"18482180351","sex":"1","birthday":650074088,"provinceid":24,"cityid":273,"countyid":2647,"wachat_openid":"","weibo_openid":"","qq_openid":"","logintime":null,"state":1,"weixin":null,"createtime":null,"score":100,"fans":0,"evaluate":0,"payword":null,"site":"","pv":0,"price":"0.00","num":0,"goodscore":100,"sslmid":"","sslmpid":"","isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":null,"height":0,"weight":0,"age":0,"email":"","id":52,"team":0,"groupid":0,"isshopvip":0,"shopivipstat":0,"shopivipendt":0,"company":null,"sincerity":0,"platform":0,"college":0,"team2":0,"recommend":null,"shopimg":null,"content":null,"background":"http://boyiapi.xxwlb.com","qualifications":""}}
     */

    private int code;
    private String message;
    private DataBean data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public DataBean getData() {
        return data;
    }

    public void setData(DataBean data) {
        this.data = data;
    }

    public static class DataBean {
        /**
         * token : {"token":"eebd00e68cae169cfc1b1f65991b2c56523e1429","userid":137,"login_time":1517390356,"type":"0"}
         * user : {"userid":137,"usertype":2,"pid":0,"occupationid":0,"username":"18482180351","register":null,"authentication":0,"name":"","identitynum":null,"money":"0.00","vouchers":"0.00","payvouchers":"0.00","pvouchers":"0.00","nickname":"林子","head":"http://boyiapi.xxwlb.com/home/default/imghead.png","mobile":"18482180351","sex":"1","birthday":650074088,"provinceid":24,"cityid":273,"countyid":2647,"wachat_openid":"","weibo_openid":"","qq_openid":"","logintime":null,"state":1,"weixin":null,"createtime":null,"score":100,"fans":0,"evaluate":0,"payword":null,"site":"","pv":0,"price":"0.00","num":0,"goodscore":100,"sslmid":"","sslmpid":"","isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":null,"height":0,"weight":0,"age":0,"email":"","id":52,"team":0,"groupid":0,"isshopvip":0,"shopivipstat":0,"shopivipendt":0,"company":null,"sincerity":0,"platform":0,"college":0,"team2":0,"recommend":null,"shopimg":null,"content":null,"background":"http://boyiapi.xxwlb.com","qualifications":""}
         */

        private TokenBean token;
        private UserBean user;

        public TokenBean getToken() {
            return token;
        }

        public void setToken(TokenBean token) {
            this.token = token;
        }

        public UserBean getUser() {
            return user;
        }

        public void setUser(UserBean user) {
            this.user = user;
        }

        public static class TokenBean {
            /**
             * token : eebd00e68cae169cfc1b1f65991b2c56523e1429
             * userid : 137
             * login_time : 1517390356
             * type : 0
             */

            private String token;
            private int userid;
            private int login_time;
            private String type;
            private String im_token;

            public String getIm_token() {
                return im_token;
            }

            public void setIm_token(String im_token) {
                this.im_token = im_token;
            }

            public String getToken() {
                return token;
            }

            public void setToken(String token) {
                this.token = token;
            }

            public int getUserid() {
                return userid;
            }

            public void setUserid(int userid) {
                this.userid = userid;
            }

            public int getLogin_time() {
                return login_time;
            }

            public void setLogin_time(int login_time) {
                this.login_time = login_time;
            }

            public String getType() {
                return type;
            }

            public void setType(String type) {
                this.type = type;
            }
        }

        public static class UserBean {
            /**
             * userid : 137
             * usertype : 2
             * pid : 0
             * occupationid : 0
             * username : 18482180351
             * register : null
             * authentication : 0
             * name :
             * identitynum : null
             * money : 0.00
             * vouchers : 0.00
             * payvouchers : 0.00
             * pvouchers : 0.00
             * nickname : 林子
             * head : http://boyiapi.xxwlb.com/home/default/imghead.png
             * mobile : 18482180351
             * sex : 1
             * birthday : 650074088
             * provinceid : 24
             * cityid : 273
             * countyid : 2647
             * wachat_openid :
             * weibo_openid :
             * qq_openid :
             * logintime : null
             * state : 1
             * weixin : null
             * createtime : null
             * score : 100
             * fans : 0
             * evaluate : 0
             * payword : null
             * site :
             * pv : 0
             * price : 0.00
             * num : 0
             * goodscore : 100
             * sslmid :
             * sslmpid :
             * isuserivip : 0
             * userivipstat : 0
             * userivipendt : 0
             * sign : null
             * height : 0
             * weight : 0
             * age : 0
             * email :
             * id : 52
             * team : 0
             * groupid : 0
             * isshopvip : 0
             * shopivipstat : 0
             * shopivipendt : 0
             * company : null
             * sincerity : 0
             * platform : 0
             * college : 0
             * team2 : 0
             * recommend : null
             * shopimg : null
             * content : null
             * background : http://boyiapi.xxwlb.com
             * qualifications :
             */

            private int userid;
            private int usertype;
            private int pid;
            private int occupationid;
            private String username;
            private Object register;
            private int authentication;
            private String name;
            private Object identitynum;
            private String money;
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
            private String wachat_openid;
            private String weibo_openid;
            private String qq_openid;
            private Object logintime;
            private int state;
            private Object weixin;
            private Object createtime;
            private int score;
            private int fans;
            private int evaluate;
            private Object payword;
            private String site;
            private int pv;
            private String price;
            private int num;
            private int goodscore;
            private String sslmid;
            private String sslmpid;
            private int isuserivip;
            private int userivipstat;
            private int userivipendt;
            private Object sign;
            private int height;
            private int weight;
            private int age;
            private String email;
            private int id;
            private int team;
            private int groupid;
            private int isshopvip;
            private int shopivipstat;
            private int shopivipendt;
            private Object company;
            private int sincerity;
            private int platform;
            private int college;
            private int team2;
            private Object recommend;
            private Object shopimg;
            private Object content;
            private String background;
            private String qualifications;

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

            public int getPid() {
                return pid;
            }

            public void setPid(int pid) {
                this.pid = pid;
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

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }

            public Object getIdentitynum() {
                return identitynum;
            }

            public void setIdentitynum(Object identitynum) {
                this.identitynum = identitynum;
            }

            public String getMoney() {
                return money;
            }

            public void setMoney(String money) {
                this.money = money;
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

            public String getWachat_openid() {
                return wachat_openid;
            }

            public void setWachat_openid(String wachat_openid) {
                this.wachat_openid = wachat_openid;
            }

            public String getWeibo_openid() {
                return weibo_openid;
            }

            public void setWeibo_openid(String weibo_openid) {
                this.weibo_openid = weibo_openid;
            }

            public String getQq_openid() {
                return qq_openid;
            }

            public void setQq_openid(String qq_openid) {
                this.qq_openid = qq_openid;
            }

            public Object getLogintime() {
                return logintime;
            }

            public void setLogintime(Object logintime) {
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

            public Object getCreatetime() {
                return createtime;
            }

            public void setCreatetime(Object createtime) {
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

            public Object getPayword() {
                return payword;
            }

            public void setPayword(Object payword) {
                this.payword = payword;
            }

            public String getSite() {
                return site;
            }

            public void setSite(String site) {
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

            public String getSslmid() {
                return sslmid;
            }

            public void setSslmid(String sslmid) {
                this.sslmid = sslmid;
            }

            public String getSslmpid() {
                return sslmpid;
            }

            public void setSslmpid(String sslmpid) {
                this.sslmpid = sslmpid;
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

            public Object getSign() {
                return sign;
            }

            public void setSign(Object sign) {
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

            public int getId() {
                return id;
            }

            public void setId(int id) {
                this.id = id;
            }

            public int getTeam() {
                return team;
            }

            public void setTeam(int team) {
                this.team = team;
            }

            public int getGroupid() {
                return groupid;
            }

            public void setGroupid(int groupid) {
                this.groupid = groupid;
            }

            public int getIsshopvip() {
                return isshopvip;
            }

            public void setIsshopvip(int isshopvip) {
                this.isshopvip = isshopvip;
            }

            public int getShopivipstat() {
                return shopivipstat;
            }

            public void setShopivipstat(int shopivipstat) {
                this.shopivipstat = shopivipstat;
            }

            public int getShopivipendt() {
                return shopivipendt;
            }

            public void setShopivipendt(int shopivipendt) {
                this.shopivipendt = shopivipendt;
            }

            public Object getCompany() {
                return company;
            }

            public void setCompany(Object company) {
                this.company = company;
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

            public Object getRecommend() {
                return recommend;
            }

            public void setRecommend(Object recommend) {
                this.recommend = recommend;
            }

            public Object getShopimg() {
                return shopimg;
            }

            public void setShopimg(Object shopimg) {
                this.shopimg = shopimg;
            }

            public Object getContent() {
                return content;
            }

            public void setContent(Object content) {
                this.content = content;
            }

            public String getBackground() {
                return background;
            }

            public void setBackground(String background) {
                this.background = background;
            }

            public String getQualifications() {
                return qualifications;
            }

            public void setQualifications(String qualifications) {
                this.qualifications = qualifications;
            }
        }
    }
}

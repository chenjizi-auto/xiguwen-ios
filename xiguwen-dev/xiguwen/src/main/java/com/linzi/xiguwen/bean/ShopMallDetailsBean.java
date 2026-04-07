package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/4/7.
 */

public class ShopMallDetailsBean {

    /**
     * user : {"head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","nickname":"博艺婚嫁自营店","fans":2,"xinyu":{"a":"q","b":2},"follow":0}
     * shop : [{"shopid":160,"userid":67,"username":"13551862869","shopname":"ces","spec_name_1":"1","spec_name_2":"1","price":"1.00","columnid":63,"columnname":"中式礼服","pcolumnid":4,"pcolumnname":"婚纱礼服","coupons_price":"1.00","weigh":1,"expressid":14,"expressname":"免运费","shopimg":["http://imgcache.boyihunjia.com/d368c201804041407459614.png"],"number":0,"status":1,"time":1522822078,"state":2,"statetime":0,"company":"1","statecontent":"审核通过","num":0,"clicked":0,"followed":0,"saled":0,"provinceid":5,"cityid":48,"countyid":598,"province":"山西省","city":"太原市","county":"小店区"},{"shopid":137,"userid":67,"username":"13551862869","shopname":"测试商品3","spec_name_1":"颜色","spec_name_2":"尺码","price":"0.02","columnid":9,"columnname":"女士婚鞋","pcolumnid":5,"pcolumnname":"婚鞋箱包","coupons_price":"0.01","weigh":3,"expressid":15,"expressname":"五件包邮","shopimg":["http://www.boyihunjia.com/uploads/20180208/c215aca9e6805b29dfdbee7dd6c1c5d3.jpg","http://www.boyihunjia.com/uploads/20180208/224014d4e9bef230f7e23a149e2781a0.jpg","http://www.boyihunjia.com/uploads/20180208/9c814a1ca8e2d5b86ba65592a7ce0570.jpg","http://www.boyihunjia.com/uploads/20180208/879873dc34d706645d831553c53f317b.jpg"],"number":0,"status":1,"time":1521894743,"state":2,"statetime":1518081882,"company":"双","statecontent":"审核通过","num":0,"clicked":0,"followed":3,"saled":0,"provinceid":24,"cityid":273,"countyid":2639,"province":"四川省","city":"成都市","county":"武侯区"},{"shopid":136,"userid":67,"username":"13551862869","shopname":"测试商品2","spec_name_1":"颜色","spec_name_2":"尺码","price":"0.05","columnid":9,"columnname":"女士婚鞋","pcolumnid":5,"pcolumnname":"婚鞋箱包","coupons_price":"0.01","weigh":2,"expressid":14,"expressname":"免运费","shopimg":["http://www.boyihunjia.com/uploads/20180208/d9517c6d161f6826da588c82786ee5ef.jpg","http://www.boyihunjia.com/uploads/20180208/355f05dbd803bc93d4c4c4b076f42328.jpg","http://www.boyihunjia.com/uploads/20180208/53036265e0157de5320e7d1f5d7ce94e.jpg","http://www.boyihunjia.com/uploads/20180208/e1b35e03c52c297f4c6d93b5a7aa5eac.jpg"],"number":0,"status":1,"time":1521894732,"state":2,"statetime":1518072772,"company":"双","statecontent":"审核通过","num":0,"clicked":0,"followed":5,"saled":0,"provinceid":24,"cityid":273,"countyid":2639,"province":"四川省","city":"成都市","county":"武侯区"},{"shopid":135,"userid":67,"username":"13551862869","shopname":"测试商品1","spec_name_1":"颜色","spec_name_2":"尺码","price":"0.02","columnid":7,"columnname":"新郎礼服","pcolumnid":4,"pcolumnname":"婚纱礼服","coupons_price":"0.01","weigh":1,"expressid":11,"expressname":"89包邮","shopimg":["http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg","http://www.boyihunjia.com/uploads/20180208/5ca060584188cba60d9df2cb52f1bde0.jpg","http://www.boyihunjia.com/uploads/20180208/1eb1d84625c397d1887e119edc87b6b6.jpg","http://www.boyihunjia.com/uploads/20180208/20bf75574b6172746d97f568090f2987.jpg"],"number":0,"status":1,"time":1521894715,"state":2,"statetime":1518072453,"company":"套","statecontent":"审核通过","num":0,"clicked":0,"followed":15,"saled":0,"provinceid":24,"cityid":273,"countyid":2636,"province":"四川省","city":"成都市","county":"锦江区"}]
     * num : 4
     */

    private UserBean user;
    private int num;
    private List<ShopBean> shop;

    public UserBean getUser() {
        return user;
    }

    public void setUser(UserBean user) {
        this.user = user;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<ShopBean> getShop() {
        return shop;
    }

    public void setShop(List<ShopBean> shop) {
        this.shop = shop;
    }

    public static class UserBean {
        /**
         * head : http://imgcache.boyihunjia.com/9769c201803120905146801.png
         * nickname : 博艺婚嫁自营店
         * fans : 2
         * xinyu : {"a":"q","b":2}
         * follow : 0
         */

        private String head;
        private String nickname;
        private int fans;
        private XinyuBean xinyu;
        private int follow;
        private int userid;

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
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

        public int getFans() {
            return fans;
        }

        public void setFans(int fans) {
            this.fans = fans;
        }

        public XinyuBean getXinyu() {
            return xinyu;
        }

        public void setXinyu(XinyuBean xinyu) {
            this.xinyu = xinyu;
        }

        public int getFollow() {
            return follow;
        }

        public void setFollow(int follow) {
            this.follow = follow;
        }

        public static class XinyuBean {
            /**
             * a : q
             * b : 2
             */

            private String a;
            private int b;

            public String getA() {
                return a;
            }

            public void setA(String a) {
                this.a = a;
            }

            public int getB() {
                return b;
            }

            public void setB(int b) {
                this.b = b;
            }
        }
    }

    public static class ShopBean {
        /**
         * shopid : 160
         * userid : 67
         * username : 13551862869
         * shopname : ces
         * spec_name_1 : 1
         * spec_name_2 : 1
         * price : 1.00
         * columnid : 63
         * columnname : 中式礼服
         * pcolumnid : 4
         * pcolumnname : 婚纱礼服
         * coupons_price : 1.00
         * weigh : 1
         * expressid : 14
         * expressname : 免运费
         * shopimg : ["http://imgcache.boyihunjia.com/d368c201804041407459614.png"]
         * number : 0
         * status : 1
         * time : 1522822078
         * state : 2
         * statetime : 0
         * company : 1
         * statecontent : 审核通过
         * num : 0
         * clicked : 0
         * followed : 0
         * saled : 0
         * provinceid : 5
         * cityid : 48
         * countyid : 598
         * province : 山西省
         * city : 太原市
         * county : 小店区
         */

        private int shopid;
        private int userid;
        private String username;
        private String shopname;
        private String spec_name_1;
        private String spec_name_2;
        private String price;
        private int columnid;
        private String columnname;
        private int pcolumnid;
        private String pcolumnname;
        private String coupons_price;
        private int weigh;
        private int expressid;
        private String expressname;
        private int number;
        private int status;
        private int time;
        private int state;
        private int statetime;
        private String company;
        private String statecontent;
        private int num;
        private int clicked;
        private int followed;
        private int saled;
        private int provinceid;
        private int cityid;
        private int countyid;
        private String province;
        private String city;
        private String county;
        private List<String> shopimg;

        public int getShopid() {
            return shopid;
        }

        public void setShopid(int shopid) {
            this.shopid = shopid;
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

        public String getShopname() {
            return shopname;
        }

        public void setShopname(String shopname) {
            this.shopname = shopname;
        }

        public String getSpec_name_1() {
            return spec_name_1;
        }

        public void setSpec_name_1(String spec_name_1) {
            this.spec_name_1 = spec_name_1;
        }

        public String getSpec_name_2() {
            return spec_name_2;
        }

        public void setSpec_name_2(String spec_name_2) {
            this.spec_name_2 = spec_name_2;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public int getColumnid() {
            return columnid;
        }

        public void setColumnid(int columnid) {
            this.columnid = columnid;
        }

        public String getColumnname() {
            return columnname;
        }

        public void setColumnname(String columnname) {
            this.columnname = columnname;
        }

        public int getPcolumnid() {
            return pcolumnid;
        }

        public void setPcolumnid(int pcolumnid) {
            this.pcolumnid = pcolumnid;
        }

        public String getPcolumnname() {
            return pcolumnname;
        }

        public void setPcolumnname(String pcolumnname) {
            this.pcolumnname = pcolumnname;
        }

        public String getCoupons_price() {
            return coupons_price;
        }

        public void setCoupons_price(String coupons_price) {
            this.coupons_price = coupons_price;
        }

        public int getWeigh() {
            return weigh;
        }

        public void setWeigh(int weigh) {
            this.weigh = weigh;
        }

        public int getExpressid() {
            return expressid;
        }

        public void setExpressid(int expressid) {
            this.expressid = expressid;
        }

        public String getExpressname() {
            return expressname;
        }

        public void setExpressname(String expressname) {
            this.expressname = expressname;
        }

        public int getNumber() {
            return number;
        }

        public void setNumber(int number) {
            this.number = number;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getTime() {
            return time;
        }

        public void setTime(int time) {
            this.time = time;
        }

        public int getState() {
            return state;
        }

        public void setState(int state) {
            this.state = state;
        }

        public int getStatetime() {
            return statetime;
        }

        public void setStatetime(int statetime) {
            this.statetime = statetime;
        }

        public String getCompany() {
            return company;
        }

        public void setCompany(String company) {
            this.company = company;
        }

        public String getStatecontent() {
            return statecontent;
        }

        public void setStatecontent(String statecontent) {
            this.statecontent = statecontent;
        }

        public int getNum() {
            return num;
        }

        public void setNum(int num) {
            this.num = num;
        }

        public int getClicked() {
            return clicked;
        }

        public void setClicked(int clicked) {
            this.clicked = clicked;
        }

        public int getFollowed() {
            return followed;
        }

        public void setFollowed(int followed) {
            this.followed = followed;
        }

        public int getSaled() {
            return saled;
        }

        public void setSaled(int saled) {
            this.saled = saled;
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

        public String getProvince() {
            return province;
        }

        public void setProvince(String province) {
            this.province = province;
        }

        public String getCity() {
            return city;
        }

        public void setCity(String city) {
            this.city = city;
        }

        public String getCounty() {
            return county;
        }

        public void setCounty(String county) {
            this.county = county;
        }

        public List<String> getShopimg() {
            return shopimg;
        }

        public void setShopimg(List<String> shopimg) {
            this.shopimg = shopimg;
        }
    }
}

package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/4/12.
 */

public class WeddingOrderBean {

    private UserBean user;
    private List<String> ids;
    private List<CartlistBean> cartlist;
    private String heji;

    public String getHeji() {
        return heji;
    }

    public void setHeji(String heji) {
        this.heji = heji;
    }

    public UserBean getUser() {
        return user;
    }

    public void setUser(UserBean user) {
        this.user = user;
    }

    public List<String> getIds() {
        return ids;
    }

    public void setIds(List<String> ids) {
        this.ids = ids;
    }

    public List<CartlistBean> getCartlist() {
        return cartlist;
    }

    public void setCartlist(List<CartlistBean> cartlist) {
        this.cartlist = cartlist;
    }

    public static class UserBean {

        private int userid;

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }
    }

    public static class CartlistBean {

        private int store_id;
        private SellerBean seller;
        private List<GoodsBean> goods;

        public int getStore_id() {
            return store_id;
        }

        public void setStore_id(int store_id) {
            this.store_id = store_id;
        }

        public SellerBean getSeller() {
            return seller;
        }

        public void setSeller(SellerBean seller) {
            this.seller = seller;
        }

        public List<GoodsBean> getGoods() {
            return goods;
        }

        public void setGoods(List<GoodsBean> goods) {
            this.goods = goods;
        }

        public static class SellerBean {
            /**
             * userid : 1475
             * usertype : 2
             * pid : 1256
             * occupationid : 2
             * username : 13881918001
             * password : 3529ef7c706eb86d2e1893eba377adb5
             * salt : aGSg43pO
             * token : 1475-f05acf33bbe6fd36865aff6fac7192c5
             * im_token : null
             * register : null
             * authentication : 0
             * name : null
             * identitynum : null
             * money : 0.00
             * vouchers : 20.00
             * payvouchers : 0.00
             * pvouchers : 20.00
             * nickname : 主持人 容幸
             * head : http://imgcache.boyihunjia.com/34d65201803281057458703.jpg
             * mobile : 13881918001
             * sex : 1
             * birthday : 650041200
             * provinceid : 24
             * cityid : 273
             * countyid : 2637
             * wachat_openid :
             * weibo_openid :
             * qq_openid :
             * logintime : 1522205553
             * state : 1
             * weixin : null
             * createtime : 1522205535
             * score : 100
             * fans : 1
             * evaluate : 0
             * payword : null
             * site :
             * pv : 20
             * price : 800.00
             * num : 0
             * goodscore : 100
             * sslmid : 100041
             * sslmpid : 0,100217,100121
             * isuserivip : 0
             * userivipstat : null
             * userivipendt : null
             * sign : 1
             * height : 0
             * weight : 0
             * age : 0
             * email :
             * isuseriviptoken : 0
             * onlinestatus : 1
             * inviter : 18200414356
             * sort : 1
             * bool : 0
             */

            private int userid;
            private int usertype;
            private int pid;
            private int occupationid;
            private String username;
            private String token;
            private String money;
            private String nickname;
            private String head;
            private String mobile;
            private String wachat_openid;
            private String weibo_openid;
            private String qq_openid;
            private int logintime;
            private int state;
            private int createtime;
            private int score;
            private int fans;
            private int evaluate;
            private String site;
            private int pv;
            private String price;
            private int num;
            private int goodscore;
            private String sslmid;
            private String sslmpid;
            private int isuserivip;
            private int sign;
            private String email;
            private String isuseriviptoken;
            private int onlinestatus;
            private String inviter;

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

            public String getToken() {
                return token;
            }

            public void setToken(String token) {
                this.token = token;
            }

            public String getMoney() {
                return money;
            }

            public void setMoney(String money) {
                this.money = money;
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


            public int getSign() {
                return sign;
            }

            public void setSign(int sign) {
                this.sign = sign;
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

        }

        public static class GoodsBean {
            /**
             * quotationid : 359
             * userid : 1475
             * uname : 13881918001
             * name : 西式婚礼主持
             * price : 800.00
             * deposit : 0.00
             * company :
             * deductible : 0.00
             * weigh : 2
             * imglist : a:1:{i:0;s:58:"http://imgcache.boyihunjia.com/f2e08201803281105425002.jpg";}
             * content :
             * rule1key : null
             * rule2key : null
             * rule3key : null
             * state : 2
             * statecontent : 审核通过
             * status : 1
             * createtime : 1522206343
             * statetime : 1522206520
             * number : 0
             * temporarypay : 400.00
             * rule1val : null
             * rule2val : null
             * rule3val : null
             * num : 0
             * pv : 11
             * haopin : 100
             * wapcont : null
             * subtotal : 400.00
             * dikoutotal : 0.00
             * baojia_image : http://imgcache.boyihunjia.com/f2e08201803281105425002.jpg
             * goods_image : null
             * rec_id : 359
             * baojia_name : 西式婚礼主持
             * specification : 2019-4-27  中午
             * quantity : 1
             * paytype : 2
             * yuandingjin : 400.00
             * zquantity : 1
             * zongjine : 800
             * zongdingjin : 400
             * zongdikou : 0
             * heji : 400.00
             */
            private String remarkStr;
            private int quotationid;
            private int userid;
            private String uname;
            private String name;
            private String price;
            private String deposit;
            private String company;
            private String deductible;
            private int store_id;
            private int weigh;
            private String imglist;
            private String content;
            private int state;
            private String statecontent;
            private int status;
            private int createtime;
            private int statetime;
            private int number;
            private String temporarypay;
            private int num;
            private int pv;
            private int haopin;
            private String subtotal;
            private String dikoutotal;
            private String baojia_image;
            private String goods_image;
            private int rec_id;
            private String baojia_name;
            private String specification;
            private String quantity;
            private int paytype;
            private String yuandingjin;
            private String zquantity;
            private String zongjine;
            private String zongdingjin;
            private String zongdikou;
            private String heji;

            public int getStore_id() {
                return store_id;
            }

            public void setStore_id(int store_id) {
                this.store_id = store_id;
            }

            public String getRemarkStr() {
                return remarkStr;
            }

            public void setRemarkStr(String remarkStr) {
                this.remarkStr = remarkStr;
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

            public String getImglist() {
                return imglist;
            }

            public void setImglist(String imglist) {
                this.imglist = imglist;
            }

            public String getContent() {
                return content;
            }

            public void setContent(String content) {
                this.content = content;
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

            public String getSubtotal() {
                return subtotal;
            }

            public void setSubtotal(String subtotal) {
                this.subtotal = subtotal;
            }

            public String getDikoutotal() {
                return dikoutotal;
            }

            public void setDikoutotal(String dikoutotal) {
                this.dikoutotal = dikoutotal;
            }

            public String getBaojia_image() {
                return baojia_image;
            }

            public void setBaojia_image(String baojia_image) {
                this.baojia_image = baojia_image;
            }

            public String getGoods_image() {
                return goods_image;
            }

            public void setGoods_image(String goods_image) {
                this.goods_image = goods_image;
            }

            public int getRec_id() {
                return rec_id;
            }

            public void setRec_id(int rec_id) {
                this.rec_id = rec_id;
            }

            public String getBaojia_name() {
                return baojia_name;
            }

            public void setBaojia_name(String baojia_name) {
                this.baojia_name = baojia_name;
            }

            public String getSpecification() {
                return specification;
            }

            public void setSpecification(String specification) {
                this.specification = specification;
            }

            public String getQuantity() {
                return quantity;
            }

            public void setQuantity(String quantity) {
                this.quantity = quantity;
            }

            public int getPaytype() {
                return paytype;
            }

            public void setPaytype(int paytype) {
                this.paytype = paytype;
            }

            public String getYuandingjin() {
                return yuandingjin;
            }

            public void setYuandingjin(String yuandingjin) {
                this.yuandingjin = yuandingjin;
            }

            public String getZquantity() {
                return zquantity;
            }

            public void setZquantity(String zquantity) {
                this.zquantity = zquantity;
            }

            public String getZongjine() {
                return zongjine;
            }

            public void setZongjine(String zongjine) {
                this.zongjine = zongjine;
            }

            public String getZongdingjin() {
                return zongdingjin;
            }

            public void setZongdingjin(String zongdingjin) {
                this.zongdingjin = zongdingjin;
            }

            public String getZongdikou() {
                return zongdikou;
            }

            public void setZongdikou(String zongdikou) {
                this.zongdikou = zongdikou;
            }

            public String getHeji() {
                return heji;
            }

            public void setHeji(String heji) {
                this.heji = heji;
            }
        }
    }
}

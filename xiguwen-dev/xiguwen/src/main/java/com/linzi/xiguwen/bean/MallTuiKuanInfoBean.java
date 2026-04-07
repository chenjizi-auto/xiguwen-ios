package com.linzi.xiguwen.bean;

/**
 * Created by pc on 2018/5/4.
 */

public class MallTuiKuanInfoBean {

    /**
     * goodsinfo : {"rec_id":125,"order_id":95,"goods_id":135,"goods_name":"测试商品1","spec_id":369,"specification":"颜色:大红 尺码:L","price":"0.02","quantity":1,"goods_image":"http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg","evaluation":0,"remark":"","credit_value":0,"is_valid":1,"is_approve":0}
     * orderinfo : {"order_id":95,"order_sn":"shopdsj2018050317300438433","pid":"shopdsj2018050317300438433","type":"wedding","extension":null,"seller_id":67,"seller_name":"博艺婚嫁自营店","buyer_id":16,"buyer_name":"杜卡基老师","buyer_email":"","status":60,"published":1525339804,"payment_id":null,"payment_name":null,"payment_code":"","out_trade_no":null,"pay_time":null,"pay_message":"","invoice_no":null,"finished_time":0,"goods_amount":"0.02","discount":"0.01","order_amount":"0.01","anonymous":0,"postname":"博艺","postaddress":"四川省成都市武侯区云华路333号","postmobile":"15982375702","postaddressid":126,"kuaidicode":null,"kuaidinum":null,"kuaiditime":null,"received_time":null,"comment_time":null,"source":1,"tuihuo":1,"shouqian":1,"mobile":"13551862869","user_im":"user16","shop_im":"user67"}
     */

    private GoodsinfoBean goodsinfo;
    private OrderinfoBean orderinfo;

    public GoodsinfoBean getGoodsinfo() {
        return goodsinfo;
    }

    public void setGoodsinfo(GoodsinfoBean goodsinfo) {
        this.goodsinfo = goodsinfo;
    }

    public OrderinfoBean getOrderinfo() {
        return orderinfo;
    }

    public void setOrderinfo(OrderinfoBean orderinfo) {
        this.orderinfo = orderinfo;
    }

    public static class GoodsinfoBean {
        /**
         * rec_id : 125
         * order_id : 95
         * goods_id : 135
         * goods_name : 测试商品1
         * spec_id : 369
         * specification : 颜色:大红 尺码:L
         * price : 0.02
         * quantity : 1
         * goods_image : http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg
         * evaluation : 0
         * remark :
         * credit_value : 0
         * is_valid : 1
         * is_approve : 0
         */

        private int rec_id;
        private int order_id;
        private int goods_id;
        private String goods_name;
        private int spec_id;
        private String specification;
        private String price;
        private int quantity;
        private String goods_image;
        private int evaluation;
        private String remark;
        private int credit_value;
        private int is_valid;
        private int is_approve;

        public int getRec_id() {
            return rec_id;
        }

        public void setRec_id(int rec_id) {
            this.rec_id = rec_id;
        }

        public int getOrder_id() {
            return order_id;
        }

        public void setOrder_id(int order_id) {
            this.order_id = order_id;
        }

        public int getGoods_id() {
            return goods_id;
        }

        public void setGoods_id(int goods_id) {
            this.goods_id = goods_id;
        }

        public String getGoods_name() {
            return goods_name;
        }

        public void setGoods_name(String goods_name) {
            this.goods_name = goods_name;
        }

        public int getSpec_id() {
            return spec_id;
        }

        public void setSpec_id(int spec_id) {
            this.spec_id = spec_id;
        }

        public String getSpecification() {
            return specification;
        }

        public void setSpecification(String specification) {
            this.specification = specification;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public String getGoods_image() {
            return goods_image;
        }

        public void setGoods_image(String goods_image) {
            this.goods_image = goods_image;
        }

        public int getEvaluation() {
            return evaluation;
        }

        public void setEvaluation(int evaluation) {
            this.evaluation = evaluation;
        }

        public String getRemark() {
            return remark;
        }

        public void setRemark(String remark) {
            this.remark = remark;
        }

        public int getCredit_value() {
            return credit_value;
        }

        public void setCredit_value(int credit_value) {
            this.credit_value = credit_value;
        }

        public int getIs_valid() {
            return is_valid;
        }

        public void setIs_valid(int is_valid) {
            this.is_valid = is_valid;
        }

        public int getIs_approve() {
            return is_approve;
        }

        public void setIs_approve(int is_approve) {
            this.is_approve = is_approve;
        }
    }

    public static class OrderinfoBean {
        /**
         * order_id : 95
         * order_sn : shopdsj2018050317300438433
         * pid : shopdsj2018050317300438433
         * type : wedding
         * extension : null
         * seller_id : 67
         * seller_name : 博艺婚嫁自营店
         * buyer_id : 16
         * buyer_name : 杜卡基老师
         * buyer_email :
         * status : 60
         * published : 1525339804
         * payment_id : null
         * payment_name : null
         * payment_code :
         * out_trade_no : null
         * pay_time : null
         * pay_message :
         * invoice_no : null
         * finished_time : 0
         * goods_amount : 0.02
         * discount : 0.01
         * order_amount : 0.01
         * anonymous : 0
         * postname : 博艺
         * postaddress : 四川省成都市武侯区云华路333号
         * postmobile : 15982375702
         * postaddressid : 126
         * kuaidicode : null
         * kuaidinum : null
         * kuaiditime : null
         * received_time : null
         * comment_time : null
         * source : 1
         * tuihuo : 1
         * shouqian : 1
         * mobile : 13551862869
         * user_im : user16
         * shop_im : user67
         */

        private int order_id;
        private String order_sn;
        private String pid;
        private String type;
        private Object extension;
        private int seller_id;
        private String seller_name;
        private int buyer_id;
        private String buyer_name;
        private String buyer_email;
        private int status;
        private int published;
        private Object payment_id;
        private Object payment_name;
        private String payment_code;
        private Object out_trade_no;
        private Object pay_time;
        private String pay_message;
        private Object invoice_no;
        private int finished_time;
        private String goods_amount;
        private String discount;
        private String order_amount;
        private int anonymous;
        private String postname;
        private String postaddress;
        private String postmobile;
        private int postaddressid;
        private Object kuaidicode;
        private Object kuaidinum;
        private Object kuaiditime;
        private Object received_time;
        private Object comment_time;
        private int source;
        private int tuihuo;
        private int shouqian;
        private String mobile;
        private String user_im;
        private String shop_im;

        public int getOrder_id() {
            return order_id;
        }

        public void setOrder_id(int order_id) {
            this.order_id = order_id;
        }

        public String getOrder_sn() {
            return order_sn;
        }

        public void setOrder_sn(String order_sn) {
            this.order_sn = order_sn;
        }

        public String getPid() {
            return pid;
        }

        public void setPid(String pid) {
            this.pid = pid;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public Object getExtension() {
            return extension;
        }

        public void setExtension(Object extension) {
            this.extension = extension;
        }

        public int getSeller_id() {
            return seller_id;
        }

        public void setSeller_id(int seller_id) {
            this.seller_id = seller_id;
        }

        public String getSeller_name() {
            return seller_name;
        }

        public void setSeller_name(String seller_name) {
            this.seller_name = seller_name;
        }

        public int getBuyer_id() {
            return buyer_id;
        }

        public void setBuyer_id(int buyer_id) {
            this.buyer_id = buyer_id;
        }

        public String getBuyer_name() {
            return buyer_name;
        }

        public void setBuyer_name(String buyer_name) {
            this.buyer_name = buyer_name;
        }

        public String getBuyer_email() {
            return buyer_email;
        }

        public void setBuyer_email(String buyer_email) {
            this.buyer_email = buyer_email;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getPublished() {
            return published;
        }

        public void setPublished(int published) {
            this.published = published;
        }

        public Object getPayment_id() {
            return payment_id;
        }

        public void setPayment_id(Object payment_id) {
            this.payment_id = payment_id;
        }

        public Object getPayment_name() {
            return payment_name;
        }

        public void setPayment_name(Object payment_name) {
            this.payment_name = payment_name;
        }

        public String getPayment_code() {
            return payment_code;
        }

        public void setPayment_code(String payment_code) {
            this.payment_code = payment_code;
        }

        public Object getOut_trade_no() {
            return out_trade_no;
        }

        public void setOut_trade_no(Object out_trade_no) {
            this.out_trade_no = out_trade_no;
        }

        public Object getPay_time() {
            return pay_time;
        }

        public void setPay_time(Object pay_time) {
            this.pay_time = pay_time;
        }

        public String getPay_message() {
            return pay_message;
        }

        public void setPay_message(String pay_message) {
            this.pay_message = pay_message;
        }

        public Object getInvoice_no() {
            return invoice_no;
        }

        public void setInvoice_no(Object invoice_no) {
            this.invoice_no = invoice_no;
        }

        public int getFinished_time() {
            return finished_time;
        }

        public void setFinished_time(int finished_time) {
            this.finished_time = finished_time;
        }

        public String getGoods_amount() {
            return goods_amount;
        }

        public void setGoods_amount(String goods_amount) {
            this.goods_amount = goods_amount;
        }

        public String getDiscount() {
            return discount;
        }

        public void setDiscount(String discount) {
            this.discount = discount;
        }

        public String getOrder_amount() {
            return order_amount;
        }

        public void setOrder_amount(String order_amount) {
            this.order_amount = order_amount;
        }

        public int getAnonymous() {
            return anonymous;
        }

        public void setAnonymous(int anonymous) {
            this.anonymous = anonymous;
        }

        public String getPostname() {
            return postname;
        }

        public void setPostname(String postname) {
            this.postname = postname;
        }

        public String getPostaddress() {
            return postaddress;
        }

        public void setPostaddress(String postaddress) {
            this.postaddress = postaddress;
        }

        public String getPostmobile() {
            return postmobile;
        }

        public void setPostmobile(String postmobile) {
            this.postmobile = postmobile;
        }

        public int getPostaddressid() {
            return postaddressid;
        }

        public void setPostaddressid(int postaddressid) {
            this.postaddressid = postaddressid;
        }

        public Object getKuaidicode() {
            return kuaidicode;
        }

        public void setKuaidicode(Object kuaidicode) {
            this.kuaidicode = kuaidicode;
        }

        public Object getKuaidinum() {
            return kuaidinum;
        }

        public void setKuaidinum(Object kuaidinum) {
            this.kuaidinum = kuaidinum;
        }

        public Object getKuaiditime() {
            return kuaiditime;
        }

        public void setKuaiditime(Object kuaiditime) {
            this.kuaiditime = kuaiditime;
        }

        public Object getReceived_time() {
            return received_time;
        }

        public void setReceived_time(Object received_time) {
            this.received_time = received_time;
        }

        public Object getComment_time() {
            return comment_time;
        }

        public void setComment_time(Object comment_time) {
            this.comment_time = comment_time;
        }

        public int getSource() {
            return source;
        }

        public void setSource(int source) {
            this.source = source;
        }

        public int getTuihuo() {
            return tuihuo;
        }

        public void setTuihuo(int tuihuo) {
            this.tuihuo = tuihuo;
        }

        public int getShouqian() {
            return shouqian;
        }

        public void setShouqian(int shouqian) {
            this.shouqian = shouqian;
        }

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }

        public String getUser_im() {
            return user_im;
        }

        public void setUser_im(String user_im) {
            this.user_im = user_im;
        }

        public String getShop_im() {
            return shop_im;
        }

        public void setShop_im(String shop_im) {
            this.shop_im = shop_im;
        }
    }
}

package com.linzi.xiguwen.bean;

/**
 * Created by pc on 2018/4/19.
 */

public class WeddingJieDanRefundBean {

    /**
     * tuikuan : {"fund_id":24,"order_id":734,"tui_amount":"0.05","tui_yuanyin":"是非公经济","shangjajj_yuanyin":null,"status":1,"user_id":16,"seller_id":1121,"created_at":1524135240,"updated_at":null,"cldated_at":null}
     * orderinfo : {"order_id":734,"order_sn":"wedding2018041719432796352","pid":"wedding2018041719432796352","order_snwk":null,"type":"wedding","extension":null,"seller_id":1121,"seller_name":null,"buyer_id":16,"buyer_name":"福利局","baojia_id":471,"baojia_image":"http://imgcache.boyihunjia.com/57de3201804171938493484.png","baojia_name":"测试商品一二三","baojia_price":"0.10","baojia_date":"2021-04-23","baojia_time":3,"specification":"2021-04-23 下午","quantity":1,"status":70,"paytype":2,"published":1523965407,"payment_code":"alipay","payment_name":"支付宝","out_trade_no":"2018041721001004210575538809","pay_time":1523965461,"pay_message":"","goods_amount":"0.10","discount":"0.00","order_amount":"0.05","order_lastamount":"0.05","order_lastmethod":null,"received_time":1523965474,"sureok_time":null,"comment_time":null,"remark":null,"wkpay_code":null,"wkpay_name":null,"wkpay_time":null,"wkout_trade_no":null,"source":1,"tuihuo":2,"mobile":"15928967476","jine":"0.05"}
     */

    private TuikuanBean tuikuan;
    private OrderinfoBean orderinfo;

    public TuikuanBean getTuikuan() {
        return tuikuan;
    }

    public void setTuikuan(TuikuanBean tuikuan) {
        this.tuikuan = tuikuan;
    }

    public OrderinfoBean getOrderinfo() {
        return orderinfo;
    }

    public void setOrderinfo(OrderinfoBean orderinfo) {
        this.orderinfo = orderinfo;
    }

    public static class TuikuanBean {
        /**
         * fund_id : 24
         * order_id : 734
         * tui_amount : 0.05
         * tui_yuanyin : 是非公经济
         * shangjajj_yuanyin : null
         * status : 1
         * user_id : 16
         * seller_id : 1121
         * created_at : 1524135240
         * updated_at : null
         * cldated_at : null
         */

        private int fund_id;
        private int order_id;
        private String tui_amount;
        private String tui_yuanyin;
        private Object shangjajj_yuanyin;
        private int status;
        private int user_id;
        private int seller_id;
        private int created_at;
        private Object updated_at;
        private Object cldated_at;

        public int getFund_id() {
            return fund_id;
        }

        public void setFund_id(int fund_id) {
            this.fund_id = fund_id;
        }

        public int getOrder_id() {
            return order_id;
        }

        public void setOrder_id(int order_id) {
            this.order_id = order_id;
        }

        public String getTui_amount() {
            return tui_amount;
        }

        public void setTui_amount(String tui_amount) {
            this.tui_amount = tui_amount;
        }

        public String getTui_yuanyin() {
            return tui_yuanyin;
        }

        public void setTui_yuanyin(String tui_yuanyin) {
            this.tui_yuanyin = tui_yuanyin;
        }

        public Object getShangjajj_yuanyin() {
            return shangjajj_yuanyin;
        }

        public void setShangjajj_yuanyin(Object shangjajj_yuanyin) {
            this.shangjajj_yuanyin = shangjajj_yuanyin;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
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

        public int getCreated_at() {
            return created_at;
        }

        public void setCreated_at(int created_at) {
            this.created_at = created_at;
        }

        public Object getUpdated_at() {
            return updated_at;
        }

        public void setUpdated_at(Object updated_at) {
            this.updated_at = updated_at;
        }

        public Object getCldated_at() {
            return cldated_at;
        }

        public void setCldated_at(Object cldated_at) {
            this.cldated_at = cldated_at;
        }
    }

    public static class OrderinfoBean {
        /**
         * order_id : 734
         * order_sn : wedding2018041719432796352
         * pid : wedding2018041719432796352
         * order_snwk : null
         * type : wedding
         * extension : null
         * seller_id : 1121
         * seller_name : null
         * buyer_id : 16
         * buyer_name : 福利局
         * baojia_id : 471
         * baojia_image : http://imgcache.boyihunjia.com/57de3201804171938493484.png
         * baojia_name : 测试商品一二三
         * baojia_price : 0.10
         * baojia_date : 2021-04-23
         * baojia_time : 3
         * specification : 2021-04-23 下午
         * quantity : 1
         * status : 70
         * paytype : 2
         * published : 1523965407
         * payment_code : alipay
         * payment_name : 支付宝
         * out_trade_no : 2018041721001004210575538809
         * pay_time : 1523965461
         * pay_message :
         * goods_amount : 0.10
         * discount : 0.00
         * order_amount : 0.05
         * order_lastamount : 0.05
         * order_lastmethod : null
         * received_time : 1523965474
         * sureok_time : null
         * comment_time : null
         * remark : null
         * wkpay_code : null
         * wkpay_name : null
         * wkpay_time : null
         * wkout_trade_no : null
         * source : 1
         * tuihuo : 2
         * mobile : 15928967476
         * jine : 0.05
         */

        private int order_id;
        private String order_sn;
        private String pid;
        private Object order_snwk;
        private String type;
        private Object extension;
        private int seller_id;
        private Object seller_name;
        private int buyer_id;
        private String buyer_name;
        private int baojia_id;
        private String baojia_image;
        private String baojia_name;
        private String baojia_price;
        private String baojia_date;
        private int baojia_time;
        private String specification;
        private int quantity;
        private int status;
        private int paytype;
        private int published;
        private String payment_code;
        private String payment_name;
        private String out_trade_no;
        private int pay_time;
        private String pay_message;
        private String goods_amount;
        private String discount;
        private String order_amount;
        private String order_lastamount;
        private Object order_lastmethod;
        private int received_time;
        private Object sureok_time;
        private Object comment_time;
        private Object remark;
        private Object wkpay_code;
        private Object wkpay_name;
        private Object wkpay_time;
        private Object wkout_trade_no;
        private int source;
        private int tuihuo;
        private String mobile;
        private String jine;
        private String userim;
        private String usermobile;

        public String getUsermobile() {
            return usermobile;
        }

        public void setUsermobile(String usermobile) {
            this.usermobile = usermobile;
        }

        public String getUserim() {
            return userim;
        }

        public void setUserim(String userim) {
            this.userim = userim;
        }

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

        public Object getOrder_snwk() {
            return order_snwk;
        }

        public void setOrder_snwk(Object order_snwk) {
            this.order_snwk = order_snwk;
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

        public Object getSeller_name() {
            return seller_name;
        }

        public void setSeller_name(Object seller_name) {
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

        public int getBaojia_id() {
            return baojia_id;
        }

        public void setBaojia_id(int baojia_id) {
            this.baojia_id = baojia_id;
        }

        public String getBaojia_image() {
            return baojia_image;
        }

        public void setBaojia_image(String baojia_image) {
            this.baojia_image = baojia_image;
        }

        public String getBaojia_name() {
            return baojia_name;
        }

        public void setBaojia_name(String baojia_name) {
            this.baojia_name = baojia_name;
        }

        public String getBaojia_price() {
            return baojia_price;
        }

        public void setBaojia_price(String baojia_price) {
            this.baojia_price = baojia_price;
        }

        public String getBaojia_date() {
            return baojia_date;
        }

        public void setBaojia_date(String baojia_date) {
            this.baojia_date = baojia_date;
        }

        public int getBaojia_time() {
            return baojia_time;
        }

        public void setBaojia_time(int baojia_time) {
            this.baojia_time = baojia_time;
        }

        public String getSpecification() {
            return specification;
        }

        public void setSpecification(String specification) {
            this.specification = specification;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getPaytype() {
            return paytype;
        }

        public void setPaytype(int paytype) {
            this.paytype = paytype;
        }

        public int getPublished() {
            return published;
        }

        public void setPublished(int published) {
            this.published = published;
        }

        public String getPayment_code() {
            return payment_code;
        }

        public void setPayment_code(String payment_code) {
            this.payment_code = payment_code;
        }

        public String getPayment_name() {
            return payment_name;
        }

        public void setPayment_name(String payment_name) {
            this.payment_name = payment_name;
        }

        public String getOut_trade_no() {
            return out_trade_no;
        }

        public void setOut_trade_no(String out_trade_no) {
            this.out_trade_no = out_trade_no;
        }

        public int getPay_time() {
            return pay_time;
        }

        public void setPay_time(int pay_time) {
            this.pay_time = pay_time;
        }

        public String getPay_message() {
            return pay_message;
        }

        public void setPay_message(String pay_message) {
            this.pay_message = pay_message;
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

        public String getOrder_lastamount() {
            return order_lastamount;
        }

        public void setOrder_lastamount(String order_lastamount) {
            this.order_lastamount = order_lastamount;
        }

        public Object getOrder_lastmethod() {
            return order_lastmethod;
        }

        public void setOrder_lastmethod(Object order_lastmethod) {
            this.order_lastmethod = order_lastmethod;
        }

        public int getReceived_time() {
            return received_time;
        }

        public void setReceived_time(int received_time) {
            this.received_time = received_time;
        }

        public Object getSureok_time() {
            return sureok_time;
        }

        public void setSureok_time(Object sureok_time) {
            this.sureok_time = sureok_time;
        }

        public Object getComment_time() {
            return comment_time;
        }

        public void setComment_time(Object comment_time) {
            this.comment_time = comment_time;
        }

        public Object getRemark() {
            return remark;
        }

        public void setRemark(Object remark) {
            this.remark = remark;
        }

        public Object getWkpay_code() {
            return wkpay_code;
        }

        public void setWkpay_code(Object wkpay_code) {
            this.wkpay_code = wkpay_code;
        }

        public Object getWkpay_name() {
            return wkpay_name;
        }

        public void setWkpay_name(Object wkpay_name) {
            this.wkpay_name = wkpay_name;
        }

        public Object getWkpay_time() {
            return wkpay_time;
        }

        public void setWkpay_time(Object wkpay_time) {
            this.wkpay_time = wkpay_time;
        }

        public Object getWkout_trade_no() {
            return wkout_trade_no;
        }

        public void setWkout_trade_no(Object wkout_trade_no) {
            this.wkout_trade_no = wkout_trade_no;
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

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }

        public String getJine() {
            return jine;
        }

        public void setJine(String jine) {
            this.jine = jine;
        }
    }
}

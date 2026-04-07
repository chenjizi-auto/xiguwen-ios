package com.linzi.xiguwen.bean;

/**
 * Created by pc on 2018/4/19.
 */

public class MallRefundBean {

    /**
     * refundinfo : {"fund_id":31,"order_id":151,"goods_id":135,"rec_id":169,"shop_jujue":"","tuikuan_yuanyin":"123123","tuihuo_image":"","tui_amount":"0.02","refund_type":1,"user_id":16,"seller_id":67,"created_at":1524055371,"updated_at":null,"refund_status":1,"cldated_at":0,"kuaidi":"","kuaidicode":"","mj_fahuoshijian":0,"shop_shoukuai":0,"jujueshouhuo":""}
     * goodsinfo : {"rec_id":169,"order_id":151,"goods_id":135,"goods_name":"测试商品1","spec_id":367,"specification":"颜色:中国红 尺码:M","price":"0.02","quantity":1,"goods_image":"http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg","evaluation":10,"remark":"","credit_value":0,"is_valid":1,"is_approve":0}
     * orderinfo : {"order_id":151,"order_sn":"shopdsj2018041809243894850","pid":"shopdsj2018041809243894850","type":"wedding","extension":null,"seller_id":67,"seller_name":"博艺婚嫁自营店","buyer_id":16,"buyer_name":"杜卡基老师","buyer_email":"","status":60,"published":1524014678,"payment_id":null,"payment_name":"支付宝","payment_code":"alipay","out_trade_no":"2018041821001004210576864154","pay_time":1524014692,"pay_message":"","invoice_no":null,"finished_time":0,"goods_amount":"0.21","discount":"0.00","order_amount":"0.21","anonymous":0,"postname":"大公鸡000","postaddress":"四川省成都市新都区哦陌生","postmobile":"46546478978","postaddressid":99,"kuaidicode":null,"kuaidinum":null,"kuaiditime":null,"received_time":null,"comment_time":null,"source":1,"tuihuo":2,"shouqian":1,"mobile":"13551862869","user_im":"user16","shop_im":"user67"}
     */

    private RefundinfoBean refundinfo;
    private GoodsinfoBean goodsinfo;
    private OrderinfoBean orderinfo;

    public RefundinfoBean getRefundinfo() {
        return refundinfo;
    }

    public void setRefundinfo(RefundinfoBean refundinfo) {
        this.refundinfo = refundinfo;
    }

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

    public static class RefundinfoBean {
        /**
         * fund_id : 31
         * order_id : 151
         * goods_id : 135
         * rec_id : 169
         * shop_jujue :
         * tuikuan_yuanyin : 123123
         * tuihuo_image :
         * tui_amount : 0.02
         * refund_type : 1
         * user_id : 16
         * seller_id : 67
         * created_at : 1524055371
         * updated_at : null
         * refund_status : 1
         * cldated_at : 0
         * kuaidi :
         * kuaidicode :
         * mj_fahuoshijian : 0
         * shop_shoukuai : 0
         * jujueshouhuo :
         */

        private int fund_id;
        private int order_id;
        private int goods_id;
        private int rec_id;
        private String shop_jujue;
        private String tuikuan_yuanyin;
        private String tuihuo_image;
        private String tui_amount;
        private int refund_type;
        private int user_id;
        private int seller_id;
        private int created_at;
        private Object updated_at;
        private int refund_status;
        private int cldated_at;
        private String kuaidi;
        private String kuaidicode;
        private int mj_fahuoshijian;
        private int shop_shoukuai;
        private String jujueshouhuo;
        private String daojishi;
        private String gcldated_at;

        public String getGcldated_at() {
            return gcldated_at;
        }

        public void setGcldated_at(String gcldated_at) {
            this.gcldated_at = gcldated_at;
        }

        public String getDaojishi() {
            return daojishi;
        }

        public void setDaojishi(String daojishi) {
            this.daojishi = daojishi;
        }

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

        public int getGoods_id() {
            return goods_id;
        }

        public void setGoods_id(int goods_id) {
            this.goods_id = goods_id;
        }

        public int getRec_id() {
            return rec_id;
        }

        public void setRec_id(int rec_id) {
            this.rec_id = rec_id;
        }

        public String getShop_jujue() {
            return shop_jujue;
        }

        public void setShop_jujue(String shop_jujue) {
            this.shop_jujue = shop_jujue;
        }

        public String getTuikuan_yuanyin() {
            return tuikuan_yuanyin;
        }

        public void setTuikuan_yuanyin(String tuikuan_yuanyin) {
            this.tuikuan_yuanyin = tuikuan_yuanyin;
        }

        public String getTuihuo_image() {
            return tuihuo_image;
        }

        public void setTuihuo_image(String tuihuo_image) {
            this.tuihuo_image = tuihuo_image;
        }

        public String getTui_amount() {
            return tui_amount;
        }

        public void setTui_amount(String tui_amount) {
            this.tui_amount = tui_amount;
        }

        public int getRefund_type() {
            return refund_type;
        }

        public void setRefund_type(int refund_type) {
            this.refund_type = refund_type;
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

        public int getRefund_status() {
            return refund_status;
        }

        public void setRefund_status(int refund_status) {
            this.refund_status = refund_status;
        }

        public int getCldated_at() {
            return cldated_at;
        }

        public void setCldated_at(int cldated_at) {
            this.cldated_at = cldated_at;
        }

        public String getKuaidi() {
            return kuaidi;
        }

        public void setKuaidi(String kuaidi) {
            this.kuaidi = kuaidi;
        }

        public String getKuaidicode() {
            return kuaidicode;
        }

        public void setKuaidicode(String kuaidicode) {
            this.kuaidicode = kuaidicode;
        }

        public int getMj_fahuoshijian() {
            return mj_fahuoshijian;
        }

        public void setMj_fahuoshijian(int mj_fahuoshijian) {
            this.mj_fahuoshijian = mj_fahuoshijian;
        }

        public int getShop_shoukuai() {
            return shop_shoukuai;
        }

        public void setShop_shoukuai(int shop_shoukuai) {
            this.shop_shoukuai = shop_shoukuai;
        }

        public String getJujueshouhuo() {
            return jujueshouhuo;
        }

        public void setJujueshouhuo(String jujueshouhuo) {
            this.jujueshouhuo = jujueshouhuo;
        }
    }

    public static class GoodsinfoBean {
        /**
         * rec_id : 169
         * order_id : 151
         * goods_id : 135
         * goods_name : 测试商品1
         * spec_id : 367
         * specification : 颜色:中国红 尺码:M
         * price : 0.02
         * quantity : 1
         * goods_image : http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg
         * evaluation : 10
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
         * order_id : 151
         * order_sn : shopdsj2018041809243894850
         * pid : shopdsj2018041809243894850
         * type : wedding
         * extension : null
         * seller_id : 67
         * seller_name : 博艺婚嫁自营店
         * buyer_id : 16
         * buyer_name : 杜卡基老师
         * buyer_email :
         * status : 60
         * published : 1524014678
         * payment_id : null
         * payment_name : 支付宝
         * payment_code : alipay
         * out_trade_no : 2018041821001004210576864154
         * pay_time : 1524014692
         * pay_message :
         * invoice_no : null
         * finished_time : 0
         * goods_amount : 0.21
         * discount : 0.00
         * order_amount : 0.21
         * anonymous : 0
         * postname : 大公鸡000
         * postaddress : 四川省成都市新都区哦陌生
         * postmobile : 46546478978
         * postaddressid : 99
         * kuaidicode : null
         * kuaidinum : null
         * kuaiditime : null
         * received_time : null
         * comment_time : null
         * source : 1
         * tuihuo : 2
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
        private String payment_name;
        private String payment_code;
        private String out_trade_no;
        private int pay_time;
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

        public String getPayment_name() {
            return payment_name;
        }

        public void setPayment_name(String payment_name) {
            this.payment_name = payment_name;
        }

        public String getPayment_code() {
            return payment_code;
        }

        public void setPayment_code(String payment_code) {
            this.payment_code = payment_code;
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

package com.linzi.xiguwen.bean;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.List;

/**
 * Created by pc on 2018/4/28.
 */

public class MallOrderDetailsBean {

    /**
     * data : {"order_id":29,"order_sn":"shopdsj2018042811073267728","pid":"shopasj2018042811073245728","type":"wedding","extension":null,"seller_id":67,"seller_name":"博艺婚嫁自营店","buyer_id":16,"buyer_name":"杜卡基老师","buyer_email":"","status":20,"published":"2018-04-28 11:07:32","payment_id":null,"payment_name":"微信","payment_code":"wxpay","out_trade_no":null,"pay_time":"1970-01-01 08:00:00","pay_message":"","invoice_no":null,"finished_time":0,"goods_amount":"0.09","discount":"0.00","order_amount":"0.09","anonymous":0,"postname":"567","postaddress":"四川省成都市双流县4564","postmobile":"5467","postaddressid":118,"kuaidicode":null,"kuaidinum":null,"kuaiditime":null,"received_time":"1970-01-01 08:00:00","comment_time":null,"source":1,"tuihuo":1,"shouqian":1,"shangpingjongjia":"0.06","dikouzongge":"0.03","voucher":"0.00","yingfuzonge":"0.06","yingfujine":"0.03","yifuzonge":"0.09","goods":[{"rec_id":42,"order_id":29,"goods_id":135,"goods_name":"测试商品1","spec_id":368,"specification":"颜色:大红 尺码:S","price":"0.02","quantity":1,"goods_image":"http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg","evaluation":0,"remark":"","credit_value":0,"is_valid":1,"is_approve":0,"status":20,"yuandanjia":"0.02","deductible":"0.01"},{"rec_id":43,"order_id":29,"goods_id":135,"goods_name":"测试商品1","spec_id":369,"specification":"颜色:大红 尺码:L","price":"0.02","quantity":1,"goods_image":"http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg","evaluation":0,"remark":"","credit_value":0,"is_valid":1,"is_approve":0,"status":20,"yuandanjia":"0.02","deductible":"0.01"},{"rec_id":41,"order_id":29,"goods_id":137,"goods_name":"测试商品3","spec_id":376,"specification":"颜色:黑色 尺码:37","price":"0.05","quantity":1,"goods_image":"http://www.boyihunjia.com/uploads/20180208/c215aca9e6805b29dfdbee7dd6c1c5d3.jpg","evaluation":0,"remark":"","credit_value":0,"is_valid":1,"is_approve":0,"status":20,"yuandanjia":"0.02","deductible":"0.01"}],"fukuantime":0,"user_id":16,"shop_id":67,"user_mobile":"18581882801","shop_mobile":"13551862869"}
     * youlike : [{"shopid":187,"userid":67,"username":"13551862869","shopname":"255d","spec_name_1":"123","spec_name_2":"1231","price":"10000.00","columnid":7,"columnname":"婚纱礼服","pcolumnid":4,"pcolumnname":"婚纱礼服","coupons_price":"200.00","weigh":1,"expressid":15,"expressname":"五件包邮","shopimg":["http://imgcache.boyihunjia.com/9b929201803221532314023.png"],"number":0,"status":1,"time":1524757575,"state":2,"statetime":0,"company":"1","statecontent":"审核通过","num":0,"clicked":0,"followed":0,"saled":0,"provinceid":24,"cityid":273,"countyid":2646,"province":"四川省","city":"成都市","county":"双流县"},{"shopid":163,"userid":1116,"username":"18200490521","shopname":"室内装饰风景画","spec_name_1":"尺寸","spec_name_2":"","price":"560.00","columnid":21,"columnname":"布艺类","pcolumnid":14,"pcolumnname":"结婚用品","coupons_price":"0.00","weigh":12,"expressid":16,"expressname":"包邮","shopimg":["http://imgcache.boyihunjia.com/c012f201804082329534407.jpg","http://imgcache.boyihunjia.com/c27cd201804082330074855.jpg","http://imgcache.boyihunjia.com/4767f201804082330217573.jpg","http://imgcache.boyihunjia.com/b0e97201804082330334246.jpg"],"number":0,"status":1,"time":1523201618,"state":2,"statetime":0,"company":"幅","statecontent":"审核通过","num":0,"clicked":0,"followed":4,"saled":0,"provinceid":24,"cityid":273,"countyid":2636,"province":"四川省","city":"成都市","county":"锦江区"},{"shopid":162,"userid":1116,"username":"18200490521","shopname":"婚房布置个性墙绘","spec_name_1":"平米","spec_name_2":"","price":"200.00","columnid":68,"columnname":"金银器装饰","pcolumnid":14,"pcolumnname":"结婚用品","coupons_price":"0.00","weigh":11,"expressid":16,"expressname":"包邮","shopimg":["http://imgcache.boyihunjia.com/67919201804082300449854.jpg","http://imgcache.boyihunjia.com/6a555201804082300535098.jpg","http://imgcache.boyihunjia.com/5ce58201804082301055009.jpg","http://imgcache.boyihunjia.com/7fc73201804082306457081.jpg","http://imgcache.boyihunjia.com/5587a201804082306569432.jpg","http://imgcache.boyihunjia.com/03c16201804082307058965.jpg"],"number":0,"status":1,"time":1523200338,"state":2,"statetime":0,"company":"1平米","statecontent":"审核通过","num":0,"clicked":0,"followed":2,"saled":0,"provinceid":24,"cityid":273,"countyid":2636,"province":"四川省","city":"成都市","county":"锦江区"},{"shopid":161,"userid":1116,"username":"18200490521","shopname":"婚礼惊喜感恩父母礼品","spec_name_1":"尺寸","spec_name_2":"","price":"1280.00","columnid":21,"columnname":"布艺类","pcolumnid":14,"pcolumnname":"结婚用品","coupons_price":"0.00","weigh":10,"expressid":16,"expressname":"包邮","shopimg":["http://imgcache.boyihunjia.com/70e7d201804082235547946.jpg","http://imgcache.boyihunjia.com/dd92c201804082236047884.jpg","http://imgcache.boyihunjia.com/0bd87201804082236189174.jpg"],"number":0,"status":1,"time":1523199205,"state":2,"statetime":0,"company":"幅","statecontent":"审核通过","num":0,"clicked":0,"followed":0,"saled":0,"provinceid":24,"cityid":273,"countyid":2636,"province":"四川省","city":"成都市","county":"锦江区"},{"shopid":159,"userid":1457,"username":"15708447139","shopname":"（测试）西式婚妙","spec_name_1":"白色","spec_name_2":"小","price":"10.00","columnid":7,"columnname":"婚纱礼服","pcolumnid":4,"pcolumnname":"婚纱礼服","coupons_price":"0.00","weigh":1,"expressid":26,"expressname":"卖家承担","shopimg":["http://imgcache.boyihunjia.com/53d50201803311530445910.jpg"],"number":0,"status":1,"time":1522481546,"state":2,"statetime":0,"company":"件","statecontent":"审核通过","num":0,"clicked":0,"followed":0,"saled":0,"provinceid":24,"cityid":273,"countyid":2637,"province":"四川省","city":"成都市","county":"青羊区"},{"shopid":158,"userid":1457,"username":"15708447139","shopname":"婚纱","spec_name_1":"白色","spec_name_2":"蓝色","price":"0.30","columnid":7,"columnname":"婚纱礼服","pcolumnid":4,"pcolumnname":"婚纱礼服","coupons_price":"0.00","weigh":1,"expressid":26,"expressname":"卖家承担","shopimg":["http://imgcache.boyihunjia.com/3b639201803261650365295.png"],"number":0,"status":1,"time":1522632896,"state":2,"statetime":0,"company":"件","statecontent":"审核通过","num":0,"clicked":0,"followed":0,"saled":0,"provinceid":24,"cityid":273,"countyid":2640,"province":"四川省","city":"成都市","county":"成华区"}]
     */

    private DataBean data;
    private List<YoulikeBean> youlike;

    public DataBean getData() {
        return data;
    }

    public void setData(DataBean data) {
        this.data = data;
    }

    public List<YoulikeBean> getYoulike() {
        return youlike;
    }

    public void setYoulike(List<YoulikeBean> youlike) {
        this.youlike = youlike;
    }

    public static class DataBean implements Parcelable {
        /**
         * order_id : 29
         * order_sn : shopdsj2018042811073267728
         * pid : shopasj2018042811073245728
         * type : wedding
         * extension : null
         * seller_id : 67
         * seller_name : 博艺婚嫁自营店
         * buyer_id : 16
         * buyer_name : 杜卡基老师
         * buyer_email :
         * status : 20
         * published : 2018-04-28 11:07:32
         * payment_id : null
         * payment_name : 微信
         * payment_code : wxpay
         * out_trade_no : null
         * pay_time : 1970-01-01 08:00:00
         * pay_message :
         * invoice_no : null
         * finished_time : 0
         * goods_amount : 0.09
         * discount : 0.00
         * order_amount : 0.09
         * anonymous : 0
         * postname : 567
         * postaddress : 四川省成都市双流县4564
         * postmobile : 5467
         * postaddressid : 118
         * kuaidicode : null
         * kuaidinum : null
         * kuaiditime : null
         * received_time : 1970-01-01 08:00:00
         * comment_time : null
         * source : 1
         * tuihuo : 1
         * shouqian : 1
         * shangpingjongjia : 0.06
         * dikouzongge : 0.03
         * voucher : 0.00
         * yingfuzonge : 0.06
         * yingfujine : 0.03
         * yifuzonge : 0.09
         * goods : [{"rec_id":42,"order_id":29,"goods_id":135,"goods_name":"测试商品1","spec_id":368,"specification":"颜色:大红 尺码:S","price":"0.02","quantity":1,"goods_image":"http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg","evaluation":0,"remark":"","credit_value":0,"is_valid":1,"is_approve":0,"status":20,"yuandanjia":"0.02","deductible":"0.01"},{"rec_id":43,"order_id":29,"goods_id":135,"goods_name":"测试商品1","spec_id":369,"specification":"颜色:大红 尺码:L","price":"0.02","quantity":1,"goods_image":"http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg","evaluation":0,"remark":"","credit_value":0,"is_valid":1,"is_approve":0,"status":20,"yuandanjia":"0.02","deductible":"0.01"},{"rec_id":41,"order_id":29,"goods_id":137,"goods_name":"测试商品3","spec_id":376,"specification":"颜色:黑色 尺码:37","price":"0.05","quantity":1,"goods_image":"http://www.boyihunjia.com/uploads/20180208/c215aca9e6805b29dfdbee7dd6c1c5d3.jpg","evaluation":0,"remark":"","credit_value":0,"is_valid":1,"is_approve":0,"status":20,"yuandanjia":"0.02","deductible":"0.01"}]
         * fukuantime : 0
         * user_id : 16
         * shop_id : 67
         * user_mobile : 18581882801
         * shop_mobile : 13551862869
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
        private String published;
        private Object payment_id;
        private String payment_name;
        private String payment_code;
        private Object out_trade_no;
        private String pay_time;
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
        private String received_time;
        private Object comment_time;
        private int source;
        private int tuihuo;
        private int shouqian;
        private String shangpingjongjia;
        private String dikouzongge;
        private String voucher;
        private String yingfuzonge;
        private String yingfujine;
        private String yifuzonge;
        private int fukuantime;
        private int user_id;
        private int shop_id;
        private String user_mobile;
        private String shop_mobile;
        private List<GoodsBean> goods;
        private String yuandanjia;
        private String shop_im;
        private String user_im;
        private int shifoutuikuan;
        private String fanjifen;

        public String getFanjifen() {
            return fanjifen;
        }

        public void setFanjifen(String fanjifen) {
            this.fanjifen = fanjifen;
        }

        public int getShifoutuikuan() {
            return shifoutuikuan;
        }

        public void setShifoutuikuan(int shifoutuikuan) {
            this.shifoutuikuan = shifoutuikuan;
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

        public String getYuandanjia() {
            return yuandanjia;
        }

        public void setYuandanjia(String yuandanjia) {
            this.yuandanjia = yuandanjia;
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

        public String getPublished() {
            return published;
        }

        public void setPublished(String published) {
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

        public Object getOut_trade_no() {
            return out_trade_no;
        }

        public void setOut_trade_no(Object out_trade_no) {
            this.out_trade_no = out_trade_no;
        }

        public String getPay_time() {
            return pay_time;
        }

        public void setPay_time(String pay_time) {
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

        public String getReceived_time() {
            return received_time;
        }

        public void setReceived_time(String received_time) {
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

        public String getShangpingjongjia() {
            return shangpingjongjia;
        }

        public void setShangpingjongjia(String shangpingjongjia) {
            this.shangpingjongjia = shangpingjongjia;
        }

        public String getDikouzongge() {
            return dikouzongge;
        }

        public void setDikouzongge(String dikouzongge) {
            this.dikouzongge = dikouzongge;
        }

        public String getVoucher() {
            return voucher;
        }

        public void setVoucher(String voucher) {
            this.voucher = voucher;
        }

        public String getYingfuzonge() {
            return yingfuzonge;
        }

        public void setYingfuzonge(String yingfuzonge) {
            this.yingfuzonge = yingfuzonge;
        }

        public String getYingfujine() {
            return yingfujine;
        }

        public void setYingfujine(String yingfujine) {
            this.yingfujine = yingfujine;
        }

        public String getYifuzonge() {
            return yifuzonge;
        }

        public void setYifuzonge(String yifuzonge) {
            this.yifuzonge = yifuzonge;
        }

        public int getFukuantime() {
            return fukuantime;
        }

        public void setFukuantime(int fukuantime) {
            this.fukuantime = fukuantime;
        }

        public int getUser_id() {
            return user_id;
        }

        public void setUser_id(int user_id) {
            this.user_id = user_id;
        }

        public int getShop_id() {
            return shop_id;
        }

        public void setShop_id(int shop_id) {
            this.shop_id = shop_id;
        }

        public String getUser_mobile() {
            return user_mobile;
        }

        public void setUser_mobile(String user_mobile) {
            this.user_mobile = user_mobile;
        }

        public String getShop_mobile() {
            return shop_mobile;
        }

        public void setShop_mobile(String shop_mobile) {
            this.shop_mobile = shop_mobile;
        }

        public List<GoodsBean> getGoods() {
            return goods;
        }

        public void setGoods(List<GoodsBean> goods) {
            this.goods = goods;
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeList(goods);
        }

        public static final Creator<DataBean> CREATOR = new Creator<DataBean>() {
            @Override
            public DataBean createFromParcel(Parcel source) {
                //从Parcel容器中读取传递数据值，封装成Parcelable对象返回逻辑层。
                DataBean weddingOrderDetailsBean = new DataBean();
                weddingOrderDetailsBean.setGoods(source.readArrayList(GoodsBean.class.getClassLoader()));
                return weddingOrderDetailsBean;
            }

            @Override
            public DataBean[] newArray(int size) {
                //创建一个类型为T，长度为size的数组，仅一句话（return new T[size])即可。方法是供外部类反序列化本类数组使用。
                return new DataBean[size];
            }
        };

        public static class GoodsBean implements Parcelable {
            /**
             * rec_id : 42
             * order_id : 29
             * goods_id : 135
             * goods_name : 测试商品1
             * spec_id : 368
             * specification : 颜色:大红 尺码:S
             * price : 0.02
             * quantity : 1
             * goods_image : http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg
             * evaluation : 0
             * remark :
             * credit_value : 0
             * is_valid : 1
             * is_approve : 0
             * status : 20
             * yuandanjia : 0.02
             * deductible : 0.01
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
            private int status;
            private String yuandanjia;
            private String deductible;

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

            public int getStatus() {
                return status;
            }

            public void setStatus(int status) {
                this.status = status;
            }

            public String getYuandanjia() {
                return yuandanjia;
            }

            public void setYuandanjia(String yuandanjia) {
                this.yuandanjia = yuandanjia;
            }

            public String getDeductible() {
                return deductible;
            }

            public void setDeductible(String deductible) {
                this.deductible = deductible;
            }

            @Override
            public int describeContents() {
                return 0;
            }

            @Override
            public void writeToParcel(Parcel parcel, int i) {
                parcel.writeInt(rec_id);
                parcel.writeString(goods_name);//商品名
                parcel.writeString(price);//单价
                parcel.writeString(goods_image);//商品图片
                parcel.writeString(specification);//档期
                //parcel.writeString(yuandingjin);//定金
                parcel.writeString(deductible);//抵扣
                // parcel.writeInt(paytype);//支付类型
                parcel.writeInt(quantity);//数量
                parcel.writeInt(order_id);//订单id
                //parcel.writeInt(zquantity);//小计数量
                //parcel.writeString(zongjine);//小计金额
                //parcel.writeString(zongdingjin);//小计定金
                // parcel.writeString(zongdikou);//小计抵扣
                //parcel.writeString(shifukuan);//实付款
            }

            public static final Creator<GoodsBean> CREATOR = new Creator<GoodsBean>() {
                @Override
                public GoodsBean createFromParcel(Parcel source) {
                    //从Parcel容器中读取传递数据值，封装成Parcelable对象返回逻辑层。
                    GoodsBean weddingOrderDetailsBean = new GoodsBean();
                    weddingOrderDetailsBean.setRec_id(source.readInt());
                    weddingOrderDetailsBean.setGoods_name(source.readString());
                    weddingOrderDetailsBean.setPrice(source.readString());
                    weddingOrderDetailsBean.setGoods_image(source.readString());
                    weddingOrderDetailsBean.setSpecification(source.readString());
                    //  weddingOrderDetailsBean.setYuandingjin(source.readString());
                    weddingOrderDetailsBean.setDeductible(source.readString());
                    // weddingOrderDetailsBean.setPaytype(source.readInt());
                    weddingOrderDetailsBean.setQuantity(source.readInt());
                    weddingOrderDetailsBean.setOrder_id(source.readInt());
                    // weddingOrderDetailsBean.setZquantity(source.readInt());
                    // weddingOrderDetailsBean.setZongjine(source.readString());
                    // weddingOrderDetailsBean.setZongdingjin(source.readString());
                    // weddingOrderDetailsBean.setZongdikou(source.readString());
                    // weddingOrderDetailsBean.setShifukuan(source.readString());
                    return weddingOrderDetailsBean;
                }

                @Override
                public GoodsBean[] newArray(int size) {
                    //创建一个类型为T，长度为size的数组，仅一句话（return new T[size])即可。方法是供外部类反序列化本类数组使用。
                    return new GoodsBean[size];
                }
            };
        }
    }

    public static class YoulikeBean {
        /**
         * shopid : 187
         * userid : 67
         * username : 13551862869
         * shopname : 255d
         * spec_name_1 : 123
         * spec_name_2 : 1231
         * price : 10000.00
         * columnid : 7
         * columnname : 婚纱礼服
         * pcolumnid : 4
         * pcolumnname : 婚纱礼服
         * coupons_price : 200.00
         * weigh : 1
         * expressid : 15
         * expressname : 五件包邮
         * shopimg : ["http://imgcache.boyihunjia.com/9b929201803221532314023.png"]
         * number : 0
         * status : 1
         * time : 1524757575
         * state : 2
         * statetime : 0
         * company : 1
         * statecontent : 审核通过
         * num : 0
         * clicked : 0
         * followed : 0
         * saled : 0
         * provinceid : 24
         * cityid : 273
         * countyid : 2646
         * province : 四川省
         * city : 成都市
         * county : 双流县
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
        private int goods_id;

        public int getGoods_id() {
            return goods_id;
        }

        public void setGoods_id(int goods_id) {
            this.goods_id = goods_id;
        }

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

package com.linzi.xiguwen.bean;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.List;

/**
 * Created by pc on 2018/4/16.
 */

public class WeddingOrderListBean {

    private List<DataBean> data;

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class DataBean implements Parcelable {

        private int order_id;
        private String order_sn;
        private String pid;
        private int seller_id;
        private String seller_name;
        private int baojia_id;
        private String baojia_image;
        private String baojia_name;
        private String baojia_price;
        private String baojia_date;
        private String specification;
        private int quantity;
        private int status;
        private int paytype;
        private String goods_amount;
        private String discount;
        private String order_amount;
        private int tuihuo;
        private SellerInfoBean seller_info;
        private int jiedantime;
        private int fukuantime;
        private String yuandingjin;
        private String deductible;
        private String price;
        private int zquantity;
        private String zongdingjin;
        private String zongdikou;
        private String zongjine;
        private String shifukuan;
        private String order_lastamount;
        private String payjine;
        private String amount_balance;
        private int payment_dis;

        public int getPayment_dis() {
            return payment_dis;
        }

        public void setPayment_dis(int payment_dis) {
            this.payment_dis = payment_dis;
        }

        public String getAmount_balance() {
            return amount_balance;
        }

        public void setAmount_balance(String amount_balance) {
            this.amount_balance = amount_balance;
        }

        public String getPayjine() {
            return payjine;
        }

        public void setPayjine(String payjine) {
            this.payjine = payjine;
        }

        public String getOrder_lastamount() {
            return order_lastamount;
        }

        public void setOrder_lastamount(String order_lastamount) {
            this.order_lastamount = order_lastamount;
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

        public int getTuihuo() {
            return tuihuo;
        }

        public void setTuihuo(int tuihuo) {
            this.tuihuo = tuihuo;
        }

        public SellerInfoBean getSeller_info() {
            return seller_info;
        }

        public void setSeller_info(SellerInfoBean seller_info) {
            this.seller_info = seller_info;
        }

        public int getJiedantime() {
            return jiedantime;
        }

        public void setJiedantime(int jiedantime) {
            this.jiedantime = jiedantime;
        }

        public int getFukuantime() {
            return fukuantime;
        }

        public void setFukuantime(int fukuantime) {
            this.fukuantime = fukuantime;
        }

        public String getYuandingjin() {
            return yuandingjin;
        }

        public void setYuandingjin(String yuandingjin) {
            this.yuandingjin = yuandingjin;
        }

        public String getDeductible() {
            return deductible;
        }

        public void setDeductible(String deductible) {
            this.deductible = deductible;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public int getZquantity() {
            return zquantity;
        }

        public void setZquantity(int zquantity) {
            this.zquantity = zquantity;
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

        public String getZongjine() {
            return zongjine;
        }

        public void setZongjine(String zongjine) {
            this.zongjine = zongjine;
        }

        public String getShifukuan() {
            return shifukuan;
        }

        public void setShifukuan(String shifukuan) {
            this.shifukuan = shifukuan;
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeString(baojia_name);//商品名
            parcel.writeString(price);//单价
            parcel.writeString(baojia_image);//商品图片
            parcel.writeString(specification);//档期
            parcel.writeString(yuandingjin);//定金
            parcel.writeString(deductible);//抵扣
            parcel.writeInt(paytype);//支付类型
            parcel.writeInt(quantity);//数量
            parcel.writeInt(order_id);//订单id
            parcel.writeInt(zquantity);//小计数量
            parcel.writeString(zongjine);//小计金额
            parcel.writeString(zongdingjin);//小计定金
            parcel.writeString(zongdikou);//小计抵扣
            parcel.writeString(shifukuan);//实付款
        }

        public static final Creator<DataBean> CREATOR = new Creator<DataBean>() {
            @Override
            public DataBean createFromParcel(Parcel source) {
                //从Parcel容器中读取传递数据值，封装成Parcelable对象返回逻辑层。
                DataBean weddingOrderDetailsBean = new DataBean();
                weddingOrderDetailsBean.setBaojia_name(source.readString());
                weddingOrderDetailsBean.setPrice(source.readString());
                weddingOrderDetailsBean.setBaojia_image(source.readString());
                weddingOrderDetailsBean.setSpecification(source.readString());
                weddingOrderDetailsBean.setYuandingjin(source.readString());
                weddingOrderDetailsBean.setDeductible(source.readString());
                weddingOrderDetailsBean.setPaytype(source.readInt());
                weddingOrderDetailsBean.setQuantity(source.readInt());
                weddingOrderDetailsBean.setOrder_id(source.readInt());
                weddingOrderDetailsBean.setZquantity(source.readInt());
                weddingOrderDetailsBean.setZongjine(source.readString());
                weddingOrderDetailsBean.setZongdingjin(source.readString());
                weddingOrderDetailsBean.setZongdikou(source.readString());
                weddingOrderDetailsBean.setShifukuan(source.readString());
                return weddingOrderDetailsBean;
            }

            @Override
            public DataBean[] newArray(int size) {
                //创建一个类型为T，长度为size的数组，仅一句话（return new T[size])即可。方法是供外部类反序列化本类数组使用。
                return new DataBean[size];
            }
        };

        public static class SellerInfoBean {
            private int userid;
            private String nickname;


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
        }
    }
}

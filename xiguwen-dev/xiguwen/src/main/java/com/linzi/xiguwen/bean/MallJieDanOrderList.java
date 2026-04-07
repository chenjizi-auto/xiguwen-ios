package com.linzi.xiguwen.bean;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.List;

/**
 * Created by pc on 2018/4/18.
 */

public class MallJieDanOrderList {

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
        private int status;
        private int published;
        private int finished_time;
        private String goods_amount;
        private String discount;
        private String order_amount;
        private int anonymous;
        private String postname;
        private String postaddress;
        private String postmobile;
        private int postaddressid;
        private int source;
        private int tuihuo;
        private int shouqian;
        private SellerInfoBean seller_info;
        private int zquantity;
        private String zongjine;
        private String zongdikou;
        private String shifukuan;
        private List<GoodsBean> goods;

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

        public SellerInfoBean getSeller_info() {
            return seller_info;
        }

        public void setSeller_info(SellerInfoBean seller_info) {
            this.seller_info = seller_info;
        }

        public int getZquantity() {
            return zquantity;
        }

        public void setZquantity(int zquantity) {
            this.zquantity = zquantity;
        }

        public String getZongjine() {
            return zongjine;
        }

        public void setZongjine(String zongjine) {
            this.zongjine = zongjine;
        }

        public String getZongdikou() {
            return zongdikou;
        }

        public void setZongdikou(String zongdikou) {
            this.zongdikou = zongdikou;
        }

        public String getShifukuan() {
            return shifukuan;
        }

        public void setShifukuan(String shifukuan) {
            this.shifukuan = shifukuan;
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

        public static class GoodsBean implements Parcelable {

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
                parcel.writeString(goods_name);//商品名
                parcel.writeString(yuandanjia);//单价
                parcel.writeString(goods_image);//商品图片
                parcel.writeString(specification);//档期
                parcel.writeString(deductible);//抵扣
                parcel.writeInt(quantity);//数量
                parcel.writeInt(order_id);//订单id
//                parcel.writeInt(zquantity);//小计数量
//                parcel.writeString(zongjine);//小计金额
//                parcel.writeString(zongdingjin);//小计定金
//                parcel.writeString(zongdikou);//小计抵扣
//                parcel.writeString(shifukuan);//实付款
            }

            public static final Creator<GoodsBean> CREATOR = new Creator<GoodsBean>() {
                @Override
                public GoodsBean createFromParcel(Parcel source) {
                    //从Parcel容器中读取传递数据值，封装成Parcelable对象返回逻辑层。
                    GoodsBean weddingOrderDetailsBean = new GoodsBean();
                    weddingOrderDetailsBean.setGoods_name(source.readString());
                    weddingOrderDetailsBean.setYuandanjia(source.readString());
                    weddingOrderDetailsBean.setGoods_image(source.readString());
                    weddingOrderDetailsBean.setSpecification(source.readString());
                    weddingOrderDetailsBean.setDeductible(source.readString());
                    weddingOrderDetailsBean.setQuantity(source.readInt());
                    weddingOrderDetailsBean.setOrder_id(source.readInt());
//                    weddingOrderDetailsBean.setZquantity(source.readInt());
//                    weddingOrderDetailsBean.setZongjine(source.readString());
//                    weddingOrderDetailsBean.setZongdingjin(source.readString());
//                    weddingOrderDetailsBean.setZongdikou(source.readString());
//                    weddingOrderDetailsBean.setShifukuan(source.readString());
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
}

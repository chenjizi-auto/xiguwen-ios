package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/4/17.
 */

public class MallOrderListBean {

    private List<DataBean> data;

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class DataBean {

        private int order_id;
        private String order_sn;
        private String pid;
        private int seller_id;
        private String seller_name;
        private int status;
        private String goods_amount;
        private String discount;
        private String order_amount;
        private SellerInfoBean seller_info;
        private String zquantity;
        private String zongjine;
        private String zongdikou;
        private String shifukuan;
        private int zonji;
        private String xiaoji;
        private int jiedantime;
        private int fukuantime;
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

        public SellerInfoBean getSeller_info() {
            return seller_info;
        }

        public void setSeller_info(SellerInfoBean seller_info) {
            this.seller_info = seller_info;
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

        public int getZonji() {
            return zonji;
        }

        public void setZonji(int zonji) {
            this.zonji = zonji;
        }

        public String getXiaoji() {
            return xiaoji;
        }

        public void setXiaoji(String xiaoji) {
            this.xiaoji = xiaoji;
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

        public List<GoodsBean> getGoods() {
            return goods;
        }

        public void setGoods(List<GoodsBean> goods) {
            this.goods = goods;
        }

        public static class SellerInfoBean {

            private String nickname;

            public String getNickname() {
                return nickname;
            }

            public void setNickname(String nickname) {
                this.nickname = nickname;
            }

        }

        public static class GoodsBean {

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
        }
    }
}

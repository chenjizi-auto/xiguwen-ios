package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by jiang on 2018/3/6.
 */

public class HunQinMenuBean {

    /**
     * code : 0
     * data : [{"occupationid":1,"proname":"策划师","wapimg":"http://boyiapi.xxwlb.com/Index/admin/image/180125/eoFX0718546001516869636.jpeg"},{"occupationid":24,"proname":"花艺师","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":18,"proname":"化妆师","wapimg":"http://boyiapi.xxwlb.comwapimg"},{"occupationid":29,"proname":"歌手","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":38,"proname":"督导师","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":2,"proname":"主持人","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":5,"proname":"摄像师","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":28,"proname":"婚纱礼服","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":35,"proname":"音响师","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":30,"proname":"乐器","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":27,"proname":"设计师","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":4,"proname":"摄影师","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":37,"proname":"大屏","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":36,"proname":"喜娘","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":23,"proname":"婚车租赁","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":34,"proname":"演员","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":33,"proname":"魔术","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":32,"proname":"杂技","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":31,"proname":"舞蹈","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":25,"proname":"灯光师","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":26,"proname":"场布","wapimg":"http://boyiapi.xxwlb.com"},{"occupationid":22,"proname":"珠宝首饰","wapimg":"http://boyiapi.xxwlb.com"}]
     * num : 1
     */

    private int code;
    private int num;
    private List<DataBean> data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class DataBean {
        /**
         * occupationid : 1
         * proname : 策划师
         * wapimg : http://boyiapi.xxwlb.com/Index/admin/image/180125/eoFX0718546001516869636.jpeg
         */

        private int occupationid;
        private String proname;
        private String wapimg;

        public int getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(int occupationid) {
            this.occupationid = occupationid;
        }

        public String getProname() {
            return proname;
        }

        public void setProname(String proname) {
            this.proname = proname;
        }

        public String getWapimg() {
            return wapimg;
        }

        public void setWapimg(String wapimg) {
            this.wapimg = wapimg;
        }
    }
}

package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/3/21.
 */

public class ProfessionalBean {

    /**
     * code : 0
     * data : [{"occupationid":21,"proname":"婚宴酒店","wapimg":"http://imgcache.boyihunjia.com/97cd6201803191557504246.png"},{"occupationid":2,"proname":"主持人","wapimg":"http://imgcache.boyihunjia.com/17d4a201803191557574253.png"},{"occupationid":28,"proname":"婚纱摄影","wapimg":"http://imgcache.boyihunjia.com/397fe201803191558205178.png"},{"occupationid":26,"proname":"婚庆公司","wapimg":"http://imgcache.boyihunjia.com/af38e201803191558342148.png"},{"occupationid":1,"proname":"策划师","wapimg":"http://imgcache.boyihunjia.com/35f1f201803191558108240.png"},{"occupationid":18,"proname":"化妆师","wapimg":"http://imgcache.boyihunjia.com/0f0c2201803191558443291.png"},{"occupationid":5,"proname":"摄像师","wapimg":"http://imgcache.boyihunjia.com/c5c97201803191558542851.png"},{"occupationid":4,"proname":"摄影师","wapimg":"http://imgcache.boyihunjia.com/02d8b201803191559138504.png"},{"occupationid":38,"proname":"管家督导","wapimg":"http://imgcache.boyihunjia.com/bc233201803191600526996.png"},{"occupationid":23,"proname":"婚车租赁","wapimg":"http://imgcache.boyihunjia.com/32667201803191600304675.png"},{"occupationid":36,"proname":"婚礼场布","wapimg":"http://imgcache.boyihunjia.com/36b22201803191600372711.png"},{"occupationid":27,"proname":"设计师","wapimg":"http://imgcache.boyihunjia.com/5276c201803191600593575.png"},{"occupationid":24,"proname":"花艺师","wapimg":"http://imgcache.boyihunjia.com/2b01f201803191601081946.png"},{"occupationid":45,"proname":"婚礼道具商家","wapimg":"http://imgcache.boyihunjia.com/b2dea201803191601395129.png"},{"occupationid":44,"proname":"广告制作","wapimg":"http://imgcache.boyihunjia.com/4fd62201803191601265431.png"},{"occupationid":25,"proname":"灯光舞美设备音响","wapimg":"http://imgcache.boyihunjia.com/95e26201803191626036896.png"},{"occupationid":29,"proname":"演艺人员","wapimg":"http://imgcache.boyihunjia.com/96b0e201803191614386858.png"},{"occupationid":47,"proname":"文化演艺公司","wapimg":"http://imgcache.boyihunjia.com/ee6aa20180319161428595.png"},{"occupationid":48,"proname":"喜娘","wapimg":"http://www.boyihunjia.com"},{"occupationid":30,"proname":"礼仪模特","wapimg":"http://imgcache.boyihunjia.com/af9f2201803191614083489.png"},{"occupationid":46,"proname":"培训机构","wapimg":"http://imgcache.boyihunjia.com/be90e201803191614019850.png"},{"occupationid":42,"proname":"兼职","wapimg":"http://imgcache.boyihunjia.com/b7931201803191613275470.png"},{"occupationid":43,"proname":"其它","wapimg":"http://imgcache.boyihunjia.com/8ee88201803191613212808.png"}]
     * num : 23
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
         * occupationid : 21
         * proname : 婚宴酒店
         * wapimg : http://imgcache.boyihunjia.com/97cd6201803191557504246.png
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

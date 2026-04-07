package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/4/23.
 */

public class ChaKanWuLiuBean {


    /**
     * LogisticCode : 888824092789139833
     * ShipperCode : YTO
     * Traces : [{"AcceptStation":"【四川省自贡市公司】 取件人: 刘孟军 已收件","AcceptTime":"2018-03-26 13:39:57"},{"AcceptStation":"【四川省自贡市公司】 已收件","AcceptTime":"2018-03-26 13:39:57"},{"AcceptStation":"【自贡转运中心】 已打包","AcceptTime":"2018-03-26 19:48:46"},{"AcceptStation":"【自贡转运中心】 已发出 下一站 【成都转运中心】","AcceptTime":"2018-03-26 22:28:51"},{"AcceptStation":"【成都转运中心】 已收入","AcceptTime":"2018-03-27 01:50:47"},{"AcceptStation":"【成都转运中心】 已发出 下一站 【哈尔滨转运中心】","AcceptTime":"2018-03-27 01:53:44"},{"AcceptStation":"【哈尔滨转运中心】 已收入","AcceptTime":"2018-03-29 08:45:16"},{"AcceptStation":"【哈尔滨转运中心】 已发出 下一站 【黑龙江省大庆市公司】","AcceptTime":"2018-03-29 08:56:00"},{"AcceptStation":"【黑龙江省大庆市公司】 已发出 下一站 【黑龙江省大庆市红岗区五厂分部公司】","AcceptTime":"2018-03-30 07:18:16"},{"AcceptStation":"【黑龙江省大庆市红岗区公司】 派件人: 王金锁 派件中 派件员电话","AcceptTime":"2018-03-30 12:44:44"},{"AcceptStation":"客户 签收人: 单 已签收 感谢使用圆通速递，期待再次为您服务","AcceptTime":"2018-03-30 19:06:10"}]
     * State : 3
     * EBusinessID : 1321856
     * Success : true
     * imgurl : http://www.boyihunjia.com/uploads/20180208/c215aca9e6805b29dfdbee7dd6c1c5d3.jpg
     */

    private String State;
    private String imgurl;
    private List<TracesBean> Traces;
    private String kuaidiname;
    private String LogisticCode;

    public String getLogisticCode() {
        return LogisticCode;
    }

    public void setLogisticCode(String logisticCode) {
        LogisticCode = logisticCode;
    }

    public String getKuaidiname() {
        return kuaidiname;
    }

    public void setKuaidiname(String kuaidiname) {
        this.kuaidiname = kuaidiname;
    }

    public String getState() {
        return State;
    }

    public void setState(String State) {
        this.State = State;
    }

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }

    public List<TracesBean> getTraces() {
        return Traces;
    }

    public void setTraces(List<TracesBean> Traces) {
        this.Traces = Traces;
    }

    public static class TracesBean {
        /**
         * AcceptStation : 【四川省自贡市公司】 取件人: 刘孟军 已收件
         * AcceptTime : 2018-03-26 13:39:57
         */

        private String AcceptStation;
        private String AcceptTime;

        public String getAcceptStation() {
            return AcceptStation;
        }

        public void setAcceptStation(String AcceptStation) {
            this.AcceptStation = AcceptStation;
        }

        public String getAcceptTime() {
            return AcceptTime;
        }

        public void setAcceptTime(String AcceptTime) {
            this.AcceptTime = AcceptTime;
        }
    }
}

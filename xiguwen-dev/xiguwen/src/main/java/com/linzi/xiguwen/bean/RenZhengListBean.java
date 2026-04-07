package com.linzi.xiguwen.bean;

import com.linzi.xiguwen.network.Constans;

import java.util.List;

/**
 * Created by PC on 2018-03-24.
 */

public class RenZhengListBean {
    /**
     * {
     　　"code":0,
     　　"data":{
     　　　　"chengxin":[
     　　　　　　{
     　　　　　　　　"id":3,
     　　　　　　　　"parameter1":"诚信认证1",
     　　　　　　　　"parameter2":"600.00",
     　　　　　　　　"state":0,
     　　　　　　　　"userid":"16"
     　　　　　　},
     　　　　　　Object{...},
     　　　　　　Object{...}
     　　　　],
     　　　　"pingtai":Array[1],
     　　　　"xueyuan":Array[7]
     　　},
     　　"message":"ok"
     }
     */

    private RenZhengBean chengxin; //诚信认证
    private RenZhengBean pingtai;  //平台认证
    private List<RenZhengBean> xueyuan; // 学院认证


    public RenZhengBean getChengxin() {
        return chengxin;
    }

    public void setChengxin(RenZhengBean chengxin) {
        this.chengxin = chengxin;
    }

    public RenZhengBean getPingtai() {
        return pingtai;
    }

    public void setPingtai(RenZhengBean pingtai) {
        this.pingtai = pingtai;
    }

    public List<RenZhengBean> getXueyuan() {
        return xueyuan;
    }

    public void setXueyuan(List<RenZhengBean> xueyuan) {
        this.xueyuan = xueyuan;
    }

    public static class RenZhengBean{
        //平台、诚信认证：0没有认证，2审核中，4认证通过，5退款
        public static final int STATE_NO = 0;    //  没有认证
        public static final int STATE_ON = 2;   // 审核中
        public static final int STATE_FINISH = 4;   // 认证通过
        public static final int STATE_REFUND = 5;   // 退款

        //学院认证：0没有认证，1通过，2没有通过，3审核中，4待提交资料
        public static final int STATE_XY_NO = 0;        // 未认证
        public static final int STATE_XY_PASS = 1;      // 已通过
        public static final int STATE_XY_UNPASS = 2;    // 未通过
        public static final int STATE_XY_ON = 3;        // 审核中
        public static final int STATE_XY_NOTSUBMIT = 4; // 待提交资料

        private int id;
        private String parameter1;      // 认证名称
        private String parameter2;      //认证金额
        private String parameter3;      //认证地图
        private int state;      //0没有认证，2审核中，4认证通过，5退款
        private String userid;
        private List<ChengXin> jine; // 诚信才有的条目

        private String star;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getParameter1() {
            return parameter1;
        }

        public void setParameter1(String parameter1) {
            this.parameter1 = parameter1;
        }

        public String getParameter2() {
            return parameter2;
        }

        public void setParameter2(String parameter2) {
            this.parameter2 = parameter2;
        }

        public String getParameter3() {
            return parameter3;
        }

        public void setParameter3(String parameter3) {
            this.parameter3 = parameter3;
        }

        public int getState() {
            return state;
        }

        public void setState(int state) {
            this.state = state;
        }

        public String getUserid() {
            return userid;
        }

        public void setUserid(String userid) {
            this.userid = userid;
        }

        public List<ChengXin> getJine() {
            return jine;
        }

        public void setJine(List<ChengXin> jine) {
            this.jine = jine;
        }

        public String getStar() {
            return star;
        }

        public void setStar(String star) {
            this.star = star;
        }


    }


    public static class ChengXin{
        private int id;
        private String parameter1;      // 认证名称
        private String parameter2;      //认证金额

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getParameter1() {
            return parameter1;
        }

        public void setParameter1(String parameter1) {
            this.parameter1 = parameter1;
        }

        public String getParameter2() {
            return parameter2;
        }

        public String getPrice(){
            return Constans.RMB + " " + getParameter2();
        }

        public void setParameter2(String parameter2) {
            this.parameter2 = parameter2;
        }
    }
}

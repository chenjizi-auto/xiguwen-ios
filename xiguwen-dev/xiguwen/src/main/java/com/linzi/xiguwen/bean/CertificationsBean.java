package com.linzi.xiguwen.bean;

/**
 * Created by PC on 2018-04-12.
 * 认证状态实体
 */

public class CertificationsBean {
    /**
     * {
     * "content": "审核通过",
     * "id": 28,
     * "identitya": "http://boyiapi.xxwlb.com/uploads/20180125/f49fdd3a7c191e184fc999890e7b6b8c.png",
     * "identityb": "http://boyiapi.xxwlb.com/uploads/20180125/d3cfa07659e3ba644d4d141f1c5007c4.png",
     * "identitynum": "5802656",
     * "imga": "测试内容26f3",
     * "name": "杜卡基老师",
     * "state": 1,
     * "userid": 16
     * }
     */

    public static final int STATE_ON = 0;       //审核中
    public static final int STATE_PASS = 1;     //审核通过
    public static final int STATE_UNPASS = 2;   //审核未通过
    public static final int STATE_NOPE = 3;   //未认证


    private String content;         //	审核内容
    private String identitya;       //  身份证A面
    private String identityb;       //身份证B面
    private String shou_chi_SFZ; //手持身份证
    private String identitynum;     // 身份证号码
    private String imga;            //身份证号码
    private String name;            //姓名
    private int state;              //	状态0审核中 1审核通过 2审核未通过
    // private long userid;


    public String getShou_chi_SFZ() {
        return shou_chi_SFZ;
    }

    public void setShou_chi_SFZ(String shou_chi_SFZ) {
        this.shou_chi_SFZ = shou_chi_SFZ;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getIdentitya() {
        return identitya;
    }

    public void setIdentitya(String identitya) {
        this.identitya = identitya;
    }

    public String getIdentityb() {
        return identityb;
    }

    public void setIdentityb(String identityb) {
        this.identityb = identityb;
    }

    public String getIdentitynum() {
        return identitynum == null ? "" : identitynum;
    }

    public void setIdentitynum(String identitynum) {
        this.identitynum = identitynum;
    }

    public String getImga() {
        return imga;
    }

    public void setImga(String imga) {
        this.imga = imga;
    }

    public String getName() {
        return name == null ? "" : name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

//    public long getUserid() {
//        return userid;
//    }
//
//    public void setUserid(long userid) {
//        this.userid = userid;
//    }
}

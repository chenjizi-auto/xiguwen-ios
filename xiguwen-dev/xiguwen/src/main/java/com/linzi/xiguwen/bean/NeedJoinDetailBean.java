package com.linzi.xiguwen.bean;

/**
 * Created by PC on 2018-04-12.
 * 需求参与者详情
 */

public class NeedJoinDetailBean {
    /**
     * {
     "cid": 2,
     "college": 0,
     "create_ti": "2018-01-27 14:26:29",
     "demandid": 15,
     "follow": 0,
     "goodscore": 100,
     "head": "http://boyiapi.xxwlb.com/uploads/20180126/2d666f73e9f22791b203d7e275a71c23.jpg",
     "jdshuoming": "我我的撒旦飞洒的",
     "minimumprice": 0,
     "mobile": "13551862863",
     "nickname": "13551862863",
     "num": 0,
     "occupationid": "测试内容c527",
     "platform": 1,
     "pv": 0,
     "selected_time": "测试内容5524",
     "sincerity": 0,
     "status_j": 48686,
     "team2": 0,
     "userid": 67
     }
     */
    private long cid;                   //参与id
    private int college;                //是否学院认证1是 0不是
    private String create_ti;           //发布时间
    private int demandid;               //需求id
    private int follow;                 //1是 0 否 当前用户是否关注了商家
    private int goodscore;              //好评率百分比   0-100
    private String head;                //头像
    private String jdshuoming;          //接单说明
    private float minimumprice;         //商家最低起价
    private String mobile;              //商家手机号
    private String nickname;            //商家昵称
    private int num;                    //	成交数量
    private String occupationid;        //职业类型
    private int platform;               //是否平台认证1是 0不是
    private int pv;                     //浏览量
    private String selected_time;       //选中时间
    private int sincerity;              //是否诚信认证1是 0不是
    private int status_j;               //	是否被选中 1选中 2未选中 3进行中
    private int team2;                  //	是否团队认证1是 0不是
    private long userid;                //	商家id

    public long getCid() {
        return cid;
    }

    public void setCid(long cid) {
        this.cid = cid;
    }

    public int getCollege() {
        return college;
    }

    public void setCollege(int college) {
        this.college = college;
    }

    public String getCreate_ti() {
        return create_ti;
    }

    public void setCreate_ti(String create_ti) {
        this.create_ti = create_ti;
    }

    public int getDemandid() {
        return demandid;
    }

    public void setDemandid(int demandid) {
        this.demandid = demandid;
    }

    public int getFollow() {
        return follow;
    }

    public void setFollow(int follow) {
        this.follow = follow;
    }

    public int getGoodscore() {
        return goodscore;
    }

    public void setGoodscore(int goodscore) {
        this.goodscore = goodscore;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public String getJdshuoming() {
        return jdshuoming;
    }

    public void setJdshuoming(String jdshuoming) {
        this.jdshuoming = jdshuoming;
    }

    public float getMinimumprice() {
        return minimumprice;
    }

    public void setMinimumprice(float minimumprice) {
        this.minimumprice = minimumprice;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getOccupationid() {
        return occupationid;
    }

    public void setOccupationid(String occupationid) {
        this.occupationid = occupationid;
    }

    public int getPlatform() {
        return platform;
    }

    public void setPlatform(int platform) {
        this.platform = platform;
    }

    public int getPv() {
        return pv;
    }

    public void setPv(int pv) {
        this.pv = pv;
    }

    public String getSelected_time() {
        return selected_time;
    }

    public void setSelected_time(String selected_time) {
        this.selected_time = selected_time;
    }

    public int getSincerity() {
        return sincerity;
    }

    public void setSincerity(int sincerity) {
        this.sincerity = sincerity;
    }

    public int getStatus_j() {
        return status_j;
    }

    public void setStatus_j(int status_j) {
        this.status_j = status_j;
    }

    public int getTeam2() {
        return team2;
    }

    public void setTeam2(int team2) {
        this.team2 = team2;
    }

    public long getUserid() {
        return userid;
    }

    public void setUserid(long userid) {
        this.userid = userid;
    }


    ///////////////////////////////////////////////////////

    /**
     * 是否学院认证
     * @return
     */
    public boolean isCollege(){
        return getCollege() == 1;
    }

    /**
     * 是否关注了商家
     * @return
     */
    public boolean isFollow(){
        return getFollow() == 1;
    }

    /**
     * 是否是平台认证
     * @return
     */
    public boolean isPlatform(){
        return getPlatform() == 1;
    }

    /**
     * 是否诚信认证
     * @return
     */
    public boolean isSincerity(){
        return getSincerity() == 1;
    }

    /**
     * 是否被选中
     * @return
     */
    public boolean isChoose(){
        return getStatus_j() == 1;
    }

    /**
     * 是否团队认证
     * @return
     */
    public boolean isTeam(){
        return getTeam2() == 1;
    }
}

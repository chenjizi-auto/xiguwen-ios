package com.linzi.xiguwen.bean;

import com.linzi.xiguwen.network.Constans;

import java.io.Serializable;

/**
 * Created by PC on 2018-03-28.
 * 店铺管理--> 我的案例类
 */

public class MyCaseBean extends BaseStatusBean implements Serializable {
    /**
     * {
　　　　　　"clicked":15,
　　　　　　"commented":0,
　　　　　　"create_ti":1514690716,
　　　　　　"evnum":0,
　　　　　　"examinetime":"2018-01-24 17:33:07",
　　　　　　"followed":0,
　　　　　　"goodscore":0,
　　　　　　"id":8,
　　　　　　"num":0,
　　　　　　"putaway":1,
　　　　　　"pv":15,
　　　　　　"statecontent":"审核通过",
　　　　　　"status":2,
　　　　　　"title":"爱的伊甸园",
　　　　　　"update_ti":1516786230,
　　　　　　"userid":16,
　　　　　　"username":"18581882801",
　　　　　　"weddingcover":"http://boyiapi.xxwlb.com/uploads/20180124/a8d392dbf3ad02968e65de54751f0f50.png",
　　　　　　"weddingdescribe":"小草柔软的手臂托起太阳 不同肤色的人走向你 汇成光芒，你像钟一样敲响 震落了山顶的积雪 皱纹深动颤抖的恐惧和忧伤 心灵不再躲到幕布后面 书打开窗户，让群鸟自由飞翔 老树不再打鼾，不再用枯藤 缠住孩子那灵活的小腿 少女们从沐浴中归来 摇曳着星星和辽阔的月光 每个人都有自己的名字 自己的声音，爱情和愿望 兀立在噩梦中的冰山 在早晨消融，从残留的夜色中 人们领走了各自的影子 让沉重的记忆在脚下 在行走中渐渐消失 手臂和手臂相连的地平线上 每个故事有了新的开始 那就开始吧！",
　　　　　　"weddingenvironmentid":2,
　　　　　　"weddingexpenses":168000,
　　　　　　"weddingplace":"爱登堡酒店",
　　　　　　"weddingtime":"2017-12-31",
　　　　　　"weddingtypeid":1,
　　　　　　"weigh":1
　　　　}
     */
    //审核状态1审核中 2通过 3未通过 0未提交

    private int clicked;
    private int commented;
    private long create_ti;
    private int evnum;
    private String examinetime;
    private int followed;
    private int goodscore;
    private int id;
    private int num;
    private int putaway;
    private int pv;
    private String statecontent;
    private int status;
    private String title;
    private long update_ti;
    private int userid;
    private String username;
    private String weddingcover;
    private String weddingdescribe;
    private int weddingenvironmentid;
    private int weddingexpenses;
    private String weddingplace;
    private String weddingtime;
    private int weddingtypeid;
    private int weigh;


    public int getClicked() {
        return clicked;
    }

    public void setClicked(int clicked) {
        this.clicked = clicked;
    }

    public int getCommented() {
        return commented;
    }

    public void setCommented(int commented) {
        this.commented = commented;
    }

    public long getCreate_ti() {
        return create_ti;
    }

    public void setCreate_ti(long create_ti) {
        this.create_ti = create_ti;
    }

    public int getEvnum() {
        return evnum;
    }

    public void setEvnum(int evnum) {
        this.evnum = evnum;
    }

    public String getExaminetime() {
        return examinetime;
    }

    public void setExaminetime(String examinetime) {
        this.examinetime = examinetime;
    }

    public int getFollowed() {
        return followed;
    }

    public void setFollowed(int followed) {
        this.followed = followed;
    }

    public int getGoodscore() {
        return goodscore;
    }

    public void setGoodscore(int goodscore) {
        this.goodscore = goodscore;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getPutaway() {
        return putaway;
    }

    public void setPutaway(int putaway) {
        this.putaway = putaway;
    }

    public int getPv() {
        return pv;
    }

    public void setPv(int pv) {
        this.pv = pv;
    }

    public String getStatecontent() {
        return statecontent;
    }

    public void setStatecontent(String statecontent) {
        this.statecontent = statecontent;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public long getUpdate_ti() {
        return update_ti;
    }

    public void setUpdate_ti(long update_ti) {
        this.update_ti = update_ti;
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

    public String getWeddingcover() {
        return weddingcover;
    }

    public void setWeddingcover(String weddingcover) {
        this.weddingcover = weddingcover;
    }

    public String getWeddingdescribe() {
        return weddingdescribe;
    }

    public void setWeddingdescribe(String weddingdescribe) {
        this.weddingdescribe = weddingdescribe;
    }

    public int getWeddingenvironmentid() {
        return weddingenvironmentid;
    }

    public void setWeddingenvironmentid(int weddingenvironmentid) {
        this.weddingenvironmentid = weddingenvironmentid;
    }

    public int getWeddingexpenses() {
        return weddingexpenses;
    }

    public void setWeddingexpenses(int weddingexpenses) {
        this.weddingexpenses = weddingexpenses;
    }

    public String getWeddingplace() {
        return weddingplace;
    }

    public void setWeddingplace(String weddingplace) {
        this.weddingplace = weddingplace;
    }

    public String getWeddingtime() {
        return weddingtime;
    }

    public void setWeddingtime(String weddingtime) {
        this.weddingtime = weddingtime;
    }

    public int getWeddingtypeid() {
        return weddingtypeid;
    }

    public void setWeddingtypeid(int weddingtypeid) {
        this.weddingtypeid = weddingtypeid;
    }

    public int getWeigh() {
        return weigh;
    }

    public void setWeigh(int weigh) {
        this.weigh = weigh;
    }

    @Override
    public int getMyStatus() {
        return getPutaway();
    }

    @Override
    public int getMyState() {
        return getStatus();
    }

    @Override
    public String getMyTitle() {
        return getTitle();
    }

    @Override
    public String getMyContent() {
        return Constans.RMB + getWeddingexpenses();
    }

    @Override
    public String getMyCover() {
        return getWeddingcover();
    }
}

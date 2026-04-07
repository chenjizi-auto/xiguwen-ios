package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/29  09:39
 *
 * @author luyongjiang
 * @version 1.0
 */
public class WorkBean {

    /**
     * chuangshiren : {"id":8,"userid":16,"username":"18581882801","title":"测试","weddingtime":"2017-12-31","weddingplace":"爱登堡酒店","weddingexpenses":168000,"weddingtypeid":1,"weddingenvironmentid":2,"weigh":1,"weddingcover":"http://www.boyihunjia.com/uploads/20180124/a8d392dbf3ad02968e65de54751f0f50.png","weddingdescribe":"小草柔软的手臂托起太阳 不同肤色的人走向你 汇成光芒，你像钟一样敲响 震落了山顶的积雪 皱纹深动颤抖的恐惧和忧伤 心灵不再躲到幕布后面 书打开窗户，让群鸟自由飞翔 老树不再打鼾，不再用枯藤 缠住孩子那灵活的小腿 少女们从沐浴中归来 摇曳着星星和辽阔的月光 每个人都有自己的名字 自己的声音，爱情和愿望 兀立在噩梦中的冰山 在早晨消融，从残留的夜色中 人们领走了各自的影子 让沉重的记忆在脚下 在行走中渐渐消失 手臂和手臂相连的地平线上 每个故事有了新的开始 那就开始吧！","status":3,"putaway":0,"create_ti":1514690716,"update_ti":1521201880,"statecontent":"  ","examinetime":1521202849,"clicked":179,"followed":0,"commented":0,"pv":179,"num":0,"evnum":0,"goodscore":0,"tuijian":1}
     * chengyuan : [{"id":115,"userid":1483,"username":"17777777777","title":"测试","weddingtime":"2018-03-07","weddingplace":"12我","weddingexpenses":23,"weddingtypeid":1,"weddingenvironmentid":1,"weigh":12,"weddingcover":"http://imgcache.boyihunjia.com/4b907201803290926065000.png","weddingdescribe":"东湖隧道股份代号","status":2,"putaway":1,"create_ti":1522286772,"update_ti":null,"statecontent":"审核通过","examinetime":1522286787,"clicked":0,"followed":0,"commented":0,"pv":0,"num":0,"evnum":0,"goodscore":0,"tuijian":2}]
     */

    private ChuangshirenBean chuangshiren;
    private List<ChengyuanBean> chengyuan;

    public interface OnWorkBean {
        String getTitle();

        int getClicked();

        int getWeddingexpenses();

        String getWeddingcover();

        int getId();
    }

    private int num;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public ChuangshirenBean getChuangshiren() {
        return chuangshiren;
    }

    public void setChuangshiren(ChuangshirenBean chuangshiren) {
        this.chuangshiren = chuangshiren;
    }

    public List<ChengyuanBean> getChengyuan() {
        return chengyuan;
    }

    public void setChengyuan(List<ChengyuanBean> chengyuan) {
        this.chengyuan = chengyuan;
    }

    public static class ChuangshirenBean implements OnWorkBean {
        /**
         * id : 8
         * userid : 16
         * username : 18581882801
         * title : 测试
         * weddingtime : 2017-12-31
         * weddingplace : 爱登堡酒店
         * weddingexpenses : 168000
         * weddingtypeid : 1
         * weddingenvironmentid : 2
         * weigh : 1
         * weddingcover : http://www.boyihunjia.com/uploads/20180124/a8d392dbf3ad02968e65de54751f0f50.png
         * weddingdescribe : 小草柔软的手臂托起太阳 不同肤色的人走向你 汇成光芒，你像钟一样敲响 震落了山顶的积雪 皱纹深动颤抖的恐惧和忧伤 心灵不再躲到幕布后面 书打开窗户，让群鸟自由飞翔 老树不再打鼾，不再用枯藤 缠住孩子那灵活的小腿 少女们从沐浴中归来 摇曳着星星和辽阔的月光 每个人都有自己的名字 自己的声音，爱情和愿望 兀立在噩梦中的冰山 在早晨消融，从残留的夜色中 人们领走了各自的影子 让沉重的记忆在脚下 在行走中渐渐消失 手臂和手臂相连的地平线上 每个故事有了新的开始 那就开始吧！
         * status : 3
         * putaway : 0
         * create_ti : 1514690716
         * update_ti : 1521201880
         * statecontent :
         * examinetime : 1521202849
         * clicked : 179
         * followed : 0
         * commented : 0
         * pv : 179
         * num : 0
         * evnum : 0
         * goodscore : 0
         * tuijian : 1
         */

        private int id;
        private int userid;
        private String username;
        private String title;
        private String weddingtime;
        private String weddingplace;
        private int weddingexpenses;
        private int weddingtypeid;
        private int weddingenvironmentid;
        private int weigh;
        private String weddingcover;
        private String weddingdescribe;
        private int status;
        private int putaway;
        private int create_ti;
        private int update_ti;
        private String statecontent;
        private int examinetime;
        private int clicked;
        private int followed;
        private int commented;
        private int pv;
        private int num;
        private int evnum;
        private int goodscore;
        private int tuijian;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
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

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getWeddingtime() {
            return weddingtime;
        }

        public void setWeddingtime(String weddingtime) {
            this.weddingtime = weddingtime;
        }

        public String getWeddingplace() {
            return weddingplace;
        }

        public void setWeddingplace(String weddingplace) {
            this.weddingplace = weddingplace;
        }

        public int getWeddingexpenses() {
            return weddingexpenses;
        }

        public void setWeddingexpenses(int weddingexpenses) {
            this.weddingexpenses = weddingexpenses;
        }

        public int getWeddingtypeid() {
            return weddingtypeid;
        }

        public void setWeddingtypeid(int weddingtypeid) {
            this.weddingtypeid = weddingtypeid;
        }

        public int getWeddingenvironmentid() {
            return weddingenvironmentid;
        }

        public void setWeddingenvironmentid(int weddingenvironmentid) {
            this.weddingenvironmentid = weddingenvironmentid;
        }

        public int getWeigh() {
            return weigh;
        }

        public void setWeigh(int weigh) {
            this.weigh = weigh;
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

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getPutaway() {
            return putaway;
        }

        public void setPutaway(int putaway) {
            this.putaway = putaway;
        }

        public int getCreate_ti() {
            return create_ti;
        }

        public void setCreate_ti(int create_ti) {
            this.create_ti = create_ti;
        }

        public int getUpdate_ti() {
            return update_ti;
        }

        public void setUpdate_ti(int update_ti) {
            this.update_ti = update_ti;
        }

        public String getStatecontent() {
            return statecontent;
        }

        public void setStatecontent(String statecontent) {
            this.statecontent = statecontent;
        }

        public int getExaminetime() {
            return examinetime;
        }

        public void setExaminetime(int examinetime) {
            this.examinetime = examinetime;
        }

        public int getClicked() {
            return clicked;
        }

        public void setClicked(int clicked) {
            this.clicked = clicked;
        }

        public int getFollowed() {
            return followed;
        }

        public void setFollowed(int followed) {
            this.followed = followed;
        }

        public int getCommented() {
            return commented;
        }

        public void setCommented(int commented) {
            this.commented = commented;
        }

        public int getPv() {
            return pv;
        }

        public void setPv(int pv) {
            this.pv = pv;
        }

        public int getNum() {
            return num;
        }

        public void setNum(int num) {
            this.num = num;
        }

        public int getEvnum() {
            return evnum;
        }

        public void setEvnum(int evnum) {
            this.evnum = evnum;
        }

        public int getGoodscore() {
            return goodscore;
        }

        public void setGoodscore(int goodscore) {
            this.goodscore = goodscore;
        }

        public int getTuijian() {
            return tuijian;
        }

        public void setTuijian(int tuijian) {
            this.tuijian = tuijian;
        }
    }


    public static class ChengyuanBean implements OnWorkBean {
        /**
         * id : 115
         * userid : 1483
         * username : 17777777777
         * title : 测试
         * weddingtime : 2018-03-07
         * weddingplace : 12我
         * weddingexpenses : 23
         * weddingtypeid : 1
         * weddingenvironmentid : 1
         * weigh : 12
         * weddingcover : http://imgcache.boyihunjia.com/4b907201803290926065000.png
         * weddingdescribe : 东湖隧道股份代号
         * status : 2
         * putaway : 1
         * create_ti : 1522286772
         * update_ti : null
         * statecontent : 审核通过
         * examinetime : 1522286787
         * clicked : 0
         * followed : 0
         * commented : 0
         * pv : 0
         * num : 0
         * evnum : 0
         * goodscore : 0
         * tuijian : 2
         */

        private int id;
        private int userid;
        private String username;
        private String title;
        private String weddingtime;
        private String weddingplace;
        private int weddingexpenses;
        private int weddingtypeid;
        private int weddingenvironmentid;
        private int weigh;
        private String weddingcover;
        private String weddingdescribe;
        private int status;
        private int putaway;
        private int create_ti;
        private Object update_ti;
        private String statecontent;
        private int examinetime;
        private int clicked;
        private int followed;
        private int commented;
        private int pv;
        private int num;
        private int evnum;
        private int goodscore;
        private int tuijian;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
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

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getWeddingtime() {
            return weddingtime;
        }

        public void setWeddingtime(String weddingtime) {
            this.weddingtime = weddingtime;
        }

        public String getWeddingplace() {
            return weddingplace;
        }

        public void setWeddingplace(String weddingplace) {
            this.weddingplace = weddingplace;
        }

        public int getWeddingexpenses() {
            return weddingexpenses;
        }

        public void setWeddingexpenses(int weddingexpenses) {
            this.weddingexpenses = weddingexpenses;
        }

        public int getWeddingtypeid() {
            return weddingtypeid;
        }

        public void setWeddingtypeid(int weddingtypeid) {
            this.weddingtypeid = weddingtypeid;
        }

        public int getWeddingenvironmentid() {
            return weddingenvironmentid;
        }

        public void setWeddingenvironmentid(int weddingenvironmentid) {
            this.weddingenvironmentid = weddingenvironmentid;
        }

        public int getWeigh() {
            return weigh;
        }

        public void setWeigh(int weigh) {
            this.weigh = weigh;
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

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getPutaway() {
            return putaway;
        }

        public void setPutaway(int putaway) {
            this.putaway = putaway;
        }

        public int getCreate_ti() {
            return create_ti;
        }

        public void setCreate_ti(int create_ti) {
            this.create_ti = create_ti;
        }

        public Object getUpdate_ti() {
            return update_ti;
        }

        public void setUpdate_ti(Object update_ti) {
            this.update_ti = update_ti;
        }

        public String getStatecontent() {
            return statecontent;
        }

        public void setStatecontent(String statecontent) {
            this.statecontent = statecontent;
        }

        public int getExaminetime() {
            return examinetime;
        }

        public void setExaminetime(int examinetime) {
            this.examinetime = examinetime;
        }

        public int getClicked() {
            return clicked;
        }

        public void setClicked(int clicked) {
            this.clicked = clicked;
        }

        public int getFollowed() {
            return followed;
        }

        public void setFollowed(int followed) {
            this.followed = followed;
        }

        public int getCommented() {
            return commented;
        }

        public void setCommented(int commented) {
            this.commented = commented;
        }

        public int getPv() {
            return pv;
        }

        public void setPv(int pv) {
            this.pv = pv;
        }

        public int getNum() {
            return num;
        }

        public void setNum(int num) {
            this.num = num;
        }

        public int getEvnum() {
            return evnum;
        }

        public void setEvnum(int evnum) {
            this.evnum = evnum;
        }

        public int getGoodscore() {
            return goodscore;
        }

        public void setGoodscore(int goodscore) {
            this.goodscore = goodscore;
        }

        public int getTuijian() {
            return tuijian;
        }

        public void setTuijian(int tuijian) {
            this.tuijian = tuijian;
        }
    }
}

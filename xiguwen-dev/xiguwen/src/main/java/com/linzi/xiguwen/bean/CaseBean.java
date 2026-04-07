package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/3/19.
 */

public class CaseBean {

    /**
     * code : 0
     * message : ok
     * data : [{"id":74,"userid":1249,"title":"灿烂人生","weddingtime":"2018-01-22","weddingplace":"索菲特","weddingexpenses":18000,"weddingtypeid":7,"weddingenvironmentid":6,"weigh":1,"weddingcover":"http://imgcache.boyihunjia.com/d7dec201803191514216803.jpg","weddingdescribe":"本场婚礼走的是高端优雅的轻奢路线。其中有很多金色玫瑰作为装饰，象征着永不凋谢的爱情。我想 觅得一个良人，拥有一段美好的爱情，我们的人生才是完整的，才是耀眼而灿烂的。因而决定把\u201c灿烂人生\u201d作为婚礼主题名字","create_ti":1521443719,"clicked":0,"followed":0,"commented":0,"goodscore":0,"tuijian":2,"nickname":"策划师 杜丽","head":"http://imgcache.boyihunjia.com/e7568201803191518468268.jpg","occupationid":"策划师","follow":0,"afollow":0},{"id":73,"userid":1102,"title":"因为爱你","weddingtime":"2018-02-07","weddingplace":"昇华台大酒店","weddingexpenses":12800,"weddingtypeid":6,"weddingenvironmentid":6,"weigh":2,"weddingcover":"http://imgcache.boyihunjia.com/f5743201803171120121850.jpg","weddingdescribe":"新郎新娘新婚前一天才回来，前期一直在微信沟通，一场完美的答卷交给新人，让您省心放心","create_ti":1521257341,"clicked":18,"followed":0,"commented":0,"goodscore":0,"tuijian":2,"nickname":"成都今夕婚礼","head":"http://imgcache.boyitongcheng.com/b46072018030716512013.png","occupationid":"婚庆公司","follow":0,"afollow":0},{"id":72,"userid":1102,"title":"音乐趴","weddingtime":"2017-07-07","weddingplace":"大草坪","weddingexpenses":26800,"weddingtypeid":11,"weddingenvironmentid":5,"weigh":3,"weddingcover":"http://imgcache.boyihunjia.com/81fc2201803171115363015.jpg","weddingdescribe":"是派对的形式诠释自己的婚礼，没有束缚的环节，只有高唱的情歌，夜幕降临，披上洁白的婚纱，做最美的新娘，最悠然的歌者","create_ti":1521256713,"clicked":2,"followed":0,"commented":0,"goodscore":0,"tuijian":2,"nickname":"成都今夕婚礼","head":"http://imgcache.boyitongcheng.com/b46072018030716512013.png","occupationid":"婚庆公司","follow":0,"afollow":0},{"id":71,"userid":1102,"title":"《颂》","weddingtime":"2016-12-17","weddingplace":"合作酒楼","weddingexpenses":23800,"weddingtypeid":10,"weddingenvironmentid":6,"weigh":3,"weddingcover":"http://imgcache.boyihunjia.com/21455201803171107138544.jpg","weddingdescribe":"新郎是一个爽快的法货男孩，所以有了一场中西结合的婚礼","create_ti":1521256169,"clicked":5,"followed":0,"commented":0,"goodscore":0,"tuijian":2,"nickname":"成都今夕婚礼","head":"http://imgcache.boyitongcheng.com/b46072018030716512013.png","occupationid":"婚庆公司","follow":0,"afollow":0},{"id":70,"userid":1102,"title":"《合》古风中式","weddingtime":"2017-09-10","weddingplace":"大酒店","weddingexpenses":46800,"weddingtypeid":10,"weddingenvironmentid":6,"weigh":5,"weddingcover":"http://imgcache.boyihunjia.com/a9f21201803171059307440.jpg","weddingdescribe":"一抹嫣红伊人醉，良辰吉时天作合。","create_ti":1521255803,"clicked":4,"followed":0,"commented":0,"goodscore":0,"tuijian":2,"nickname":"成都今夕婚礼","head":"http://imgcache.boyitongcheng.com/b46072018030716512013.png","occupationid":"婚庆公司","follow":0,"afollow":0},{"id":69,"userid":1102,"title":"汉式婚礼","weddingtime":"2018-02-07","weddingplace":"郫县大酒店","weddingexpenses":18888,"weddingtypeid":10,"weddingenvironmentid":1,"weigh":5,"weddingcover":"http://imgcache.boyihunjia.com/183ac201803171049509598.jpg","weddingdescribe":"死生契阔，与子成说。\n执子之手，与子偕老。\n于嗟阔兮，不我活兮。\n于嗟洵兮，不我信兮。","create_ti":1521255353,"clicked":4,"followed":0,"commented":0,"goodscore":0,"tuijian":2,"nickname":"成都今夕婚礼","head":"http://imgcache.boyitongcheng.com/b46072018030716512013.png","occupationid":"婚庆公司","follow":0,"afollow":0}]
     */

    private int code;
    private String message;
    private List<DataBean> data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class DataBean {
        /**
         * id : 74
         * userid : 1249
         * title : 灿烂人生
         * weddingtime : 2018-01-22
         * weddingplace : 索菲特
         * weddingexpenses : 18000
         * weddingtypeid : 7
         * weddingenvironmentid : 6
         * weigh : 1
         * weddingcover : http://imgcache.boyihunjia.com/d7dec201803191514216803.jpg
         * weddingdescribe : 本场婚礼走的是高端优雅的轻奢路线。其中有很多金色玫瑰作为装饰，象征着永不凋谢的爱情。我想 觅得一个良人，拥有一段美好的爱情，我们的人生才是完整的，才是耀眼而灿烂的。因而决定把“灿烂人生”作为婚礼主题名字
         * create_ti : 1521443719
         * clicked : 0
         * followed : 0
         * commented : 0
         * goodscore : 0
         * tuijian : 2
         * nickname : 策划师 杜丽
         * head : http://imgcache.boyihunjia.com/e7568201803191518468268.jpg
         * occupationid : 策划师
         * follow : 0
         * afollow : 0
         */

        private int id;
        private int userid;
        private String title;
        private String weddingtime;
        private String weddingplace;
        private int weddingexpenses;
        private int weddingtypeid;
        private int weddingenvironmentid;
        private int weigh;
        private String weddingcover;
        private String weddingdescribe;
        private String weddingdescribea;
        private int create_ti;
        private int clicked;
        private int followed;
        private int commented;
        private int goodscore;
        private int tuijian;
        private String nickname;
        private String head;
        private String occupationid;
        private int follow;
        private int afollow;

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


        public String getWeddingdescribea() {
            return weddingdescribea;
        }

        public void setWeddingdescribea(String weddingdescribea) {
            this.weddingdescribea = weddingdescribea;
        }

        public String getWeddingdescribe() {
            return weddingdescribe;
        }

        public void setWeddingdescribe(String weddingdescribe) {
            this.weddingdescribe = weddingdescribe;
        }

        public int getCreate_ti() {
            return create_ti;
        }

        public void setCreate_ti(int create_ti) {
            this.create_ti = create_ti;
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

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public String getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(String occupationid) {
            this.occupationid = occupationid;
        }

        public int getFollow() {
            return follow;
        }

        public void setFollow(int follow) {
            this.follow = follow;
        }

        public int getAfollow() {
            return afollow;
        }

        public void setAfollow(int afollow) {
            this.afollow = afollow;
        }
    }
}

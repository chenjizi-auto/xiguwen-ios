package com.linzi.xiguwen.fragment.shop.model.bean;

import java.util.List;

/**
 * Created by pc on 2018/3/30.
 */

public class WorksBean {

    /**
     * zuoping : [{"id":56,"title":"测试视频","weigh":1,"video_url":"http://player.youku.com/player.php/sid/XMzQ2MTQ1OTM3Ng==/v.swf","cover":"http://imgcache.boyihunjia.com/e1ea9201803161654098114.jpg","status":2,"putaway":1,"userid":16,"username":"18581882801","create_ti":1521190453,"update_ti":null,"statecontent":"审核通过","examinetime":1521190466,"clicked":1,"followed":0,"type":"sp"},{"id":18,"name":"三机位","weight":2,"cover":"http://www.boyihunjia.com/uploads/20180124/87f673b7c577ff1d49db630835460fd3.jpg","status":2,"putaway":1,"userid":16,"username":"18581882801","create_ti":1516725752,"update_ti":1521286258,"statecontent":"审核通过","examinetime":1521423223,"synopsis":"撒旦法是否所发生的说的发","clicked":1,"followed":0,"type":"tc","photou":[{"id":41,"atlas_id":18,"photo":"/uploads/20180124/0d3bb87b027b99b43393e13ed3d815bb.jpg"},{"id":42,"atlas_id":18,"photo":"/uploads/20180124/3d777c9e66eef1a90332220485d0b0c6.jpg"},{"id":43,"atlas_id":18,"photo":"/uploads/20180124/a963d95f4f4f9a0dae03c4d3649f1fb0.jpg"},{"id":44,"atlas_id":18,"photo":"/uploads/20180124/f08182ba560f5e8c2e2f80251880a544.jpg"}]},{"id":10,"title":"12312fgdsfg dfg ","weigh":3,"video_url":"http://www.boyihunjia.com/Index/admin/video/20180113/b590a2037ed13c46bf554be2e9b037ed.mp4","cover":"http://www.boyihunjia.com/uploads/20180113/c00331e1a48cc3cbdeac94a962c0aeee.jpg","status":2,"putaway":1,"userid":16,"username":"18581882801","create_ti":1515849359,"update_ti":1520849229,"statecontent":"审核通过","examinetime":1520849240,"clicked":1,"followed":0,"type":"sp"},{"id":15,"userid":16,"username":"18581882801","title":"童话里的我们","weddingtime":"2017-12-31","weddingplace":"成都千禧大酒店","weddingexpenses":68000,"weddingtypeid":1,"weddingenvironmentid":4,"weigh":6,"weddingcover":"http://www.boyihunjia.com/uploads/20180124/d2174b0b7709ccab54243e43ce856eca.jpg","weddingdescribe":"星空闪烁，仿佛遥远的召唤：\u201c愿深情一眼挚爱万年，几度轮回恋恋不灭！\u201d","status":2,"putaway":1,"create_ti":1514693451,"update_ti":1516724767,"statecontent":"审核通过","examinetime":1516757258,"clicked":204,"followed":2,"commented":0,"pv":204,"num":0,"evnum":0,"goodscore":0,"tuijian":1,"type":"al"},{"id":14,"userid":16,"username":"18581882801","title":"三生三世","weddingtime":"2017-12-31","weddingplace":"成都千禧大酒店","weddingexpenses":12800,"weddingtypeid":1,"weddingenvironmentid":1,"weigh":5,"weddingcover":"http://www.boyihunjia.com/uploads/20180124/1a18e89dd3fb78e90e483b6a1e73aee9.png","weddingdescribe":"星空闪烁，仿佛遥远的召唤：\u201c愿深情一眼挚爱万年，几度轮回恋恋不灭！\u201d","status":2,"putaway":1,"create_ti":1514693384,"update_ti":1516724758,"statecontent":"审核通过","examinetime":1516757259,"clicked":278,"followed":3,"commented":0,"pv":278,"num":0,"evnum":0,"goodscore":0,"tuijian":1,"type":"al"}]
     * num : 5
     */

    private int num;
    private List<ZuopingBean> zuoping;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<ZuopingBean> getZuoping() {
        return zuoping;
    }

    public void setZuoping(List<ZuopingBean> zuoping) {
        this.zuoping = zuoping;
    }

    public static class ZuopingBean {
        /**
         * id : 56
         * title : 测试视频
         * weigh : 1
         * video_url : http://player.youku.com/player.php/sid/XMzQ2MTQ1OTM3Ng==/v.swf
         * cover : http://imgcache.boyihunjia.com/e1ea9201803161654098114.jpg
         * status : 2
         * putaway : 1
         * userid : 16
         * username : 18581882801
         * create_ti : 1521190453
         * update_ti : null
         * statecontent : 审核通过
         * examinetime : 1521190466
         * clicked : 1
         * followed : 0
         * type : sp
         * name : 三机位
         * weight : 2
         * synopsis : 撒旦法是否所发生的说的发
         * photou : [{"id":41,"atlas_id":18,"photo":"/uploads/20180124/0d3bb87b027b99b43393e13ed3d815bb.jpg"},{"id":42,"atlas_id":18,"photo":"/uploads/20180124/3d777c9e66eef1a90332220485d0b0c6.jpg"},{"id":43,"atlas_id":18,"photo":"/uploads/20180124/a963d95f4f4f9a0dae03c4d3649f1fb0.jpg"},{"id":44,"atlas_id":18,"photo":"/uploads/20180124/f08182ba560f5e8c2e2f80251880a544.jpg"}]
         * weddingtime : 2017-12-31
         * weddingplace : 成都千禧大酒店
         * weddingexpenses : 68000
         * weddingtypeid : 1
         * weddingenvironmentid : 4
         * weddingcover : http://www.boyihunjia.com/uploads/20180124/d2174b0b7709ccab54243e43ce856eca.jpg
         * weddingdescribe : 星空闪烁，仿佛遥远的召唤：“愿深情一眼挚爱万年，几度轮回恋恋不灭！”
         * commented : 0
         * pv : 204
         * num : 0
         * evnum : 0
         * goodscore : 0
         * tuijian : 1
         */

        private int id;
        private String title;
        private int weigh;
        private String video_url;
        private String cover;
        private int status;
        private int putaway;
        private int userid;
        private String username;
        private int create_ti;
        private Object update_ti;
        private String statecontent;
        private int examinetime;
        private int clicked;
        private int followed;
        private String type;
        private String name;
        private int weight;
        private String synopsis;
        private String weddingtime;
        private String weddingplace;
        private String weddingexpenses;
        private int weddingtypeid;
        private int weddingenvironmentid;
        private String weddingcover;
        private String weddingdescribe;
        private int commented;
        private int pv;
        private int num;
        private int evnum;
        private int goodscore;
        private int tuijian;
        private List<PhotouBean> photou;
        private String video_type;

        public String getVideo_type() {
            return video_type;
        }

        public void setVideo_type(String video_type) {
            this.video_type = video_type;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public int getWeigh() {
            return weigh;
        }

        public void setWeigh(int weigh) {
            this.weigh = weigh;
        }

        public String getVideo_url() {
            return video_url;
        }

        public void setVideo_url(String video_url) {
            this.video_url = video_url;
        }

        public String getCover() {
            return cover;
        }

        public void setCover(String cover) {
            this.cover = cover;
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

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public int getWeight() {
            return weight;
        }

        public void setWeight(int weight) {
            this.weight = weight;
        }

        public String getSynopsis() {
            return synopsis;
        }

        public void setSynopsis(String synopsis) {
            this.synopsis = synopsis;
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

        public String getWeddingexpenses() {
            return weddingexpenses;
        }

        public void setWeddingexpenses(String weddingexpenses) {
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

        public List<PhotouBean> getPhotou() {
            return photou;
        }

        public void setPhotou(List<PhotouBean> photou) {
            this.photou = photou;
        }

        public static class PhotouBean {
            /**
             * id : 41
             * atlas_id : 18
             * photo : /uploads/20180124/0d3bb87b027b99b43393e13ed3d815bb.jpg
             */

            private int id;
            private int atlas_id;
            private String photo;

            public int getId() {
                return id;
            }

            public void setId(int id) {
                this.id = id;
            }

            public int getAtlas_id() {
                return atlas_id;
            }

            public void setAtlas_id(int atlas_id) {
                this.atlas_id = atlas_id;
            }

            public String getPhoto() {
                return photo;
            }

            public void setPhoto(String photo) {
                this.photo = photo;
            }
        }
    }
}

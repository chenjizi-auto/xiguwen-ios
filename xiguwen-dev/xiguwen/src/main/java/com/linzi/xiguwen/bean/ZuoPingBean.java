package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/3/26.
 */

public class ZuoPingBean {

    private List<AlBean> al;
    private List<SpBean> sp;
    private List<TcBean> tc;

    public List<AlBean> getAl() {
        return al;
    }

    public void setAl(List<AlBean> al) {
        this.al = al;
    }

    public List<SpBean> getSp() {
        return sp;
    }

    public void setSp(List<SpBean> sp) {
        this.sp = sp;
    }

    public List<TcBean> getTc() {
        return tc;
    }

    public void setTc(List<TcBean> tc) {
        this.tc = tc;
    }

    public static class AlBean {
        /**
         * id : 15
         * userid : 16
         * username : 18581882801
         * title : 童话里的我们
         * weddingtime : 2017-12-31
         * weddingplace : 成都千禧大酒店
         * weddingexpenses : 68000
         * weddingtypeid : 1
         * weddingenvironmentid : 4
         * weigh : 6
         * weddingcover : http://www.boyihunjia.com/uploads/20180124/d2174b0b7709ccab54243e43ce856eca.jpg
         * weddingdescribe : 星空闪烁，仿佛遥远的召唤：“愿深情一眼挚爱万年，几度轮回恋恋不灭！”
         * status : 2
         * putaway : 1
         * create_ti : 1514693451
         * update_ti : 1516724767
         * statecontent : 审核通过
         * examinetime : 1516757258
         * clicked : 150
         * followed : 2
         * commented : 0
         * pv : 150
         * num : 0
         * evnum : 0
         * goodscore : 0
         * tuijian : 1
         * type : al
         */

        private int id;
        private String title;
        private String weddingexpenses;
        private String weddingcover;
        private int clicked;
        private String weddingdescribe;

        public String getWeddingdescribe() {
            return weddingdescribe;
        }

        public void setWeddingdescribe(String weddingdescribe) {
            this.weddingdescribe = weddingdescribe;
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

        public String getWeddingexpenses() {
            return weddingexpenses;
        }

        public void setWeddingexpenses(String weddingexpenses) {
            this.weddingexpenses = weddingexpenses;
        }

        public String getWeddingcover() {
            return weddingcover;
        }

        public void setWeddingcover(String weddingcover) {
            this.weddingcover = weddingcover;
        }

        public int getClicked() {
            return clicked;
        }

        public void setClicked(int clicked) {
            this.clicked = clicked;
        }
    }

    public static class SpBean {
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
         */

        private int id;
        private String title;
        private String video_url;
        private String cover;
        private int clicked;

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

        public int getClicked() {
            return clicked;
        }

        public void setClicked(int clicked) {
            this.clicked = clicked;
        }
    }

    public static class TcBean {
        /**
         * id : 18
         * name : 三机位
         * weight : 2
         * cover : http://www.boyihunjia.com/uploads/20180124/87f673b7c577ff1d49db630835460fd3.jpg
         * status : 2
         * putaway : 1
         * userid : 16
         * username : 18581882801
         * create_ti : 1516725752
         * update_ti : 1521286258
         * statecontent : 审核通过
         * examinetime : 1521423223
         * synopsis : 撒旦法是否所发生的说的发
         * clicked : 1
         * followed : 0
         * type : tc
         * photou : [{"id":41,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/0d3bb87b027b99b43393e13ed3d815bb.jpg"},{"id":42,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/3d777c9e66eef1a90332220485d0b0c6.jpg"},{"id":43,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/a963d95f4f4f9a0dae03c4d3649f1fb0.jpg"},{"id":44,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/f08182ba560f5e8c2e2f80251880a544.jpg"}]
         */

        private int id;
        private String name;
        private String cover;
        private int clicked;
        private List<PhotouBean> photou;
        private String synopsis;

        public String getSynopsis() {
            return synopsis;
        }

        public void setSynopsis(String synopsis) {
            this.synopsis = synopsis;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getCover() {
            return cover;
        }

        public void setCover(String cover) {
            this.cover = cover;
        }

        public int getClicked() {
            return clicked;
        }

        public void setClicked(int clicked) {
            this.clicked = clicked;
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
             * photo : http://www.boyihunjia.com/uploads/20180124/0d3bb87b027b99b43393e13ed3d815bb.jpg
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

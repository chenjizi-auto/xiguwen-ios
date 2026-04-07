package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by PC on 2018-04-09.
 */

public class MusicBean implements Serializable{
    /**
     * data : [{"id":1,"leibie":1,"titile":"小琪琪","url":"http://www.boyihunjia.com/uploads/20180201/b72e3a25092365edfafc8f13b577c044.mp3","weight":1,"dispaly":1,"createt":1517461722}]
     * num : 1
     */

    private int num;
    private List<DataBean> data;

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

    public static class DataBean implements Serializable {
        /**
         * id : 1
         * leibie : 1
         * titile : 小琪琪
         * url : http://www.boyihunjia.com/uploads/20180201/b72e3a25092365edfafc8f13b577c044.mp3
         * weight : 1
         * dispaly : 1
         * createt : 1517461722
         */

        private int id;
        private int leibie;
        private String titile;
        private String url;
        private int weight;
        private int dispaly;
        private int createt;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getLeibie() {
            return leibie;
        }

        public void setLeibie(int leibie) {
            this.leibie = leibie;
        }

        public String getTitile() {
            return titile;
        }

        public void setTitile(String titile) {
            this.titile = titile;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public int getWeight() {
            return weight;
        }

        public void setWeight(int weight) {
            this.weight = weight;
        }

        public int getDispaly() {
            return dispaly;
        }

        public void setDispaly(int dispaly) {
            this.dispaly = dispaly;
        }

        public int getCreatet() {
            return createt;
        }

        public void setCreatet(int createt) {
            this.createt = createt;
        }
    }

//    /**
//     *  {
//     "createt": 1517461722,
//     "dispaly": 1,
//     "id": 1,
//     "leibie": 1,
//     "titile": "小琪琪",
//     "url": "http://boyiapi.xxwlb.com/uploads/20180201/b72e3a25092365edfafc8f13b577c044.mp3",
//     "weight": 1
//     }
//     */
//
//    private long createt;
//    private int dispaly;
//    private int id;
//    private int leibie;
//    private String titile;
//    private String url;
//    private int weight;
//
//    public long getCreatet() {
//        return createt;
//    }
//
//    public void setCreatet(long createt) {
//        this.createt = createt;
//    }
//
//    public int getDispaly() {
//        return dispaly;
//    }
//
//    public void setDispaly(int dispaly) {
//        this.dispaly = dispaly;
//    }
//
//    public int getId() {
//        return id;
//    }
//
//    public void setId(int id) {
//        this.id = id;
//    }
//
//    public int getLeibie() {
//        return leibie;
//    }
//
//    public void setLeibie(int leibie) {
//        this.leibie = leibie;
//    }
//
//    public String getTitile() {
//        return titile;
//    }
//
//    public void setTitile(String titile) {
//        this.titile = titile;
//    }
//
//    public String getUrl() {
//        return url;
//    }
//
//    public void setUrl(String url) {
//        this.url = url;
//    }
//
//    public int getWeight() {
//        return weight;
//    }
//
//    public void setWeight(int weight) {
//        this.weight = weight;
//    }
}

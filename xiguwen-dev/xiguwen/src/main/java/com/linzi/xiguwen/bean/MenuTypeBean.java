package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/4/4.
 */

public class MenuTypeBean {

    /**
     * id : 100008
     * wapname : 婚宴酒店
     * wapimg : http://www.boyihunjia.com/Index/admin/image/180131/6y9Q0136421001517386594.png
     * children : [{"id":100153,"wapname":"星级酒店"},{"id":100154,"wapname":"特色酒店"},{"id":100193,"wapname":"农家乐"},{"id":100206,"wapname":"流水席"}]
     */

    private int id;
    private String wapname;
    private String wapimg;
    private List<ChildrenBean> children;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWapname() {
        return wapname;
    }

    public void setWapname(String wapname) {
        this.wapname = wapname;
    }

    public String getWapimg() {
        return wapimg;
    }

    public void setWapimg(String wapimg) {
        this.wapimg = wapimg;
    }

    public List<ChildrenBean> getChildren() {
        return children;
    }

    public void setChildren(List<ChildrenBean> children) {
        this.children = children;
    }

    public static class ChildrenBean {
        /**
         * id : 100153
         * wapname : 星级酒店
         */

        private int id;
        private String wapname;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getWapname() {
            return wapname;
        }

        public void setWapname(String wapname) {
            this.wapname = wapname;
        }
    }
}


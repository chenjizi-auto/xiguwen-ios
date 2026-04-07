package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by jiang on 2017/11/27.
 */

public class CityBean {

    private String code;
    private String message;
    private DataBean data;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public DataBean getData() {
        return data;
    }

    public void setData(DataBean data) {
        this.data = data;
    }

    public static class DataBean {
        private List<NewsiteBean> newsite;
        private List<SiteBean> site;

        public List<NewsiteBean> getNewsite() {
            return newsite;
        }

        public void setNewsite(List<NewsiteBean> newsite) {
            this.newsite = newsite;
        }

        public List<SiteBean> getSite() {
            return site;
        }

        public void setSite(List<SiteBean> site) {
            this.site = site;
        }

        public static class NewsiteBean {
            /**
             * id : 2
             * name : 北京市
             * pid : 0
             * pinyin : Beijing Shi
             */

            private int id;
            private String name;
            private int pid;
            private String pinyin;

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

            public int getPid() {
                return pid;
            }

            public void setPid(int pid) {
                this.pid = pid;
            }

            public String getPinyin() {
                return pinyin;
            }

            public void setPinyin(String pinyin) {
                this.pinyin = pinyin;
            }
        }

        public static class SiteBean {
            /**
             * id : 2
             * name : 北京市
             * pid : 0
             * pinyin : Beijing Shi
             */

            private int id;
            private String name;
            private int pid;
            private String pinyin;

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

            public int getPid() {
                return pid;
            }

            public void setPid(int pid) {
                this.pid = pid;
            }

            public String getPinyin() {
                return pinyin;
            }

            public void setPinyin(String pinyin) {
                this.pinyin = pinyin;
            }
        }
    }
}

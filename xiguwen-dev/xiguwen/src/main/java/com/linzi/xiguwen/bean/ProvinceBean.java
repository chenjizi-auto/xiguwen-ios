package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by PC on 2018-03-27.
 * 所有省份的数据
 */

public class ProvinceBean {
    /**
     *      "city":Array[1],
　　　　　　"cityid":"110000",
　　　　　　"id":2,
　　　　　　"initial":"B",
　　　　　　"isnew":1,
　　　　　　"lv":"1",
　　　　　　"name":"北京市",
　　　　　　"pid":0,
　　　　　　"pinyin":"Beijing Shi",
　　　　　　"status":1,
　　　　　　"weigh":1
     */
    private List<CityBean> city; // 省的城市
    private String cityid;
    private String id; //省的id
    private String initial;
    private int isnew;
    private String lv;
    private String name;// 名称
    private int pid;
    private String pinyin; //拼音
    private int status;
    private int weigh;


    public List<CityBean> getCity() {
        return city;
    }

    public void setCity(List<CityBean> city) {
        this.city = city;
    }

    public String getCityid() {
        return cityid;
    }

    public void setCityid(String cityid) {
        this.cityid = cityid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getInitial() {
        return initial;
    }

    public void setInitial(String initial) {
        this.initial = initial;
    }

    public int getIsnew() {
        return isnew;
    }

    public void setIsnew(int isnew) {
        this.isnew = isnew;
    }

    public String getLv() {
        return lv;
    }

    public void setLv(String lv) {
        this.lv = lv;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getWeigh() {
        return weigh;
    }

    public void setWeigh(int weigh) {
        this.weigh = weigh;
    }

    /**
     * 所有市区的数据
     */
    public static class CityBean{

        /**
        *          "cityid":"110100",
　　　　　　　　　　"county":Array[1],
　　　　　　　　　　"id":33,
　　　　　　　　　　"initial":"S",
　　　　　　　　　　"isnew":1,
　　　　　　　　　　"lv":"2",
　　　　　　　　　　"name":"北京市",
　　　　　　　　　　"pid":2,
　　　　　　　　　　"pinyin":"Shixiaqu",
　　　　　　　　　　"status":1,
　　　　　　　　　　"weigh":1
         */
        private List<CountyBean> county;
        private String cityid;
        private String id; //省的id
        private String initial;
        private int isnew;
        private String lv;
        private String name;// 名称
        private int pid;
        private String pinyin; //拼音
        private int status;
        private int weigh;


        public List<CountyBean> getCounty() {
            return county;
        }

        public void setCounty(List<CountyBean> county) {
            this.county = county;
        }

        public String getCityid() {
            return cityid;
        }

        public void setCityid(String cityid) {
            this.cityid = cityid;
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getInitial() {
            return initial;
        }

        public void setInitial(String initial) {
            this.initial = initial;
        }

        public int getIsnew() {
            return isnew;
        }

        public void setIsnew(int isnew) {
            this.isnew = isnew;
        }

        public String getLv() {
            return lv;
        }

        public void setLv(String lv) {
            this.lv = lv;
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

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getWeigh() {
            return weigh;
        }

        public void setWeigh(int weigh) {
            this.weigh = weigh;
        }

        /**
         * 所有区的数据
         */
        public static class CountyBean{
            /**
             *    "cityid":"110101",
　　　　　　　　　"id":378,
　　　　　　　　　"initial":"D",
　　　　　　　　　"isnew":0,
　　　　　　　　　"lv":"3",
　　　　　　　　　"name":"东城区",
　　　　　　　　　"pid":33,
　　　　　　　　　"pinyin":"Dongcheng Qu",
　　　　　　　　　"status":1,
　　　　　　　　　"weigh":0
             */
            private String cityid;
            private String id; //省的id
            private String initial;
            private int isnew;
            private String lv;
            private String name;// 名称
            private int pid;
            private String pinyin; //拼音
            private int status;
            private int weigh;


            public String getCityid() {
                return cityid;
            }

            public void setCityid(String cityid) {
                this.cityid = cityid;
            }

            public String getId() {
                return id;
            }

            public void setId(String id) {
                this.id = id;
            }

            public String getInitial() {
                return initial;
            }

            public void setInitial(String initial) {
                this.initial = initial;
            }

            public int getIsnew() {
                return isnew;
            }

            public void setIsnew(int isnew) {
                this.isnew = isnew;
            }

            public String getLv() {
                return lv;
            }

            public void setLv(String lv) {
                this.lv = lv;
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

            public int getStatus() {
                return status;
            }

            public void setStatus(int status) {
                this.status = status;
            }

            public int getWeigh() {
                return weigh;
            }

            public void setWeigh(int weigh) {
                this.weigh = weigh;
            }
        }
    }
}

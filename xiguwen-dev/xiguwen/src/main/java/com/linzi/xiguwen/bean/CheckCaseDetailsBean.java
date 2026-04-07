package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/3/22.
 */

public class CheckCaseDetailsBean {

    /**
     * code : 0
     * message : ok
     * data : [{"xiaoji":717,"title":"婚礼相关服务人员","data":[{"a":"策划师","b":23},{"a":"主持人","b":42},{"a":"婚礼管家","b":32},{"a":"现场督导","b":24},{"a":"化妆师","b":23},{"a":"摄影师","b":4},{"a":"摄像师","b":23},{"a":"灯光师","b":423},{"a":"音响师","b":23},{"a":"花艺师","b":34},{"a":"执行监理","b":43},{"a":"执行搭建","b":23}]},{"xiaoji":1600677,"title":"舞台桁架","data":[{"a":"户外喷绘桁架","b":123123},{"a":"签到区桁架","b":123124},{"a":"签到区桁架","b":123125},{"a":"合影区桁架","b":123126},{"a":"舞台桁架搭建","b":123127},{"a":"交接区","b":123128},{"a":"新娘出场","b":123129},{"a":"顶部桁架","b":123130},{"a":"舞台井字架","b":123131},{"a":"交接区","b":123132},{"a":"舞台搭建","b":123133},{"a":"圆舞台","b":123134},{"a":"直形T台搭建","b":123135}]},{"xiaoji":84,"title":"舞美特效","data":[{"a":"面光筒灯","b":12},{"a":"LED暖光","b":12},{"a":"洗墙灯","b":21},{"a":"光束灯","b":1},{"a":"大追光","b":12},{"a":"LED屏","b":21},{"a":"高流明投影仪","b":2},{"a":"双十五","b":1},{"a":"干冰","b":2}]},{"xiaoji":6236,"title":"平面VI广告设计","data":[{"a":"户外喷绘","b":65},{"a":"指示牌","b":64},{"a":"签到区","b":6},{"a":"合区桁架","b":5454},{"a":"舞台KT板","b":9},{"a":"主题LOGO","b":8},{"a":"新娘出场","b":84},{"a":"圆舞台","b":546}]},{"xiaoji":73067,"title":"场景布置软装","data":[{"a":"红地毯","b":2342},{"a":"签到区","b":2343},{"a":"签到区","b":2344},{"a":"签到区","b":2345},{"a":"签到区","b":2346},{"a":"签到区","b":2347},{"a":"合影区","b":2348},{"a":"合影区","b":2349},{"a":"合影区","b":2350},{"a":"舞台","b":2351},{"a":"舞台","b":2352},{"a":"舞台","b":2353},{"a":"舞台","b":2354},{"a":"舞台","b":2355},{"a":"舞台","b":2356},{"a":"舞台","b":2357},{"a":"舞台","b":2358},{"a":"舞台","b":2359},{"a":"舞台","b":2360},{"a":"舞台","b":2361},{"a":"T台","b":2362},{"a":"T台","b":2363},{"a":"T台","b":2364},{"a":"T台","b":2365},{"a":"T台","b":2366},{"a":"桌花","b":2367},{"a":"手捧花","b":2368},{"a":"婚车花","b":2369},{"a":"新娘手腕花","b":2370},{"a":"新郎胸花","b":2371},{"a":"胸花","b":2372}]},{"xiaoji":717,"title":"物流运输","data":[{"a":"灯光舞美","b":8456},{"a":"搭建","b":5646},{"a":"软装道具","b":546}]}]
     * heji : ["合计",1695429]
     * zongji : 1695429
     */

    private int code;
    private String message;
    private int zongji;
    private List<DataBeanX> data;
    private List<String> heji;

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

    public int getZongji() {
        return zongji;
    }

    public void setZongji(int zongji) {
        this.zongji = zongji;
    }

    public List<DataBeanX> getData() {
        return data;
    }

    public void setData(List<DataBeanX> data) {
        this.data = data;
    }

    public List<String> getHeji() {
        return heji;
    }

    public void setHeji(List<String> heji) {
        this.heji = heji;
    }

    public static class DataBeanX {
        /**
         * xiaoji : 717
         * title : 婚礼相关服务人员
         * data : [{"a":"策划师","b":23},{"a":"主持人","b":42},{"a":"婚礼管家","b":32},{"a":"现场督导","b":24},{"a":"化妆师","b":23},{"a":"摄影师","b":4},{"a":"摄像师","b":23},{"a":"灯光师","b":423},{"a":"音响师","b":23},{"a":"花艺师","b":34},{"a":"执行监理","b":43},{"a":"执行搭建","b":23}]
         */

        private int xiaoji;
        private String title;
        private List<DataBean> data;

        public int getXiaoji() {
            return xiaoji;
        }

        public void setXiaoji(int xiaoji) {
            this.xiaoji = xiaoji;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public List<DataBean> getData() {
            return data;
        }

        public void setData(List<DataBean> data) {
            this.data = data;
        }

        public static class DataBean {
            /**
             * a : 策划师
             * b : 23
             */

            private String a;
            private int b;

            public String getA() {
                return a;
            }

            public void setA(String a) {
                this.a = a;
            }

            public int getB() {
                return b;
            }

            public void setB(int b) {
                this.b = b;
            }
        }
    }

    @Override
    public String toString() {
        return "CheckCaseDetailsBean{" +
                "code=" + code +
                ", message='" + message + '\'' +
                ", zongji=" + zongji +
                ", data=" + data +
                ", heji=" + heji +
                '}';
    }
}

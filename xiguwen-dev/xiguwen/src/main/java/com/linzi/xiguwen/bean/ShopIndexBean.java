package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/4/1.
 */

public class ShopIndexBean {

    /**
     * guanggaolunbo : [{"adid":3,"title":"商城轮播2","adtypeid":16,"aptid":16,"aptype":1,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180216/CXyZ0128773001518790269.jpeg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":1,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"120.00","text":"我是平面中的点，你则是那颗圆心，我的所有轨迹皆是你...","createtime":1518792465},{"adid":4,"title":"商城轮播2","adtypeid":16,"aptid":8,"aptype":3,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180216/xN7o0613148001518789750.jpeg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":2,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"120.00","text":"我是平面中的点，你则是那颗圆心，我的所有轨迹皆是你...","createtime":1518789751}]
     * youhaohuo : {"adid":6,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/oO790636421001517387266.png","title":"有好货","miaoshu":"6","src":"http://boyi.xxwlb.com/"}
     * bimai : {"rmhd1":{"adid":7,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/ED4D0073921001517387277.png","title":"必买清单","miaoshu":"7","src":"http://boyi.xxwlb.com/"},"rmhd2":{"adid":8,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/9Hnt0589546001517387284.png","title":"爱逛街","miaoshu":"8","src":"http://boyi.xxwlb.com/"},"rmhd3":{"adid":9,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/w9y80558296001517387293.png","title":"限时抢购","miaoshu":"9","src":"http://boyi.xxwlb.com/"},"rmhd4":{"adid":10,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/9Cve0261421001517387301.png","title":"抢爆款","miaoshu":"10","src":"http://boyi.xxwlb.com/"},"rmhd5":{"adid":11,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/wFfm0683296001517387309.png","title":"男士专区","miaoshu":"11","src":"http://boyi.xxwlb.com/"}}
     * xiaoguanggaoyi : [{"adid":5,"title":"商城横幅广告","adtypeid":17,"aptid":1116,"aptype":2,"wapimg":"http://imgcache.boyihunjia.com/b69c5201803111638169201.jpg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":1,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"120.00","text":"10、网易云通讯IM账号 账户名：2795458007@qq.com     密码：123qweasd","createtime":1520757537}]
     * renmenpinpai : [{"adid":6,"title":"马量油画","adtypeid":18,"aptid":1116,"aptype":2,"wapimg":"http://imgcache.boyihunjia.com/7222a201803111642234462.jpg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":1,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"120.00","text":"冬日里的阳光，把你衬得如此耀眼。","createtime":1520757770},{"adid":7,"title":"热门品牌2","adtypeid":18,"aptid":16,"aptype":1,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180207/yF1C0862007001517988313.jpeg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":2,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"120.00","text":"冬日里的阳光，把你衬得如此耀眼。","createtime":1517988358},{"adid":8,"title":"热门品牌3","adtypeid":18,"aptid":14,"aptype":3,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180207/7P4C0799507001517988449.jpeg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":3,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"120.00","text":"冬日里的阳光，把你衬得如此耀眼。","createtime":1517988527},{"adid":9,"title":"热门品牌4","adtypeid":18,"aptid":119,"aptype":5,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180207/5OAb0346382001517988474.jpeg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":4,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"120.00","text":"冬日里的阳光，把你衬得如此耀眼。","createtime":1517988531},{"adid":10,"title":"热门品牌5","adtypeid":18,"aptid":57,"aptype":6,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180207/p0QV0424507001517988493.jpeg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":5,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"120.00","text":"冬日里的阳光，把你衬得如此耀眼。","createtime":1517988536},{"adid":11,"title":"热门品牌6","adtypeid":18,"aptid":16,"aptype":1,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180207/kQTV0940132001517988548.jpeg","src":"http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg","site":"","weigh":6,"status":1,"provinceid":24,"cityid":273,"countyid":0,"price":"120.00","text":"冬日里的阳光，把你衬得如此耀眼。","createtime":1517988561}]
     * remenshangpin : [{"shopid":135,"shopname":"测试商品1","price":"0.02","shopimg":["http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg","http://www.boyihunjia.com/uploads/20180208/5ca060584188cba60d9df2cb52f1bde0.jpg","http://www.boyihunjia.com/uploads/20180208/1eb1d84625c397d1887e119edc87b6b6.jpg","http://www.boyihunjia.com/uploads/20180208/20bf75574b6172746d97f568090f2987.jpg"],"head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","nickname":"博艺婚嫁自营店","userid":67,"follows":2,"follow":0,"afollow":1},{"shopid":136,"shopname":"测试商品2","price":"0.05","shopimg":["http://www.boyihunjia.com/uploads/20180208/d9517c6d161f6826da588c82786ee5ef.jpg","http://www.boyihunjia.com/uploads/20180208/355f05dbd803bc93d4c4c4b076f42328.jpg","http://www.boyihunjia.com/uploads/20180208/53036265e0157de5320e7d1f5d7ce94e.jpg","http://www.boyihunjia.com/uploads/20180208/e1b35e03c52c297f4c6d93b5a7aa5eac.jpg"],"head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","nickname":"博艺婚嫁自营店","userid":67,"follows":1,"follow":0,"afollow":0},{"shopid":137,"shopname":"测试商品3","price":"0.02","shopimg":["http://www.boyihunjia.com/uploads/20180208/c215aca9e6805b29dfdbee7dd6c1c5d3.jpg","http://www.boyihunjia.com/uploads/20180208/224014d4e9bef230f7e23a149e2781a0.jpg","http://www.boyihunjia.com/uploads/20180208/9c814a1ca8e2d5b86ba65592a7ce0570.jpg","http://www.boyihunjia.com/uploads/20180208/879873dc34d706645d831553c53f317b.jpg"],"head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","nickname":"博艺婚嫁自营店","userid":67,"follows":3,"follow":0,"afollow":0},{"shopid":142,"shopname":"传统手工油画婚纱挂件系列","price":"5280.00","shopimg":["http://imgcache.boyitongcheng.com/dc373201803091335402026.jpg","http://imgcache.boyitongcheng.com/32f75201803091337008301.jpg","http://imgcache.boyitongcheng.com/848ff201803091337489736.jpg"],"head":"http://imgcache.boyihunjia.com/473db201803111706562189.jpg","nickname":"马量油画","userid":1116,"follows":1,"follow":0,"afollow":0},{"shopid":144,"shopname":"传统纯手工油画婚纱挂件装饰","price":"5280.00","shopimg":["http://imgcache.boyitongcheng.com/4b56920180309141442171.jpg","http://imgcache.boyitongcheng.com/abe10201803091414523794.jpg","http://imgcache.boyitongcheng.com/d9ebd201803091415008242.jpg"],"head":"http://imgcache.boyihunjia.com/473db201803111706562189.jpg","nickname":"马量油画","userid":1116,"follows":0,"follow":0,"afollow":0},{"shopid":146,"shopname":"铁艺菱形背景墙","price":"1800.00","shopimg":["http://imgcache.boyihunjia.com/dac25201803101815308968.jpg","http://imgcache.boyihunjia.com/9ad9e201803101815352728.jpg","http://imgcache.boyihunjia.com/dd1ba201803101815376058.jpg","http://imgcache.boyihunjia.com/bda3e201803101815399650.jpg","http://imgcache.boyihunjia.com/17978201803101815428866.jpg","http://imgcache.boyihunjia.com/c80ea201803101815441286.jpg","http://imgcache.boyihunjia.com/608b8201803101815492595.jpg","http://imgcache.boyihunjia.com/22ca1201803101815523123.jpg","http://imgcache.boyihunjia.com/a1b27201803101816076863.jpg"],"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"道具定制","userid":1193,"follows":0,"follow":0,"afollow":0},{"shopid":147,"shopname":"小圆环桌花器","price":"90.00","shopimg":["http://imgcache.boyihunjia.com/a88f3201803101918263859.jpg","http://imgcache.boyihunjia.com/085ee201803101918312139.jpg","http://imgcache.boyihunjia.com/82d78201803101918373698.jpg","http://imgcache.boyihunjia.com/b7dfa201803101918435647.jpg"],"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"道具定制","userid":1193,"follows":0,"follow":0,"afollow":0},{"shopid":148,"shopname":"铁艺三角形元素主题","price":"950.00","shopimg":["http://imgcache.boyihunjia.com/aa124201803101936283571.jpg","http://imgcache.boyihunjia.com/1324d201803101947505176.jpg","http://imgcache.boyihunjia.com/bf658201803101948016327.jpg","http://imgcache.boyihunjia.com/3b9d9201803101948116080.jpg"],"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"道具定制","userid":1193,"follows":0,"follow":0,"afollow":0},{"shopid":149,"shopname":"私人定制手工油画婚纱装饰挂件","price":"3680.00","shopimg":["http://imgcache.boyihunjia.com/25e1a201803122317252927.jpg","http://imgcache.boyihunjia.com/57b89201803122317412741.jpg","http://imgcache.boyihunjia.com/82e08201803122317518717.jpg"],"head":"http://imgcache.boyihunjia.com/473db201803111706562189.jpg","nickname":"马量油画","userid":1116,"follows":0,"follow":0,"afollow":0}]
     * youlove : [{"shopid":159,"shopname":"（测试）西式婚妙","price":"10.00","shopimg":"http://imgcache.boyihunjia.com/53d50201803311530445910.jpg","nickname":"测试","userid":1457,"cityid":273,"follows":0,"city":"成都市"},{"shopid":158,"shopname":"婚纱","price":"100.00","shopimg":"http://imgcache.boyihunjia.com/3b639201803261650365295.png","nickname":"测试","userid":1457,"cityid":273,"follows":0,"city":"成都市"},{"shopid":157,"shopname":"婚房四件套","price":"258.00","shopimg":"http://imgcache.boyihunjia.com/037b5201803261240164393.png","nickname":"梅子结婚四件套","userid":1330,"cityid":282,"follows":0,"city":"乐山市"},{"shopid":156,"shopname":"结婚洗漱用品女方陪嫁新房用品","price":"20.00","shopimg":"http://imgcache.boyihunjia.com/e55c7201803231521149272.png","nickname":"一生缘坊","userid":1434,"cityid":285,"follows":0,"city":"宜宾市"},{"shopid":155,"shopname":"欧式喜糖袋","price":"3.00","shopimg":"http://imgcache.boyihunjia.com/79cee20180323144533763.png","nickname":"秀秀婚礼用品","userid":1432,"cityid":285,"follows":0,"city":"宜宾市"},{"shopid":154,"shopname":"意卡佐新娘头饰","price":"138.00","shopimg":"http://imgcache.boyihunjia.com/afb8c201803211628162835.png","nickname":"伊人婚品汇","userid":1243,"cityid":342,"follows":0,"city":"张掖市"},{"shopid":153,"shopname":"创意婚房装饰","price":"68.00","shopimg":"http://imgcache.boyihunjia.com/84fb720180321161556556.png","nickname":"兰子婚礼用品","userid":1140,"cityid":342,"follows":0,"city":"张掖市"},{"shopid":152,"shopname":"欧式三角糖果盒","price":"0.28","shopimg":"http://imgcache.boyihunjia.com/4fb01201803211559171772.png","nickname":"宁宁婚庆用品","userid":1141,"cityid":342,"follows":0,"city":"张掖市"},{"shopid":151,"shopname":"个人婚纱艺术礼品油画","price":"3680.00","shopimg":"http://imgcache.boyihunjia.com/213c9201803131522148741.jpg","nickname":"马量油画","userid":1116,"cityid":273,"follows":0,"city":"成都市"}]
     */

    private YouhaohuoBean youhaohuo;
    private BimaiBean bimai;
    private List<GuanggaolunboBean> guanggaolunbo;
    private List<XiaoguanggaoyiBean> xiaoguanggaoyi;
    private List<RenmenpinpaiBean> renmenpinpai;
    private List<RemenshangpinBean> remenshangpin;
    private List<YouloveBean> youlove;

    public YouhaohuoBean getYouhaohuo() {
        return youhaohuo;
    }

    public void setYouhaohuo(YouhaohuoBean youhaohuo) {
        this.youhaohuo = youhaohuo;
    }

    public BimaiBean getBimai() {
        return bimai;
    }

    public void setBimai(BimaiBean bimai) {
        this.bimai = bimai;
    }

    public List<GuanggaolunboBean> getGuanggaolunbo() {
        return guanggaolunbo;
    }

    public void setGuanggaolunbo(List<GuanggaolunboBean> guanggaolunbo) {
        this.guanggaolunbo = guanggaolunbo;
    }

    public List<XiaoguanggaoyiBean> getXiaoguanggaoyi() {
        return xiaoguanggaoyi;
    }

    public void setXiaoguanggaoyi(List<XiaoguanggaoyiBean> xiaoguanggaoyi) {
        this.xiaoguanggaoyi = xiaoguanggaoyi;
    }

    public List<RenmenpinpaiBean> getRenmenpinpai() {
        return renmenpinpai;
    }

    public void setRenmenpinpai(List<RenmenpinpaiBean> renmenpinpai) {
        this.renmenpinpai = renmenpinpai;
    }

    public List<RemenshangpinBean> getRemenshangpin() {
        return remenshangpin;
    }

    public void setRemenshangpin(List<RemenshangpinBean> remenshangpin) {
        this.remenshangpin = remenshangpin;
    }

    public List<YouloveBean> getYoulove() {
        return youlove;
    }

    public void setYoulove(List<YouloveBean> youlove) {
        this.youlove = youlove;
    }

    public static class YouhaohuoBean {
        /**
         * adid : 6
         * wapimg : http://www.boyihunjia.com/Index/admin/image/180131/oO790636421001517387266.png
         * title : 有好货
         * miaoshu : 6
         * src : http://boyi.xxwlb.com/
         */

        private int adid;
        private String wapimg;
        private String title;
        private String miaoshu;
        private String src;

        public int getAdid() {
            return adid;
        }

        public void setAdid(int adid) {
            this.adid = adid;
        }

        public String getWapimg() {
            return wapimg;
        }

        public void setWapimg(String wapimg) {
            this.wapimg = wapimg;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getMiaoshu() {
            return miaoshu;
        }

        public void setMiaoshu(String miaoshu) {
            this.miaoshu = miaoshu;
        }

        public String getSrc() {
            return src;
        }

        public void setSrc(String src) {
            this.src = src;
        }
    }

    public static class BimaiBean {
        /**
         * rmhd1 : {"adid":7,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/ED4D0073921001517387277.png","title":"必买清单","miaoshu":"7","src":"http://boyi.xxwlb.com/"}
         * rmhd2 : {"adid":8,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/9Hnt0589546001517387284.png","title":"爱逛街","miaoshu":"8","src":"http://boyi.xxwlb.com/"}
         * rmhd3 : {"adid":9,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/w9y80558296001517387293.png","title":"限时抢购","miaoshu":"9","src":"http://boyi.xxwlb.com/"}
         * rmhd4 : {"adid":10,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/9Cve0261421001517387301.png","title":"抢爆款","miaoshu":"10","src":"http://boyi.xxwlb.com/"}
         * rmhd5 : {"adid":11,"wapimg":"http://www.boyihunjia.com/Index/admin/image/180131/wFfm0683296001517387309.png","title":"男士专区","miaoshu":"11","src":"http://boyi.xxwlb.com/"}
         */

        private Rmhd1Bean rmhd1;
        private Rmhd2Bean rmhd2;
        private Rmhd3Bean rmhd3;
        private Rmhd4Bean rmhd4;
        private Rmhd5Bean rmhd5;

        public Rmhd1Bean getRmhd1() {
            return rmhd1;
        }

        public void setRmhd1(Rmhd1Bean rmhd1) {
            this.rmhd1 = rmhd1;
        }

        public Rmhd2Bean getRmhd2() {
            return rmhd2;
        }

        public void setRmhd2(Rmhd2Bean rmhd2) {
            this.rmhd2 = rmhd2;
        }

        public Rmhd3Bean getRmhd3() {
            return rmhd3;
        }

        public void setRmhd3(Rmhd3Bean rmhd3) {
            this.rmhd3 = rmhd3;
        }

        public Rmhd4Bean getRmhd4() {
            return rmhd4;
        }

        public void setRmhd4(Rmhd4Bean rmhd4) {
            this.rmhd4 = rmhd4;
        }

        public Rmhd5Bean getRmhd5() {
            return rmhd5;
        }

        public void setRmhd5(Rmhd5Bean rmhd5) {
            this.rmhd5 = rmhd5;
        }

        public static class Rmhd1Bean {
            /**
             * adid : 7
             * wapimg : http://www.boyihunjia.com/Index/admin/image/180131/ED4D0073921001517387277.png
             * title : 必买清单
             * miaoshu : 7
             * src : http://boyi.xxwlb.com/
             */

            private int adid;
            private String wapimg;
            private String title;
            private String miaoshu;
            private String src;

            public int getAdid() {
                return adid;
            }

            public void setAdid(int adid) {
                this.adid = adid;
            }

            public String getWapimg() {
                return wapimg;
            }

            public void setWapimg(String wapimg) {
                this.wapimg = wapimg;
            }

            public String getTitle() {
                return title;
            }

            public void setTitle(String title) {
                this.title = title;
            }

            public String getMiaoshu() {
                return miaoshu;
            }

            public void setMiaoshu(String miaoshu) {
                this.miaoshu = miaoshu;
            }

            public String getSrc() {
                return src;
            }

            public void setSrc(String src) {
                this.src = src;
            }
        }

        public static class Rmhd2Bean {
            /**
             * adid : 8
             * wapimg : http://www.boyihunjia.com/Index/admin/image/180131/9Hnt0589546001517387284.png
             * title : 爱逛街
             * miaoshu : 8
             * src : http://boyi.xxwlb.com/
             */

            private int adid;
            private String wapimg;
            private String title;
            private String miaoshu;
            private String src;

            public int getAdid() {
                return adid;
            }

            public void setAdid(int adid) {
                this.adid = adid;
            }

            public String getWapimg() {
                return wapimg;
            }

            public void setWapimg(String wapimg) {
                this.wapimg = wapimg;
            }

            public String getTitle() {
                return title;
            }

            public void setTitle(String title) {
                this.title = title;
            }

            public String getMiaoshu() {
                return miaoshu;
            }

            public void setMiaoshu(String miaoshu) {
                this.miaoshu = miaoshu;
            }

            public String getSrc() {
                return src;
            }

            public void setSrc(String src) {
                this.src = src;
            }
        }

        public static class Rmhd3Bean {
            /**
             * adid : 9
             * wapimg : http://www.boyihunjia.com/Index/admin/image/180131/w9y80558296001517387293.png
             * title : 限时抢购
             * miaoshu : 9
             * src : http://boyi.xxwlb.com/
             */

            private int adid;
            private String wapimg;
            private String title;
            private String miaoshu;
            private String src;

            public int getAdid() {
                return adid;
            }

            public void setAdid(int adid) {
                this.adid = adid;
            }

            public String getWapimg() {
                return wapimg;
            }

            public void setWapimg(String wapimg) {
                this.wapimg = wapimg;
            }

            public String getTitle() {
                return title;
            }

            public void setTitle(String title) {
                this.title = title;
            }

            public String getMiaoshu() {
                return miaoshu;
            }

            public void setMiaoshu(String miaoshu) {
                this.miaoshu = miaoshu;
            }

            public String getSrc() {
                return src;
            }

            public void setSrc(String src) {
                this.src = src;
            }
        }

        public static class Rmhd4Bean {
            /**
             * adid : 10
             * wapimg : http://www.boyihunjia.com/Index/admin/image/180131/9Cve0261421001517387301.png
             * title : 抢爆款
             * miaoshu : 10
             * src : http://boyi.xxwlb.com/
             */

            private int adid;
            private String wapimg;
            private String title;
            private String miaoshu;
            private String src;

            public int getAdid() {
                return adid;
            }

            public void setAdid(int adid) {
                this.adid = adid;
            }

            public String getWapimg() {
                return wapimg;
            }

            public void setWapimg(String wapimg) {
                this.wapimg = wapimg;
            }

            public String getTitle() {
                return title;
            }

            public void setTitle(String title) {
                this.title = title;
            }

            public String getMiaoshu() {
                return miaoshu;
            }

            public void setMiaoshu(String miaoshu) {
                this.miaoshu = miaoshu;
            }

            public String getSrc() {
                return src;
            }

            public void setSrc(String src) {
                this.src = src;
            }
        }

        public static class Rmhd5Bean {
            /**
             * adid : 11
             * wapimg : http://www.boyihunjia.com/Index/admin/image/180131/wFfm0683296001517387309.png
             * title : 男士专区
             * miaoshu : 11
             * src : http://boyi.xxwlb.com/
             */

            private int adid;
            private String wapimg;
            private String title;
            private String miaoshu;
            private String src;

            public int getAdid() {
                return adid;
            }

            public void setAdid(int adid) {
                this.adid = adid;
            }

            public String getWapimg() {
                return wapimg;
            }

            public void setWapimg(String wapimg) {
                this.wapimg = wapimg;
            }

            public String getTitle() {
                return title;
            }

            public void setTitle(String title) {
                this.title = title;
            }

            public String getMiaoshu() {
                return miaoshu;
            }

            public void setMiaoshu(String miaoshu) {
                this.miaoshu = miaoshu;
            }

            public String getSrc() {
                return src;
            }

            public void setSrc(String src) {
                this.src = src;
            }
        }
    }

    public static class GuanggaolunboBean {
        /**
         * adid : 3
         * title : 商城轮播2
         * adtypeid : 16
         * aptid : 16
         * aptype : 1
         * wapimg : http://www.boyihunjia.com/Index/admin/image/180216/CXyZ0128773001518790269.jpeg
         * src : http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg
         * site :
         * weigh : 1
         * status : 1
         * provinceid : 24
         * cityid : 273
         * countyid : 0
         * price : 120.00
         * text : 我是平面中的点，你则是那颗圆心，我的所有轨迹皆是你...
         * createtime : 1518792465
         */

        private int adid;
        private String title;
        private int adtypeid;
        private int aptid;
        private int aptype;
        private String wapimg;
        private String src;
        private String site;
        private int weigh;
        private int status;
        private int provinceid;
        private int cityid;
        private int countyid;
        private String price;
        private String text;
        private int createtime;

        public int getAdid() {
            return adid;
        }

        public void setAdid(int adid) {
            this.adid = adid;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public int getAdtypeid() {
            return adtypeid;
        }

        public void setAdtypeid(int adtypeid) {
            this.adtypeid = adtypeid;
        }

        public int getAptid() {
            return aptid;
        }

        public void setAptid(int aptid) {
            this.aptid = aptid;
        }

        public int getAptype() {
            return aptype;
        }

        public void setAptype(int aptype) {
            this.aptype = aptype;
        }

        public String getWapimg() {
            return wapimg;
        }

        public void setWapimg(String wapimg) {
            this.wapimg = wapimg;
        }

        public String getSrc() {
            return src;
        }

        public void setSrc(String src) {
            this.src = src;
        }

        public String getSite() {
            return site;
        }

        public void setSite(String site) {
            this.site = site;
        }

        public int getWeigh() {
            return weigh;
        }

        public void setWeigh(int weigh) {
            this.weigh = weigh;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getProvinceid() {
            return provinceid;
        }

        public void setProvinceid(int provinceid) {
            this.provinceid = provinceid;
        }

        public int getCityid() {
            return cityid;
        }

        public void setCityid(int cityid) {
            this.cityid = cityid;
        }

        public int getCountyid() {
            return countyid;
        }

        public void setCountyid(int countyid) {
            this.countyid = countyid;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public int getCreatetime() {
            return createtime;
        }

        public void setCreatetime(int createtime) {
            this.createtime = createtime;
        }
    }

    public static class XiaoguanggaoyiBean {
        /**
         * adid : 5
         * title : 商城横幅广告
         * adtypeid : 17
         * aptid : 1116
         * aptype : 2
         * wapimg : http://imgcache.boyihunjia.com/b69c5201803111638169201.jpg
         * src : http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg
         * site :
         * weigh : 1
         * status : 1
         * provinceid : 24
         * cityid : 273
         * countyid : 0
         * price : 120.00
         * text : 10、网易云通讯IM账号 账户名：2795458007@qq.com     密码：123qweasd
         * createtime : 1520757537
         */

        private int adid;
        private String title;
        private int adtypeid;
        private int aptid;
        private int aptype;
        private String wapimg;
        private String src;
        private String site;
        private int weigh;
        private int status;
        private int provinceid;
        private int cityid;
        private int countyid;
        private String price;
        private String text;
        private int createtime;

        public int getAdid() {
            return adid;
        }

        public void setAdid(int adid) {
            this.adid = adid;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public int getAdtypeid() {
            return adtypeid;
        }

        public void setAdtypeid(int adtypeid) {
            this.adtypeid = adtypeid;
        }

        public int getAptid() {
            return aptid;
        }

        public void setAptid(int aptid) {
            this.aptid = aptid;
        }

        public int getAptype() {
            return aptype;
        }

        public void setAptype(int aptype) {
            this.aptype = aptype;
        }

        public String getWapimg() {
            return wapimg;
        }

        public void setWapimg(String wapimg) {
            this.wapimg = wapimg;
        }

        public String getSrc() {
            return src;
        }

        public void setSrc(String src) {
            this.src = src;
        }

        public String getSite() {
            return site;
        }

        public void setSite(String site) {
            this.site = site;
        }

        public int getWeigh() {
            return weigh;
        }

        public void setWeigh(int weigh) {
            this.weigh = weigh;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getProvinceid() {
            return provinceid;
        }

        public void setProvinceid(int provinceid) {
            this.provinceid = provinceid;
        }

        public int getCityid() {
            return cityid;
        }

        public void setCityid(int cityid) {
            this.cityid = cityid;
        }

        public int getCountyid() {
            return countyid;
        }

        public void setCountyid(int countyid) {
            this.countyid = countyid;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public int getCreatetime() {
            return createtime;
        }

        public void setCreatetime(int createtime) {
            this.createtime = createtime;
        }
    }

    public static class RenmenpinpaiBean {
        /**
         * adid : 6
         * title : 马量油画
         * adtypeid : 18
         * aptid : 1116
         * aptype : 2
         * wapimg : http://imgcache.boyihunjia.com/7222a201803111642234462.jpg
         * src : http://www.boyihunjia.com/Index/admin/image/180126/Dxf00859171001516948669.jpeg
         * site :
         * weigh : 1
         * status : 1
         * provinceid : 24
         * cityid : 273
         * countyid : 0
         * price : 120.00
         * text : 冬日里的阳光，把你衬得如此耀眼。
         * createtime : 1520757770
         */

        private int adid;
        private String title;
        private int adtypeid;
        private int aptid;
        private int aptype;
        private String wapimg;
        private String src;
        private String site;
        private int weigh;
        private int status;
        private int provinceid;
        private int cityid;
        private int countyid;
        private String price;
        private String text;
        private int createtime;

        public int getAdid() {
            return adid;
        }

        public void setAdid(int adid) {
            this.adid = adid;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public int getAdtypeid() {
            return adtypeid;
        }

        public void setAdtypeid(int adtypeid) {
            this.adtypeid = adtypeid;
        }

        public int getAptid() {
            return aptid;
        }

        public void setAptid(int aptid) {
            this.aptid = aptid;
        }

        public int getAptype() {
            return aptype;
        }

        public void setAptype(int aptype) {
            this.aptype = aptype;
        }

        public String getWapimg() {
            return wapimg;
        }

        public void setWapimg(String wapimg) {
            this.wapimg = wapimg;
        }

        public String getSrc() {
            return src;
        }

        public void setSrc(String src) {
            this.src = src;
        }

        public String getSite() {
            return site;
        }

        public void setSite(String site) {
            this.site = site;
        }

        public int getWeigh() {
            return weigh;
        }

        public void setWeigh(int weigh) {
            this.weigh = weigh;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getProvinceid() {
            return provinceid;
        }

        public void setProvinceid(int provinceid) {
            this.provinceid = provinceid;
        }

        public int getCityid() {
            return cityid;
        }

        public void setCityid(int cityid) {
            this.cityid = cityid;
        }

        public int getCountyid() {
            return countyid;
        }

        public void setCountyid(int countyid) {
            this.countyid = countyid;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public int getCreatetime() {
            return createtime;
        }

        public void setCreatetime(int createtime) {
            this.createtime = createtime;
        }
    }

    public static class RemenshangpinBean {
        /**
         * shopid : 135
         * shopname : 测试商品1
         * price : 0.02
         * shopimg : ["http://www.boyihunjia.com/uploads/20180208/964cea7ffc92e81a30d65ccf0082b1b2.jpg","http://www.boyihunjia.com/uploads/20180208/5ca060584188cba60d9df2cb52f1bde0.jpg","http://www.boyihunjia.com/uploads/20180208/1eb1d84625c397d1887e119edc87b6b6.jpg","http://www.boyihunjia.com/uploads/20180208/20bf75574b6172746d97f568090f2987.jpg"]
         * head : http://imgcache.boyihunjia.com/9769c201803120905146801.png
         * nickname : 博艺婚嫁自营店
         * userid : 67
         * follows : 2
         * follow : 0
         * afollow : 1
         */

        private int shopid;
        private String shopname;
        private String price;
        private String head;
        private String nickname;
        private int userid;
        private int follows;
        private int follow;
        private int afollow;
        private List<String> shopimg;

        public int getShopid() {
            return shopid;
        }

        public void setShopid(int shopid) {
            this.shopid = shopid;
        }

        public String getShopname() {
            return shopname;
        }

        public void setShopname(String shopname) {
            this.shopname = shopname;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public int getFollows() {
            return follows;
        }

        public void setFollows(int follows) {
            this.follows = follows;
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

        public List<String> getShopimg() {
            return shopimg;
        }

        public void setShopimg(List<String> shopimg) {
            this.shopimg = shopimg;
        }
    }

    public static class YouloveBean {
        /**
         * shopid : 159
         * shopname : （测试）西式婚妙
         * price : 10.00
         * shopimg : http://imgcache.boyihunjia.com/53d50201803311530445910.jpg
         * nickname : 测试
         * userid : 1457
         * cityid : 273
         * follows : 0
         * city : 成都市
         */

        private int shopid;
        private String shopname;
        private String price;
        private String shopimg;
        private String nickname;
        private int userid;
        private int cityid;
        private int follows;
        private String city;

        public int getShopid() {
            return shopid;
        }

        public void setShopid(int shopid) {
            this.shopid = shopid;
        }

        public String getShopname() {
            return shopname;
        }

        public void setShopname(String shopname) {
            this.shopname = shopname;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public String getShopimg() {
            return shopimg;
        }

        public void setShopimg(String shopimg) {
            this.shopimg = shopimg;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public int getCityid() {
            return cityid;
        }

        public void setCityid(int cityid) {
            this.cityid = cityid;
        }

        public int getFollows() {
            return follows;
        }

        public void setFollows(int follows) {
            this.follows = follows;
        }

        public String getCity() {
            return city;
        }

        public void setCity(String city) {
            this.city = city;
        }
    }
}

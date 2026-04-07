package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by devin on 2018/4/16 15:48
 * Description
 */

public class BankCardEntity implements Serializable {
    /**
     * list : [{"id":32,"userid":3443,"name":"dre******veyou@sina.com","ali_name":"*强","selection":1},{"id":33,"userid":3443,"name":"公******","ali_name":"*捣","selection":0}]
     * ids : 32
     * mobile : 18581882801
     * mobiles : 185****2801
     * money : 23.30
     * m_quota : 10.00
     */

    private int ids;
    private String mobile;
    private String mobiles;
    private String money;
    private String m_quota;
    private List<ListBean> list;

    public int getIds() {
        return ids;
    }

    public void setIds(int ids) {
        this.ids = ids;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getMobiles() {
        return mobiles;
    }

    public void setMobiles(String mobiles) {
        this.mobiles = mobiles;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getM_quota() {
        return m_quota;
    }

    public void setM_quota(String m_quota) {
        this.m_quota = m_quota;
    }

    public List<ListBean> getList() {
        return list;
    }

    public void setList(List<ListBean> list) {
        this.list = list;
    }

    public static class ListBean {
        /**
         * id : 32
         * userid : 3443
         * name : dre******veyou@sina.com
         * ali_name : *强
         * selection : 1
         */

        private int id;
        private int userid;
        private String name;
        private String ali_name;
        private int selection;

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

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getAli_name() {
            return ali_name;
        }

        public void setAli_name(String ali_name) {
            this.ali_name = ali_name;
        }

        public int getSelection() {
            return selection;
        }

        public void setSelection(int selection) {
            this.selection = selection;
        }
    }

//    private String band_number;
//    private String bandid;
//    private String bandname;
//    private String icon;
//    private int id;
//    private String mobile;
//    private String site;
//
//    public String getBand_number() {
//        return band_number;
//    }
//
//    public void setBand_number(String band_number) {
//        this.band_number = band_number;
//    }
//
//    public String getBandid() {
//        return bandid;
//    }
//
//    public void setBandid(String bandid) {
//        this.bandid = bandid;
//    }
//
//    public String getBandname() {
//        return bandname;
//    }
//
//    public void setBandname(String bandname) {
//        this.bandname = bandname;
//    }
//
//    public String getIcon() {
//        return icon;
//    }
//
//    public void setIcon(String icon) {
//        this.icon = icon;
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
//    public String getMobile() {
//        return mobile;
//    }
//
//    public void setMobile(String mobile) {
//        this.mobile = mobile;
//    }
//
//    public String getSite() {
//        return site;
//    }
//
//    public void setSite(String site) {
//        this.site = site;
//    }


}

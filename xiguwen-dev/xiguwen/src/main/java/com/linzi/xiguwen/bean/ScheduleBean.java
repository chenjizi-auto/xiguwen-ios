package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/3/24.
 */

public class ScheduleBean {

    /**
     * dateye : 2018年03月
     * danshu : 18
     * dangqi : [{"id":179,"date":"20日","timeslot":"中午","contacts":"13551862869","contactnumber":"13551862869","remarks":"订单wedding2018031910175159247","userid":16,"username":null,"create_ti":1521426081,"update_ti":null,"dateye":"2018年03月","shijiancuo":1521475200,"order_id":274},{"id":165,"date":"21日","timeslot":"中午","contacts":"13551862869","contactnumber":"13551862869","remarks":"订单wedding2018031717494544567","userid":16,"username":null,"create_ti":1521280279,"update_ti":null,"dateye":"2018年03月","shijiancuo":1521561600,"order_id":263}]
     */

    private String dateye;
    private List<DangqiBean> dangqi;

    public String getDateye() {
        return dateye;
    }

    public void setDateye(String dateye) {
        this.dateye = dateye;
    }

    public List<DangqiBean> getDangqi() {
        return dangqi;
    }

    public void setDangqi(List<DangqiBean> dangqi) {
        this.dangqi = dangqi;
    }

    public static class DangqiBean {
        /**
         * id : 179
         * date : 20日
         * timeslot : 中午
         * contacts : 13551862869
         * contactnumber : 13551862869
         * remarks : 订单wedding2018031910175159247
         * userid : 16
         * username : null
         * create_ti : 1521426081
         * update_ti : null
         * dateye : 2018年03月
         * shijiancuo : 1521475200
         * order_id : 274
         */

        private int id;
        private String date;
        private String timeslot;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getDate() {
            return date;
        }

        public void setDate(String date) {
            this.date = date;
        }

        public String getTimeslot() {
            return timeslot;
        }

        public void setTimeslot(String timeslot) {
            this.timeslot = timeslot;
        }
    }
}

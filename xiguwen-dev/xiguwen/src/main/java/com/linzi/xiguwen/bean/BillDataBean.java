package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by PC on 2018-04-03.
 * 记账助手数据
 */

public class BillDataBean {
    /**
     * {
     "dshuru": 3455,
     "dzhichu": 905,
     "list": [
     {
     "occurrence": "01-28",
     "shouru": 3455,
     "tian": [
     {
     "aftermoney": 200,
     "create": 1517068800,
     "id": 1,
     "occurrence": 1517068800,
     "remarks": "cs",
     "type": 1,
     "userid": 16
     }
     ],
     "zhichu": 905
     }
     ]
     }
     */
    public final static int TYPE_SHOURU = 2; // 收入
    public final static int TYPE_ZHICHU = 1; // 支出

    private float dshuru;   // 当月收入
    private float dzhichu;  // 当月支出
    private List<BillList> list;    // 列表


    public float getDshuru() {
        return dshuru;
    }

    public void setDshuru(float dshuru) {
        this.dshuru = dshuru;
    }

    public float getDzhichu() {
        return dzhichu;
    }

    public void setDzhichu(float dzhichu) {
        this.dzhichu = dzhichu;
    }

    public List<BillList> getList() {
        return list;
    }

    public void setList(List<BillList> list) {
        this.list = list;
    }

    public void append(BillDataBean data){
        if(data != null){
            for (BillList currentBillList : list) {
                for (BillList billList : data.getList()) {
                    if(currentBillList.getRiqi().equals(billList.getRiqi())){
                        // 日期相同，则融合到同一列
                        currentBillList.getTian().addAll(billList.getTian());
                        data.getList().remove(billList);
                        break;
                    }
                }
            }
            list.addAll(data.getList());
        }
    }

    public static class BillList{
        private String riqi;  //日期
        private float ritongji;   //当天统计
        private List<Bill> tian; // 账单数据

        public String getRiqi() {
            return riqi;
        }

        public void setRiqi(String riqi) {
            this.riqi = riqi;
        }

        public float getRitongji() {
            return ritongji;
        }

        public void setRitongji(float ritongji) {
            this.ritongji = ritongji;
        }

        public List<Bill> getTian() {
            return tian;
        }

        public void setTian(List<Bill> tian) {
            this.tian = tian;
        }
    }

    public static class Bill{
        private float aftermoney;   // 发生金额
        private long create;        // 创建时间
        private int id;             //id
        private String occurrence;    // 时间
        private String remarks;     // 备注
        private int type;           // 类型
        private long userid;        // 用户id

        public float getAftermoney() {
            return aftermoney;
        }

        public void setAftermoney(float aftermoney) {
            this.aftermoney = aftermoney;
        }

        public long getCreate() {
            return create;
        }

        public void setCreate(long create) {
            this.create = create;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getOccurrence() {
            return occurrence;
        }

        public void setOccurrence(String occurrence) {
            this.occurrence = occurrence;
        }

        public String getRemarks() {
            return remarks;
        }

        public void setRemarks(String remarks) {
            this.remarks = remarks;
        }

        public int getType() {
            return type;
        }

        public void setType(int type) {
            this.type = type;
        }

        public long getUserid() {
            return userid;
        }

        public void setUserid(long userid) {
            this.userid = userid;
        }
    }
}

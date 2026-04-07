package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by devin on 2018/4/16 11:22
 * Description
 */

public class AttentionData implements Serializable {
    private List<MerchantEntity> shangjia;
    private List<CaseBean.DataBean> anli;
    private List<ShopEntity> shangping;

    public List<MerchantEntity> getShangjia() {
        return shangjia;
    }

    public void setShangjia(List<MerchantEntity> shangjia) {
        this.shangjia = shangjia;
    }

    public List<CaseBean.DataBean> getAnli() {
        return anli;
    }

    public void setAnli(List<CaseBean.DataBean> anli) {
        this.anli = anli;
    }

    public List<ShopEntity> getShangping() {
        return shangping;
    }

    public void setShangping(List<ShopEntity> shangping) {
        this.shangping = shangping;
    }
}

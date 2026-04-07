package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by devin on 2018/4/16 15:47
 * Description
 */

public class TixianData implements Serializable {

    private String yue;
    private List<BankCardEntity> kahao;

    public String getYue() {
        return yue;
    }

    public void setYue(String yue) {
        this.yue = yue;
    }

    public List<BankCardEntity> getKahao() {
        return kahao;
    }

    public void setKahao(List<BankCardEntity> kahao) {
        this.kahao = kahao;
    }
}

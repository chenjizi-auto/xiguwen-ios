package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/5/22.
 */

public class SignInBean {

    /**
     * lianxutianshu : 1
     * huodejifen : 1
     * jifen : [1,2,3,4,5,6,7]
     */

    private int lianxutianshu;
    private int huodejifen;
    private List<Integer> jifen;

    public int getLianxutianshu() {
        return lianxutianshu;
    }

    public void setLianxutianshu(int lianxutianshu) {
        this.lianxutianshu = lianxutianshu;
    }

    public int getHuodejifen() {
        return huodejifen;
    }

    public void setHuodejifen(int huodejifen) {
        this.huodejifen = huodejifen;
    }

    public List<Integer> getJifen() {
        return jifen;
    }

    public void setJifen(List<Integer> jifen) {
        this.jifen = jifen;
    }
}

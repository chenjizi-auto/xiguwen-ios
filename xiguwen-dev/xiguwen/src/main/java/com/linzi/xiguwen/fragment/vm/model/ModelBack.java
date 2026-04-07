package com.linzi.xiguwen.fragment.vm.model;

/**
 * Title:
 * Description:为了适应model诞生出的接口
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  09:24
 *
 * @author luyongjiang
 * @version 1.0
 */
public interface ModelBack<T> {
    void onBack(T data);
}
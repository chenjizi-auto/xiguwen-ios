package com.linzi.xiguwen.fragment.vm.model;

/**
 * Title:
 * Description:用来实现不同的数据获取,有时候可能从外部装载的时候需要
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  09:24
 *
 * @author luyongjiang
 * @version 1.0
 */

public interface BaseModel<T> {
    void getData(ModelBack<T> modelBack);

    T getData();
}

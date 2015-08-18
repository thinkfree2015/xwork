package com.efeiyi.pal.system.order.service;

import com.efeiyi.pal.label.model.Label;

import java.util.List;

/**
 * Created by Administrator on 2015/8/18.
 */
public interface LabelServiceManager {

    Integer getMinSerial();

    List<Label> getLabelListByMinSerialAndSumProduct(Integer minSerial, Integer sumProduct);

}

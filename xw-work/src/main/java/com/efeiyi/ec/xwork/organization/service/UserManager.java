package com.efeiyi.ec.xwork.organization.service;

import com.efeiyi.ec.xw.organization.model.MyUser;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.taglib.PageEntity;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午5:01
 * To change this template use File | Settings | File Templates.
 */
public interface UserManager {


    public List<MyUser> listBigUser(String teachAreaId);

    public void saveOrUpdateBigUser(MyUser bigUser);

    public PageInfo pageBigUser(String teachAreaId, PageEntity pageEntity);
}

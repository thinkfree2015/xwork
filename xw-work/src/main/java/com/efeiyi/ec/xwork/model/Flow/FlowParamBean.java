package com.efeiyi.ec.xwork.model.Flow;

import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.organization.model.User;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2015/12/8.
 */
public class FlowParamBean implements Serializable {
    private String id;
    private String title;
    private String type;
    private List<FlowActivity> activityList;
    private List<User> notifyUserList;
    private String begin;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    @OneToMany(fetch = FetchType.LAZY,cascade=CascadeType.ALL)
    public List<User> getNotifyUserList() {
        return notifyUserList;
    }

    public void setNotifyUserList(List<User> notifyUserList) {
        this.notifyUserList = notifyUserList;
    }
    public List<FlowActivity> getActivityList() {
        return activityList;
    }

    public void setActivityList(List<FlowActivity> activityList) {
        this.activityList = activityList;
    }
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getBegin() {
        return begin;
    }

    public void setBegin(String begin) {
        this.begin = begin;
    }
}

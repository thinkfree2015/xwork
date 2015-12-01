package com.efeiyi.ec.xw.flow.model;

import com.efeiyi.ec.xw.organization.model.User;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/12/1.
 */
public class Flow {
    private String id;
    private String title;
    private List<FlowActivity> activityList;
    private List<User> notifyUserList;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
    public List<User> getNotifyUserList() {
        return notifyUserList;
    }

    public void setNotifyUserList(List<User> notifyUserList) {
        this.notifyUserList = notifyUserList;
    }
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "flowActivity", cascade = CascadeType.ALL)
    public List<FlowActivity> getActivityList() {
        return activityList;
    }

    public void setActivityList(List<FlowActivity> activityList) {
        this.activityList = activityList;
    }
}

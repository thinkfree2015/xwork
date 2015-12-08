package com.efeiyi.ec.xw.flow.model;

import com.efeiyi.ec.xw.organization.model.User;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * Created by Administrator on 2015/12/1.
 *
 */
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
@Entity
@Table(name = "xw_flow")
public class Flow implements Serializable {
    private String id;
    private String title;
    private String type;
    private List<FlowActivity> activityList;
    private List<User> notifyUserList;
    private String status;


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


    @OneToMany(fetch = FetchType.LAZY,cascade=CascadeType.ALL)
    @JoinTable(name = "xw_flow_user",
            joinColumns = {@JoinColumn(name = "flow_id",referencedColumnName="id")},
            inverseJoinColumns = {@JoinColumn(name = "user_id",referencedColumnName="id")}
    )
    public List<User> getNotifyUserList() {
        return notifyUserList;
    }

    public void setNotifyUserList(List<User> notifyUserList) {
        this.notifyUserList = notifyUserList;
    }
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "flow",cascade=CascadeType.ALL)
    public List<FlowActivity> getActivityList() {
        return activityList;
    }

    public void setActivityList(List<FlowActivity> activityList) {
        this.activityList = activityList;
    }
    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

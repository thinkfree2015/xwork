package com.efeiyi.ec.xw.flow.model;

import com.efeiyi.ec.xw.organization.model.User;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2015/12/1.
 *
 */
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
@Entity
@Table(name = "xw_flow_activity")
public class FlowActivity implements Serializable {
    private String id;
    private String title;
    private String type;    //one, xor, and
    private List<User> user;
    private String status;
    private Integer sort;
    private Flow flow;
    private Integer group;
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
    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @ManyToMany(fetch = FetchType.LAZY,cascade=CascadeType.ALL)
    @JoinTable(name = "xw_activity_user",
            joinColumns = {@JoinColumn(name = "activity_id",referencedColumnName="id")},
            inverseJoinColumns = {@JoinColumn(name = "user_id",referencedColumnName="id")}
    )
    public List<User> getUser() {
        return user;
    }

    public void setUser(List<User> user) {
        this.user = user;
    }



    @Column(name = "thestatus")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "sort")
    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }



    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="flow_id")
    public Flow getFlow() {
        return flow;
    }

    public void setFlow(Flow flow) {
        this.flow = flow;
    }
    @Column(name = "group_name")
    public Integer getGroup() {
        return group;
    }

    public void setGroup(Integer group) {
        this.group = group;
    }
}

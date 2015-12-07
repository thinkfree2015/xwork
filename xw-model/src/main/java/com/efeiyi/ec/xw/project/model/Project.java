package com.efeiyi.ec.xw.project.model;


import com.efeiyi.ec.xw.organization.model.User;
import org.hibernate.annotations.GenericGenerator;
import java.io.Serializable;
import java.util.List;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.Where;

/**
 * Created by Administrator on 2015/12/1.
 *
 */
@Entity
@Table(name = "xw_project")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class Project implements Serializable {
    private String id;
    private List<User> memberList;
    private String title;
    private String context;//项目简介

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

    @OneToMany
    @JoinTable(name = "xw_project_user",
            joinColumns = {@JoinColumn(name = "project_id",referencedColumnName="id")},
            inverseJoinColumns = {@JoinColumn(name = "user_id",referencedColumnName="id")}
            )
    public List<User> getMemberList() {
        return memberList;
    }

    public void setMemberList(List<User> memberList) {
        this.memberList = memberList;
    }

    @Column(name = "context")
    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }
}

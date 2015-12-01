package com.efeiyi.ec.xw.project.model;


import com.efeiyi.ec.xw.organization.model.User;
import org.hibernate.annotations.GenericGenerator;
import java.io.Serializable;
import java.util.List;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
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

    @ManyToMany(fetch = FetchType.LAZY, mappedBy = "projects", cascade = CascadeType.ALL)
    public List getMemberList() {
        return memberList;
    }

    public void setMemberList(List memberList) {
        this.memberList = memberList;
    }

}

package com.efeiyi.ec.xw.task.model;

import com.efeiyi.ec.xw.organization.model.User;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2015/12/1.
 *
 */
public class TaskActivityInstance {
    private String id;
    private String issue;
    private String status;   //未处理    正在处理      搁置    已完成   已放弃
    private String content;
    private User excutor;
    private Date createDatetime;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @Column(name="issue")
    public String getIssue() {
        return issue;
    }

    public void setIssue(String issue) {
        this.issue = issue;
    }
    @Column(name="thestatus")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    @Column(name="content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "excutor", cascade = CascadeType.ALL)
    public User getExcutor() {
        return excutor;
    }

    public void setExcutor(User excutor) {
        this.excutor = excutor;
    }
    @Column(name="createDatetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }
}

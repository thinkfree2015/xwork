package com.efeiyi.ec.xw.task.model;

import com.efeiyi.ec.xw.organization.model.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by Administrator on 2015/12/1.
 *
 */
@Entity
@Table(name = "xw_task_activity_instance")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class TaskActivityInstance implements Serializable {
    private String id;
    private String issue;
    private TaskActivityInstance fatherTaskActivityInstance;
    private String status;   //未处理    正在处理      搁置    已完成   已放弃
    private String content;
    private User excutor;
    private Date createDatetime;
    private Task task;

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
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "excutor_id")
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
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="task_id")
    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="fatherTaskActivityInstance_id")
    public TaskActivityInstance getFatherTaskActivityInstance() {
        return fatherTaskActivityInstance;
    }

    public void setFatherTaskActivityInstance(TaskActivityInstance fatherTaskActivityInstance) {
        this.fatherTaskActivityInstance = fatherTaskActivityInstance;
    }
}

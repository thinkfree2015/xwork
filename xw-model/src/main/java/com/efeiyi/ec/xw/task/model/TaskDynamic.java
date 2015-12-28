package com.efeiyi.ec.xw.task.model;

import com.efeiyi.ec.xw.flow.model.Flow;
import com.efeiyi.ec.xw.organization.model.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/12/1.
 *
 */
@Entity
@Table(name = "xw_task_dynamic")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class TaskDynamic implements Serializable {
    private String id;
    private Task task;
    private TaskActivityInstance taskActivityInstance;
    private String message;
    private User creator;
    private Date createDatetime;
    private String taskTitle;
    private String taskId;
    private String projectId;

    @Transient
    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    @Transient
    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    @Transient
    public String getTaskTitle() {
        return taskTitle;
    }

    public void setTaskTitle(String taskTitle) {
        this.taskTitle = taskTitle;
    }

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @JsonIgnore
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
    @JoinColumn(name="task_activity_instance_id")
    public TaskActivityInstance getTaskActivityInstance() {
        return taskActivityInstance;
    }

    public void setTaskActivityInstance(TaskActivityInstance taskActivityInstance) {
        this.taskActivityInstance = taskActivityInstance;
    }

    @Column(name = "message")
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }
}

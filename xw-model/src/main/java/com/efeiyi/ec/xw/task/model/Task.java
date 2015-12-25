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
@Table(name = "xw_task")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class Task implements Serializable {
    private String id;
    private String title;
    private TaskGroup taskGroup;
    private String content;
    private User currentUser;
    private List<TaskActivityInstance> taskActivityList;
    private List<User> UsernotifyUserList;//   发起者/管理者
    private List<TaskAttachment> taskAttachmentList;
    private List<TaskNote> taskNoteList;//评论及回复
    private List<TaskDynamic> taskDynamicList;//动态
    private Flow flow;
    private User author;
    private Date createDatetime;
    private TaskActivityInstance currentInstance;

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
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="task_group_id")
    public TaskGroup getTaskGroup() {
        return taskGroup;
    }

    public void setTaskGroup(TaskGroup taskGroup) {
        this.taskGroup = taskGroup;
    }
    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    public User getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser;
    }
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "task", cascade = CascadeType.ALL)
    public List<TaskActivityInstance> getTaskActivityList() {
        return taskActivityList;
    }

    public void setTaskActivityList(List<TaskActivityInstance> taskActivityList) {
        this.taskActivityList = taskActivityList;
    }

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinColumn(name="notify_userId")
    public List<User> getUsernotifyUserList() {
        return UsernotifyUserList;
    }

    public void setUsernotifyUserList(List<User> usernotifyUserList) {
        UsernotifyUserList = usernotifyUserList;
    }
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "task", cascade = CascadeType.ALL)
    public List<TaskAttachment> getTaskAttachmentList() {
        return taskAttachmentList;
    }

    public void setTaskAttachmentList(List<TaskAttachment> taskAttachmentList) {
        this.taskAttachmentList = taskAttachmentList;
    }

    @OneToOne(optional = true, cascade = CascadeType.ALL)
    @JoinColumn(name="flow_id")
    public Flow getFlow() {
        return flow;
    }

    public void setFlow(Flow flow) {
        this.flow = flow;
    }
    @Column(name = "author_id")
    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }
    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "task", cascade = CascadeType.ALL)
    public List<TaskDynamic> getTaskDynamicList() {
        return taskDynamicList;
    }

    public void setTaskDynamicList(List<TaskDynamic> taskDynamicList) {
        this.taskDynamicList = taskDynamicList;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "task", cascade = CascadeType.ALL)
    public List<TaskNote> getTaskNoteList() {
        return taskNoteList;
    }

    public void setTaskNoteList(List<TaskNote> taskNoteList) {
        this.taskNoteList = taskNoteList;
    }

    @JsonIgnore
    @Transient
    public TaskActivityInstance getCurrentInstance(){
        if(taskActivityList!=null) {
            for (TaskActivityInstance taskActivityInstance : taskActivityList) {
                if (taskActivityInstance.getActivate().equals("1")) {
                    currentInstance = taskActivityInstance;
                    break;
                }
            }
        }
        return  currentInstance;
    }

    public void setCurrentInstance(TaskActivityInstance currentInstance) {


        this.currentInstance = currentInstance;
    }
}
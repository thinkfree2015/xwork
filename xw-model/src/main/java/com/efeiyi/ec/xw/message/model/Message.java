package com.efeiyi.ec.xw.message.model;

import com.efeiyi.ec.xw.organization.model.User;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/12/24.
 *
 */
@Entity
@Table(name = "xw_message")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class Message implements Serializable {
    private String id;
    private String type;//1.text 2.图片 3.文件
    private String content;//消息内容
    private User creator;//消息触发者
    private Date createDatetime;//发送时间
    private String status;//1.未读 2.已读
    private List<User> receiver;//消息收发者

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="creater_id")
    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }
    @Column(name = "createDatetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }
    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY)
    @JoinColumn(name="receiver_id")
    public List<User> getReceiver() {
        return receiver;
    }

    public void setReceiver(List<User> receiver) {
        this.receiver = receiver;
    }
}

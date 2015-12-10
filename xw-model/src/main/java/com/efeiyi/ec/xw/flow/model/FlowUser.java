package com.efeiyi.ec.xw.flow.model;


import com.efeiyi.ec.xw.organization.model.User;
import com.efeiyi.ec.xw.project.model.Project;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2015/12/1.
 *
 */
@Entity
@Table(name = "xw_flow_user")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class FlowUser implements Serializable {
    private User user;
    private Flow flow;


    @EmbeddedId
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", unique = true, nullable = false)
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    @EmbeddedId
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name ="flow_id")

    public Flow getFlow() {
        return flow;
    }

    public void setFlow(Flow flow) {
        this.flow = flow;
    }
}

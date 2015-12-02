package com.efeiyi.ec.xw.organization.model;

/**
 * Created by Administrator on 2015/12/1.
 */

import com.efeiyi.ec.xw.flow.model.FlowActivity;
import com.efeiyi.ec.xw.project.model.Project;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
@Entity
@Table(name = "xw_user")
public class User implements Serializable {

    private String id;
    private String username;
    private String name;
    private String password;
    private Role role;
    private String status;
    private FlowActivity flowActivity;



    @JsonIgnore
    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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


    @Column(name = "username")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }


    @Column(name = "truename")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public int hashCode() {
        int result = 0;
        if(id!=null) {
            result  = id.hashCode();
            result = 31 * result;
            if (username != null) {
                result += username.hashCode();
            }
        }
        return result;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id")
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="flow_activity_id")
    public FlowActivity getFlowActivity() {
        return flowActivity;
    }

    public void setFlowActivity(FlowActivity flowActivity) {
        this.flowActivity = flowActivity;
    }
}

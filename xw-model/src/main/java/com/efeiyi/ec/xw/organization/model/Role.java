package com.efeiyi.ec.xw.organization.model;

import org.hibernate.annotations.GenericGenerator;

import java.io.Serializable;

import javax.persistence.*;
import java.util.List;
/**
 * Created by Administrator on 2015/12/1.
 */
@Entity
@Table(name = "xw_role")
public class Role implements Serializable {
    private String id;
    private String name;
    private String cname;
    private String basicType;
    private String status;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "basic_type")
    public String getBasicType() {
        return basicType;
    }

    public void setBasicType(String basicType) {
        this.basicType = basicType;
    }



    @Column(name = "status")
    public String  getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }




    @Column(name = "c_name")
    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }
}
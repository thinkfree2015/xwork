package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.organization.model.Consumer;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/8/10.
 */
@Entity
@Table(name = "purchase_coupon")
public class Coupon {
    private String id;
    private String serial;
    private CouponBatch couponBatch;//批次
    private String status;//1未使用 2已使用
    private Consumer consumer;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "coupon_batch_id")
    public CouponBatch getCouponBatch() {
        return couponBatch;
    }

    public void setCouponBatch(CouponBatch couponBatch) {
        this.couponBatch = couponBatch;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consumer_id")
    public Consumer getConsumer() {
        return consumer;
    }

    public void setConsumer(Consumer consumer) {
        this.consumer = consumer;
    }
}

package com.efeiyi.ec.system.couponBatch.controller;

import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AutoSerialManager;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("/couponBatch")
public class CouponBatchController extends BaseController {

    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AutoSerialManager autoSerialManager;

    @RequestMapping("/createCoupon.do")
    @ResponseBody
    public String createCoupon(String id,int amount){
        Coupon coupon = null;
        CouponBatch couponBatch = (CouponBatch) super.baseManager.getObject("com.efeiyi.ec.purchase.model.CouponBatch",id);
        for (int i = 0;i < amount;i++){
            coupon = new Coupon();
            coupon.setStatus("1");
            coupon.setCouponBatch(couponBatch);
            String serial = RandomStringUtils.randomNumeric(10);
            coupon.setSerial(serial);
            baseManager.saveOrUpdate(Coupon.class.getName(),coupon);
        }

        couponBatch.setIsCreatedCoupon(2);
        baseManager.saveOrUpdate(CouponBatch.class.getName(),couponBatch);
        return  id;
    }

    @RequestMapping("/saveAndCreateCoupon.do")
    public String saveAndCreateCoupon(HttpServletRequest request) throws Exception {

        CouponBatch couponBatch = new CouponBatch();
        couponBatch.setName(request.getParameter("name"));
        couponBatch.setAmount(Integer.parseInt(request.getParameter("amount")));
        couponBatch.setPrice(Float.parseFloat(request.getParameter("price")));
        couponBatch.setPriceLimit(Float.parseFloat(request.getParameter("priceLimit")));
        couponBatch.setStatus("1");

        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
        try {
            couponBatch.setStartDate(sd.parse(request.getParameter("startDate")));
            couponBatch.setEndDate(sd.parse(request.getParameter("endDate")));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        couponBatch.setIsCreatedCoupon(2);

        baseManager.saveOrUpdate(CouponBatch.class.getName(), couponBatch);

        Coupon coupon = null;
        for(int i = 0;i < couponBatch.getAmount();i++){
            coupon = new Coupon();
            coupon.setStatus("1");
            coupon.setCouponBatch(couponBatch);
//            String serial = RandomStringUtils.randomNumeric(10);
            String serial = autoSerialManager.nextSerial("systemAutoSerial");
            coupon.setSerial(serial);
            baseManager.saveOrUpdate(Coupon.class.getName(),coupon);
        }
        return "redirect:/basic/xm.do?qm=plistCouponBatch_default&view=Batch";
    }

    @RequestMapping("/getAllProjectCategory.do")
    @ResponseBody
    public List<Object> getAllProjectCategory(Model model,HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listProjectCategory_default",request);
        List<Object> list = baseManager.listObject(xQuery);
        return list;
    }

    @RequestMapping("/getAllProject.do")
    @ResponseBody
    public List<Object> getAllProject(Model model,HttpServletRequest request) throws Exception {
        String id = request.getParameter("projectCategory_id");
        XQuery xQuery = new XQuery("listProject_default",request);
        xQuery.put("projectCategory_id",id);
        List<Object> list = baseManager.listObject(xQuery);
        return list;
    }
    @RequestMapping("/getTenantByProject.do")
    @ResponseBody
    public List<Object> getTenantByProject(Model model,HttpServletRequest request) throws Exception {
        String id = request.getParameter("project_id");
        XQuery xQuery = new XQuery("listTenantProject_default3",request);
        xQuery.put("project_id",id);
        List<Object> list = baseManager.listObject(xQuery);
        return list;
    }
    @RequestMapping("/getProductByProject.do")
    @ResponseBody
    public List<Object> getProductByProject(Model model,HttpServletRequest request) throws Exception {
        String id = request.getParameter("project_id");
        XQuery xQuery = new XQuery("listProduct_default",request);
        xQuery.put("project_id",id);
        List<Object> list = baseManager.listObject(xQuery);
        return list;
    }

}

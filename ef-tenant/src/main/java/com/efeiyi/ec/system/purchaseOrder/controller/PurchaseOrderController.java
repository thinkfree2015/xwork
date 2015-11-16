package com.efeiyi.ec.system.purchaseOrder.controller;



import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderDelivery;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.system.purchaseOrder.service.PurchaseOrderManager;
import com.efeiyi.ec.system.purchaseOrder.service.SmsCheckManager;
import com.efeiyi.ec.system.util.HTTPParam;
import com.efeiyi.ec.system.util.HTTPSend;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/purchaseOrder")
public class PurchaseOrderController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private  PurchaseOrderManager purchaseOrderManager;

    @Autowired
    private SmsCheckManager smsCheckManager;

    @Autowired
    private HTTPSend httpSend;

    /**
     * 发货
     * ,PurchaseOrderDelivery purchaseOrderDelivery,Authentication authentication
     * @param purchaseOrder
     * @return
     */
    @RequestMapping("/updateOrderStatus.do")
    @ResponseBody
    public String updateOrderStatus(PurchaseOrder purchaseOrder,HttpServletRequest request){

        final String innerPurchaseOrderId = purchaseOrder.getId();
        String logisticsCompany = request.getParameter("logisticsCompany");
        String serial = request.getParameter("serial");
        String id = "";
        purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),purchaseOrder.getId());
        try {
            if(null == purchaseOrder.getFatherPurchaseOrder()){
                purchaseOrder.setOrderStatus("7");
                id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
                List<PurchaseOrder> subPurchaseOrderList = purchaseOrder.getSubPurchaseOrder();
                if(null != subPurchaseOrderList && subPurchaseOrderList.size() > 0){
                    PurchaseOrder p1 = null;
                    for(int i = 0;i < subPurchaseOrderList.size();i++){
                        p1 = subPurchaseOrderList.get(i);
                        if("1".equals(p1.getOrderStatus()) || "5".equals(p1.getOrderStatus())){
                            p1.setOrderStatus("7");
                            purchaseOrderManager.updateOrderStatus(p1);
                        }
                    }
                }

                StringBuffer url = request.getRequestURL();
                final String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
                //启动一个定时器，发货七天用户没有点击收货的话，自动改为已收货
                final Timer timer = new Timer();
                timer.schedule(new TimerTask() {
                    @Override
                    public void run() {
                        List<HTTPParam> params = new ArrayList<HTTPParam>();
                        HTTPParam httpParam = new HTTPParam();
                        httpParam.setKey("innerPurchaseOrderId");
                        httpParam.setValue(innerPurchaseOrderId);
                        HTTPParam httpParam1 = new HTTPParam();
                        httpParam1.setKey("purchaseOrderType");
                        httpParam1.setValue("1");//如果是父订单的话类型是1
                        params.add(httpParam);
                        params.add(httpParam1);

                        try {
                            httpSend.sendPost(tempContextUrl+"purchaseOrder/autoReceive.do",params);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        timer.cancel();//停止定时器
                    }
                }, 7*24*60*60*1000);
            }else{
                PurchaseOrder fPurchaseOrder = purchaseOrder.getFatherPurchaseOrder();
                List<PurchaseOrder> subPurchaseOrderList = fPurchaseOrder.getSubPurchaseOrder();
                PurchaseOrder p = null;
                for (int i = 0;i < subPurchaseOrderList.size();i++){
                    p = subPurchaseOrderList.get(i);

                    if(p.getId().equals(purchaseOrder.getId())){//在子订单列表中找到自己
                        if (i == subPurchaseOrderList.size()-1){//如果自己是最后一个并且前面的子订单都是已发货的，修改父订单状态，修改自己状态
                            fPurchaseOrder.setOrderStatus("7");
                            purchaseOrderManager.updateOrderStatus(fPurchaseOrder);
                            purchaseOrder.setOrderStatus("7");
                            id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
                            break;
                        }else {//如果自己不在列表的最后一个
                            continue;
                        }
                    }

                    if("1".equals(p.getOrderStatus()) || "5".equals(p.getOrderStatus())){//如果有未发货的就修改自己 然后跳出循环
                        if(i == subPurchaseOrderList.size()-1){//如果循环到了最后一个 并且最后一个不是自己并且前面没有未发货的
                            fPurchaseOrder.setOrderStatus("7");
                            purchaseOrderManager.updateOrderStatus(fPurchaseOrder);
                            purchaseOrder.setOrderStatus("7");
                            id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
                            p.setOrderStatus("7");
                            purchaseOrderManager.updateOrderStatus(p);
                        }else{//如果有未发货的并且不是列表的最后一个 修改自己状态 跳出循环
                            purchaseOrder.setOrderStatus("7");
                            id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
                        }
                        break;
                    }
                    if(i == subPurchaseOrderList.size()-1){//如果循环到了最后一个 并且最后一个不是自己并且前面没有未发货的
                        fPurchaseOrder.setOrderStatus("7");
                        purchaseOrderManager.updateOrderStatus(fPurchaseOrder);
                        purchaseOrder.setOrderStatus("7");
                        id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
                    }

                }

                StringBuffer url = request.getRequestURL();
                final String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
                //启动一个定时器，发货七天用户没有点击收货的话，自动改为已收货
                final Timer timer = new Timer();
                timer.schedule(new TimerTask() {
                    @Override
                    public void run() {

                        List<HTTPParam> params = new ArrayList<HTTPParam>();
                        HTTPParam httpParam = new HTTPParam();
                        httpParam.setKey("innerPurchaseOrderId");
                        httpParam.setValue(innerPurchaseOrderId);
                        HTTPParam httpParam1 = new HTTPParam();
                        httpParam1.setKey("purchaseOrderType");
                        httpParam1.setValue("2");//如果是子订单的话类型是2
                        params.add(httpParam);
                        params.add(httpParam1);

                        try {
                            httpSend.sendPost(tempContextUrl+"purchaseOrder/autoReceive.do",params);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                        timer.cancel();//停止定时器
                    }
                },  7*24*60*60*1000);

            }


            //发送短信提示发货 短信中提示的订单都是父订单的订单号
            String sysOrder = null;
            if(null == purchaseOrder.getFatherPurchaseOrder()){
                sysOrder = purchaseOrder.getSerial();
            }else{
                sysOrder = purchaseOrder.getFatherPurchaseOrder().getSerial();
            }
            String logisticsCompanyZHCN = request.getParameter("logisticsCompanyZHCN");
            this.smsCheckManager.send(purchaseOrder.getUser().getUsername(), "#purchaseOrderSerial#="+sysOrder+"&#LogisticsCompany#="+logisticsCompanyZHCN+"&#serial#="+serial, "1035759", PConst.TIANYI);

        }catch (Exception e){
            e.printStackTrace();
        }

        return  id;
    }


    @RequestMapping("/autoReceive.do")
    @ResponseBody
    public void autoReceive(HttpServletRequest request){
        String innerPurchaseOrderId = request.getParameter("innerPurchaseOrderId");
        String type = request.getParameter("purchaseOrderType");
        if("1".equals(type)){//如果传进来的是父订单
            PurchaseOrder purchaseOrderTemp = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),innerPurchaseOrderId);
            String orderStatus = purchaseOrderTemp.getOrderStatus();
            if ("7".equals(orderStatus)) {
                purchaseOrderTemp.setOrderStatus("9");
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrderTemp);
            }
            List<PurchaseOrder> subPurchaseOrderList = purchaseOrderTemp.getSubPurchaseOrder();
            if(null != subPurchaseOrderList && subPurchaseOrderList.size() > 0){
                PurchaseOrder p1 = null;
                for(int i = 0;i < subPurchaseOrderList.size();i++){
                    p1 = subPurchaseOrderList.get(i);
                    if("7".equals(p1.getOrderStatus())){
                        p1.setOrderStatus("9");
                        baseManager.saveOrUpdate(PurchaseOrder.class.getName(),p1);
                    }
                }
            }
        }else if("2".equals(type)){//如果传进来的是子订单
            System.out.print("子订单");
            PurchaseOrder purchaseOrderTemp = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),innerPurchaseOrderId);
            String orderStatus = purchaseOrderTemp.getOrderStatus();
            if ("7".equals(orderStatus)) {
                purchaseOrderTemp.setOrderStatus("9");
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
                PurchaseOrder fPurchaseOrder = purchaseOrderTemp.getFatherPurchaseOrder();
                List<PurchaseOrder> subPurchaseOrderList = fPurchaseOrder.getSubPurchaseOrder();
                for (int k = 0; k < subPurchaseOrderList.size(); k++) {
                    PurchaseOrder itPurchaseOrder = subPurchaseOrderList.get(k);
                    if (k == 0 && itPurchaseOrder.getId().equals(purchaseOrderTemp.getId())) {//列表的第一个是自己
                        continue;
                    } else if (k == subPurchaseOrderList.size() - 1 && itPurchaseOrder.getId().equals(purchaseOrderTemp.getId())) {//列表中最后一个是自己
                        fPurchaseOrder.setOrderStatus("9");
                        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), fPurchaseOrder);
                    } else if (itPurchaseOrder.getId().equals(purchaseOrderTemp.getId())) {
                        continue;
                    } else {
                        if ("7".equals(itPurchaseOrder.getOrderStatus()) || "5".equals(itPurchaseOrder.getOrderStatus())) {
                            break;
                        }
                        if ("9".equals(itPurchaseOrder.getOrderStatus()) && k == subPurchaseOrderList.size() - 1) {
                            fPurchaseOrder.setOrderStatus("9");
                            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), fPurchaseOrder);
                        }
                    }
                }
            }
        }
    }


}

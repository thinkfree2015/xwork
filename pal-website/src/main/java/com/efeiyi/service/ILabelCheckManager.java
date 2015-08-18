package com.efeiyi.service;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.product.model.Product;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by Administrator on 2015/8/7.
 */
public interface ILabelCheckManager {

     Label getUniqueLabel(String labelId);

     Product getUniqueProduct(String productId);

     String constructWeiXinMsg(String toUserName, String fromUserName, String content, String url);

     void updateRecord(ModelMap model, Label label) throws Exception ;

     String treatWeiXinMsg(HttpServletRequest request, String inXml)  throws IOException;
}

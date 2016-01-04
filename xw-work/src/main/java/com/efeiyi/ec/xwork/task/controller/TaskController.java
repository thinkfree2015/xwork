package com.efeiyi.ec.xwork.task.controller;

import com.efeiyi.ec.xw.task.model.Task;
import com.efeiyi.ec.xw.task.model.TaskNote;
import com.efeiyi.ec.xwork.organization.util.AuthorizationUtil;
import com.efeiyi.ec.xwork.task.service.TaskManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/task")
public class TaskController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private TaskManager taskManager;


    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    /**
     * 改变实例状态
     */

    @RequestMapping("/changeTaskStatus")
    @ResponseBody
    public  Map<String,List> changeTaskStatus(String taskId,String status){
        Task task = null;
        Map<String,List> map = new HashMap<>();
        try {
            task = taskManager.changeTaskInstanceStatus(taskId,"4");
            map.put("users",task.getCurrentInstance().getFlowActivity().getUser());

        }catch (Exception e){

        }
        return map;
    }

    @RequestMapping("/img.do")
    @ResponseBody
    public String img(HttpServletRequest request){
        System.out.print("ok");
        String data = "";

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        // String ctxPath = request.getSession().getServletContext().getRealPath("/")+ File.separator+"uploadFiles";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "";
        String fname = "";
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {

            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            if(fileName.indexOf(".")==-1){
                url = "taskPicture/jietu"+identify+".jpg";
            }else {
                String hz = fileName.substring(fileName.indexOf("."), fileName.length());
                String imgName = fileName.substring(0, fileName.indexOf(hz));
                url = "taskPicture/" + fileName.substring(0, fileName.indexOf(hz)) + identify + hz;
            }

          try {
                    aliOssUploadManager.uploadFile(mf, "ec-efeiyi", url);
//                 data += "\"name\":\""+imgName+"\",\"originalName\",\""+fileName+"\",\"size\":"+mf.getSize()+",\"status\":\"SUCCESS\",\"type\":\""+hz+"\",\"url\":\""+url+"\"}";
              data = "{\"success\":\"" + true + "\",\"file_path\":\"http://pro.efeiyi.com/" +url + "\"}";
          } catch (Exception e) {
                    e.printStackTrace();
                }
            }
//        data = data.substring(1,data.lastIndexOf("\""));

        return  data;
    }

    @RequestMapping("/removeTask.do")
    @ResponseBody
    public String removeTask(String taskId){
        try{
          taskManager.removeTask(taskId);
        }catch(Exception e){
          e.printStackTrace();
        }
    return taskId;
    }

    @RequestMapping("/editTask.do")
    @ResponseBody
    public String editTask(String taskId,String title){
        try{
            Task task = (Task)baseManager.getObject(Task.class.getName(),taskId);
            task.setTitle(title);
            baseManager.saveOrUpdate(Task.class.getName(),task);
        }catch(Exception e){
            e.printStackTrace();
        }
        return taskId;
    }

    @RequestMapping("/saveNote.do")
    @ResponseBody
    public TaskNote saveNote(String taskId,String content){
        TaskNote taskNote = new TaskNote();
        try{
            Task task = (Task)baseManager.getObject(Task.class.getName(),taskId);
            taskNote.setContent(content);
            taskNote.setCreateDatetime(new Date());
            taskNote.setCreator(AuthorizationUtil.getUser());
            taskNote.setTask(task);
            baseManager.saveOrUpdate(TaskNote.class.getName(),taskNote);
        }catch(Exception e){
            e.printStackTrace();
        }
        return taskNote;
    }


}

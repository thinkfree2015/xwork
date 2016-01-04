package com.efeiyi.ec.xwork.task.dao.hibernate;

import com.efeiyi.ec.xw.task.model.TaskActivityInstanceExecution;
import com.efeiyi.ec.xwork.task.dao.TaskDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TaskDaoHibernate   implements TaskDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() {
        return this.sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public Session getSession() {
        //事务必须是开启的(Required)，否则获取不到
        return sessionFactory.getCurrentSession();
    }


    //根据任务实例 获取 任务 问题
    @Override
   public TaskActivityInstanceExecution getTaskActivityInstanceExecution(String taskInstanceId){
       String sql = "from TaskActivityInstanceExecution where 1=1 and taskActivityInstance.id=:taskInstanceId";
       Query query = getSession().createQuery(sql).setString("taskInstanceId",taskInstanceId);
       List<TaskActivityInstanceExecution> taskActivityInstanceExecutionList = query.list();
       if(taskActivityInstanceExecutionList!=null){
           return taskActivityInstanceExecutionList.get(0);
       }else {
           return  null;
       }
   }

}

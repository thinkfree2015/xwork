package com.efeiyi.ec.xwork.project.dao.hibernate;

import com.efeiyi.ec.xw.project.model.ProjectUser;
import com.efeiyi.ec.xwork.project.dao.XWorkProjectDao;
import com.efeiyi.ec.xwork.project.dao.projectDao;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProjectDaoHibernate implements XWorkProjectDao {

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

    @Override
    public List projectPList(){
        String sql = "from Project where 1=1";
        List<ProjectUser> projectList = getSession().createQuery(sql).list();
        return  projectList;
    }

}

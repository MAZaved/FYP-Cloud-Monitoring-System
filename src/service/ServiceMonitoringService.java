package service;


import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
 
import database.HibernateUtil;
import model.ServiceMonitoring;

/**
 * 
 * @author Michael Mullarkey - 112457292
 *
 */
public class ServiceMonitoringService {
     
	/**
	 * Method for registering service monitor
	 * @param servicemonitoring
	 * @return
	 */
	public boolean registerService(ServiceMonitoring servicemonitoring){
		
	     Session session = HibernateUtil.openSession();
	     
	     if(isServiceExists(servicemonitoring))return false; 
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.save(servicemonitoring);       
	         tx.commit();
	     } catch (Exception e) {
	         if (tx != null) {
	             tx.rollback();
	         }
	         e.printStackTrace();
	     } finally {
	         session.close();
	     } 
	     return true;
	}
	
	/**
	 * Method for updating service monitor
	 * @param servicemonitoring
	 * @return
	 */
	public boolean updateService(ServiceMonitoring servicemonitoring){
		
	     Session session = HibernateUtil.openSession();
	     
	     
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.update(servicemonitoring);       
	         tx.commit();
	     } catch (Exception e) {
	         if (tx != null) {
	             tx.rollback();
	         }
	         e.printStackTrace();
	     } finally {
	         session.close();
	     } 
	     return true;
	}
	
	/**
	 * Method for removing service monitor
	 * @param servicemonitoring
	 * @return
	 */
	public boolean removeService(ServiceMonitoring servicemonitoring){
		
	     Session session = HibernateUtil.openSession();

	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.delete(servicemonitoring);       
	         tx.commit();
	     } catch (Exception e) {
	         if (tx != null) {
	             tx.rollback();
	         }
	         e.printStackTrace();
	     } finally {
	         session.close();
	     } 
	     return true;
	}
	
	/**
	 * Method for checking if service monitor exists
	 * @param servicemonitoring
	 * @return
	 */
	public boolean isServiceExists(ServiceMonitoring servicemonitoring){
		
	     Session session = HibernateUtil.openSession();
	     boolean result = false;
	     Transaction tx = null;
	     try{
	         tx = session.getTransaction();
	         tx.begin();
	         Query query = session.createQuery("from ServiceMonitoring where host='"+servicemonitoring.getHost()+"'");
	         ServiceMonitoring u = (ServiceMonitoring)query.uniqueResult();
	         tx.commit();
	         if(u!=null) result = true;
	     }catch(Exception ex){
	         if(tx!=null){
	             tx.rollback();
	         }
	     }finally{
	         session.close();
	     }
	     return result;
	}
	
	/**
	 * Method for getting a list of all service mointors
	 * @return
	 */
	public List<ServiceMonitoring> getListOfServices(){
		
        List<ServiceMonitoring> list = new ArrayList<ServiceMonitoring>();
        Session session = HibernateUtil.openSession();
        Transaction tx = null;       
        try {
            tx = session.getTransaction();
            tx.begin();
            list = session.createQuery("from ServiceMonitoring").list();                       
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }
}
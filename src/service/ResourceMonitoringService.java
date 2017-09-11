package service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import database.HibernateUtil;
import model.ResourceMonitoring;
import model.ServiceMonitoring;
/**
 * 
 * @author Michael Mullarkey - 112457292
 *
 */
public class ResourceMonitoringService {
	
	/**
	 * Method for registering resource monitor
	 * @param resourcemonitoring
	 * @return
	 */
	public boolean registerService(ResourceMonitoring resourcemonitoring){
		
	     Session session = HibernateUtil.openSession();
	     if(isServiceExists(resourcemonitoring)) return false;  
	     
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.saveOrUpdate(resourcemonitoring);       
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
	 * Method for updating resource monitor
	 * @param resourcemonitoring
	 * @return
	 */
	public boolean updateResource(ResourceMonitoring resourcemonitoring){
		
	     Session session = HibernateUtil.openSession();
	     
	     
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.update(resourcemonitoring);       
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
	 * Method for removing resource monitor
	 * @param resourcemonitoring
	 * @return
	 */
	public boolean removeResource(ResourceMonitoring resourcemonitoring){
		
	     Session session = HibernateUtil.openSession();

	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.delete(resourcemonitoring);       
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
	 * Method for checking if resource monitor exists
	 * @param resourcemonitoring
	 * @return
	 */
	public boolean isServiceExists(ResourceMonitoring resourcemonitoring){
		
	     Session session = HibernateUtil.openSession();
	     boolean result = false;
	     Transaction tx = null;
	     try{
	         tx = session.getTransaction();
	         tx.begin();
	         Query query = session.createQuery("from ResourceMonitoring where host='"+resourcemonitoring.getHost()+"'");
	         ResourceMonitoring u = (ResourceMonitoring)query.uniqueResult();
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
	 * Method for getting a list of resource monitors
	 * @return
	 */
	public List<ResourceMonitoring> getListOfServices(){
		
       List<ResourceMonitoring> list = new ArrayList<ResourceMonitoring>();
       Session session = HibernateUtil.openSession();
       Transaction tx = null;       
       try {
           tx = session.getTransaction();
           tx.begin();
           list = session.createQuery("from ResourceMonitoring").list();                       
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

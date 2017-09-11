package service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import database.HibernateUtil;
import model.Alert;
/**
 * 
 * @author Michael Mullarkey - 112457292
 *
 */
public class AlertService {
	
	/**
	 * Method for registering alert
	 * @param alert - the alert object
	 * @return
	 */
	public boolean registerService(Alert alert){
		
	     Session session = HibernateUtil.openSession();
	     if(isServiceExists(alert)) return false;  
	     
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.saveOrUpdate(alert);       
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
	 * Method which updates alert
	 * @param alert - alert object
	 * @return
	 */
	public boolean updateAlert(Alert alert){
	     Session session = HibernateUtil.openSession();
	          
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.update(alert);       
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
	 * Method to remove alert
	 * @param alert
	 * @return
	 */
	public boolean removeAlert(Alert alert){
		
	     Session session = HibernateUtil.openSession();

	     Transaction tx = null;
	     try {
	    	 
	         tx = session.getTransaction();
	         tx.begin();
	         session.delete(alert);       
	         tx.commit();
	         
	     } catch (Exception e) {
	    	 
	         if (tx != null) 
	         {
	             tx.rollback();
	         }
	         
	         e.printStackTrace();
	     } finally {
	         session.close();
	     } 
	     return true;
	}

	/**
	 * Checks if an alert exist
	 * @param alert
	 * @return
	 */
	public boolean isServiceExists(Alert alert){
		
	     Session session = HibernateUtil.openSession();
	     boolean result = false;
	     Transaction tx = null;
	     try{
	    	 
	         tx = session.getTransaction();
	         tx.begin();
	         Query query = session.createQuery("from Alert where metricName='"+alert.getAlertName()+"'");
	         Alert u = (Alert)query.uniqueResult();
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
	 * Method for returning a list of all alerts
	 * @return
	 */
	public List<Alert> getListOfServices(){
		
    List<Alert> list = new ArrayList<Alert>();
    Session session = HibernateUtil.openSession();
    Transaction tx = null;       
    try {
        tx = session.getTransaction();
        tx.begin();
        list = session.createQuery("from Alert").list();                       
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

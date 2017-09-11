package service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import database.HibernateUtil;
import model.ResourceAgent;
import model.ResourceMonitoring;
/**
 * 
 * @author Michael Mullarkey - 112457292
 *
 */
public class ResourceAgentService {
	
	/**
	 * Method for registering resource agent
	 * @param resourceagent
	 * @return
	 */
	public boolean registerService(ResourceAgent resourceagent){
		
	     Session session = HibernateUtil.openSession();
	     if(isServiceExists(resourceagent)) return false;  
	     
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.saveOrUpdate(resourceagent);       
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
	 * Method for updating resource agent
	 * @param resourceagent
	 * @return
	 */
	public boolean updateAgent(ResourceAgent resourceagent){
		
	     Session session = HibernateUtil.openSession();
	     
	     
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.update(resourceagent);       
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
	 * Method for removing resource agent
	 * @param resourceagent
	 * @return
	 */
	public boolean removeAgent(ResourceAgent resourceagent){
		
	     Session session = HibernateUtil.openSession();

	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.delete(resourceagent);       
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
	 * Method for checking if resource agent exists
	 * @param resourceagent
	 * @return
	 */
	public boolean isServiceExists(ResourceAgent resourceagent){
		
	     Session session = HibernateUtil.openSession();
	     boolean result = false;
	     Transaction tx = null;
	     try{
	         tx = session.getTransaction();
	         tx.begin();
	         Query query = session.createQuery("from ResourceAgent where hostname='"+resourceagent.getHostname()+"'");
	         ResourceAgent u = (ResourceAgent)query.uniqueResult();
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
	 * Method to get list of all resource agents
	 * @return
	 */
	public List<ResourceAgent> getListOfServices(){
		
      List<ResourceAgent> list = new ArrayList<ResourceAgent>();
      Session session = HibernateUtil.openSession();
      Transaction tx = null;       
      try {
          tx = session.getTransaction();
          tx.begin();
          list = session.createQuery("from ResourceAgent").list();    
          System.out.println("ResourceAgent " + list);
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

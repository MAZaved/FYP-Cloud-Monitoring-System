package service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import database.HibernateUtil;
import model.ProxySettings;
import model.ResourceAgent;
/**
 * 
 * @author Michael Mullarkey - 112457292
 *
 */
public class ProxySettingsService {
	
	/**
	 * Method for registering proxy setting
	 * @param proxysettings - proxy setting object
	 * @return
	 */
	public boolean registerService(ProxySettings proxysettings){
		
	     Session session = HibernateUtil.openSession();
	     if(isServiceExists(proxysettings)) return false;  
	     
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.saveOrUpdate(proxysettings);       
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
	 * Method for updating proxy setting
	 * @param proxysettings
	 * @return
	 */
	public boolean updateProxy(ProxySettings proxysettings){
		
	     Session session = HibernateUtil.openSession();
	     
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.update(proxysettings);       
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
	 * Method for removing proxy setting
	 * @param proxysettings
	 * @return
	 */
	public boolean removeProxy(ProxySettings proxysettings){
		
	     Session session = HibernateUtil.openSession();

	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.delete(proxysettings);       
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
	 * Method for checking if proxy exists
	 * @param resourceagent
	 * @return
	 */
	public boolean isServiceExists(ProxySettings resourceagent){
		
	     Session session = HibernateUtil.openSession();
	     boolean result = false;
	     Transaction tx = null;
	     try{
	         tx = session.getTransaction();
	         tx.begin();
	         Query query = session.createQuery("from ProxySettings where url='"+resourceagent.getUrl()+"'");
	         ProxySettings u = (ProxySettings)query.uniqueResult();
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
	 * Method for getting a list of all proxy settings
	 * @return
	 */
	public List<ProxySettings> getListOfServices(){
		
     List<ProxySettings> list = new ArrayList<ProxySettings>();
     Session session = HibernateUtil.openSession();
     Transaction tx = null;       
     try {
         tx = session.getTransaction();
         tx.begin();
         list = session.createQuery("from ProxySettings").list();                       
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

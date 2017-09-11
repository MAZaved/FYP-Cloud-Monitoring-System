package service;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
 
import database.HibernateUtil;
import model.ResourceMonitoring;
import model.User;
/**
 * 
 * @author Michael Mullarkey - 112457292
 *
 */
public class RegisterService {
    
	/**
	 * Method of registering user
	 * @param user
	 * @return
	 */
	public boolean register(User user){
		
	     Session session = HibernateUtil.openSession();
	     if(isUserExists(user)) return false;  
	     
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.saveOrUpdate(user);       
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
	 * Method for updating user 
	 * @param user
	 * @return
	 */
	public boolean updateUser(User user){
		
	     Session session = HibernateUtil.openSession();
	     
	     
	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.update(user);       
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
	 * Method for removing user
	 * @param user
	 * @return
	 */
	public boolean removeUser(User user){
		
	     Session session = HibernateUtil.openSession();

	     Transaction tx = null;
	     try {
	         tx = session.getTransaction();
	         tx.begin();
	         session.delete(user);       
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
	 * Checks is a user exists
	 * @param user
	 * @return
	 */
	public boolean isUserExists(User user){
		
	     Session session = HibernateUtil.openSession();
	     boolean result = false;
	     Transaction tx = null;
	     try{
	         tx = session.getTransaction();
	         tx.begin();
	         Query query = session.createQuery("from User where username='"+user.getUsername()+"'");
	         User u = (User)query.uniqueResult();
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
}


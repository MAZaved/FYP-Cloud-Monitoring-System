package service;

import java.util.ArrayList;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
 
import database.HibernateUtil;
import model.User;
import model.Security;
/**
 * 
 * @author Michael Mullarkey - 112457292
 *
 */ 
public class LoginService {
 
	Security sec = new Security();
	/**
	 * Checks if user exists
	 * @param username
	 * @param password
	 * @return
	 */
    public boolean authenticateUser(String username, String password) {
        User user = getUserByUserId(username);         
        if(user!=null && user.getUsername().equals(username) && sec.SHA_256_SecurePassword(user.getPassword()).equals(sec.SHA_256_SecurePassword(password))){
            return true;
        }else{
            return false;
        }
    }
 
    /**
     * Gets the selected user
     * @param username
     * @return
     */
    public User getUserByUserId(String username) {
    	
        Session session = HibernateUtil.openSession();
        Transaction tx = null;
        User user = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            Query query = session.createQuery("from User where username='"+username+"'");
            user = (User)query.uniqueResult();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return user;
    }
     
    /**
     * Method to get a list of all users
     * @return list of users
     */
    public List<User> getListOfUsers(){
    	
        List<User> list = new ArrayList<User>();
        Session session = HibernateUtil.openSession();
        Transaction tx = null;       
        try {
            tx = session.getTransaction();
            tx.begin();
            list = session.createQuery("from User").list();                       
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



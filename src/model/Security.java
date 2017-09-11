package model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 
 * @author Michael Mullarkey
 *
 */
public class Security {
	
	
	String generatedPassword;
	
	/**
     * A method for hashing the users password
     * @param password takes in the users password
     * @return hashed password
     */
    public String SHA_256_SecurePassword(String password)
    {
		try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            //md.update(salt.getBytes());
            byte[] bytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< bytes.length ;i++)
            {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            generatedPassword = sb.toString();
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        return this.generatedPassword;
    }
    
}

package dk.movstream.web.persistence.dao;

import dk.movstream.web.domain.User;
import java.util.List;
/**
 * Interface for User DAO class
 * 
 * @author Martin Rohwedder
 * @since 16-03-2013
 * @version 1.0
 */
public interface UserDao {

    List<User> findAll();
    User findUserByUsername(String username);
    User findUserById(long id);
    void insertUser(User user);
    void removeUser(User user);
    
}

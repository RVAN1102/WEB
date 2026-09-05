package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface IUserDao {
    User findById(int id);
    void update(User user);
    User findByUsername(String username);
    User findByEmail(String email);
    void insert(User user);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
}
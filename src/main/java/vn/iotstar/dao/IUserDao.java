package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface IUserDao {
    User findById(int id);
    void update(User user);
    User findByUsername(String username);
}
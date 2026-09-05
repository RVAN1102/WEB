package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface IUserService {
    User findById(int id);
    void update(User user);
    User findByUsername(String username);
    User findByEmail(String email);
    void insert(User user);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
    User login(String username, String password);
}
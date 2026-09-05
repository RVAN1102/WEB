package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface IUserService {
    User findById(int id);
    void update(User user);
}
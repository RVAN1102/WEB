package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.entity.Category;

public class Test {
    public static void main(String[] args) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        
        Category cate = new Category();
        cate.setCategoryname("Dien Thoai");
        cate.setStatus(1);
        
        try {
            trans.begin();
            enma.persist(cate);
            trans.commit();
            System.out.println("Thành công tạo bảng và chèn dữ liệu JPA!");
        } catch (Exception e) {
            trans.rollback();
            e.printStackTrace();
        } finally {
            enma.close();
        }
    }
}
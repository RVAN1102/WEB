package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "users")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "username", length = 150)
    private String username;

    @Column(name = "password", length = 150)
    private String password;

    @Column(name = "fullname", columnDefinition = "nvarchar(150)")
    private String fullname;

    @Column(name = "phone", columnDefinition = "nvarchar(50)")
    private String phone;

    @Column(name = "images", columnDefinition = "nvarchar(500)")
    private String images;

    @Column(name = "roleid")
    private int roleid;
    
    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "status")
    private int status; // 0 = Chưa kích hoạt, 1 = Đã kích hoạt

    @Column(name = "code", length = 50)
    private String code; // Lưu mã xác thực OTP

    public User() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    public String getFullName() { return fullname; }
    public void setFullName(String fullName) { this.fullname = fullName; }

    public String getUserName() { return username; }
    public void setUserName(String userName) { this.username = userName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    public String getAvatar() { return images; }
    public void setAvatar(String avatar) { this.images = avatar; }

    public int getRoleid() { return roleid; }
    public void setRoleid(int roleid) { this.roleid = roleid; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email;}

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
}
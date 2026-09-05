package vn.iotstar.entity;

import java.io.Serializable;
import java.sql.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "products")
@NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p")
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "productId")
    private int productId;

    @Column(name = "productName", columnDefinition = "nvarchar(255) not null")
    private String productName;

    @Column(name = "description", columnDefinition = "nvarchar(max) null")
    private String description;

    @Column(name = "price")
    private double price;

    @Column(name = "images", columnDefinition = "nvarchar(500) null")
    private String images;

    @Column(name = "quantity")
    private int quantity;

    @Column(name = "status")
    private int status; // 1: Hiển thị/Đang bán, 0: Tạm ẩn

    @Column(name = "createDate")
    private Date createDate;

    // Mối quan hệ N - 1 với Category
    @ManyToOne
    @JoinColumn(name = "categoryId")
    private Category category;

    public Product() {}

    public Product(int productId, String productName, String description, double price, String images, int quantity,
            int status, Date createDate, Category category) {
        this.productId = productId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.images = images;
        this.quantity = quantity;
        this.status = status;
        this.createDate = createDate;
        this.category = category;
    }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}

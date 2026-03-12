package models.entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity(name = "Product")
@Table(name = "products")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "productId")
    private String productId;
    @Column(name = "productName")
    private String productName;
    @Column(name = "productImage")
    private String productImage;
    @Column(name = "brief")
    private String brief;
    @Column(name = "postedDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date postedDate;
    @Column(name = "unit")
    private String unit;
    @Column(name = "price")
    private Integer price;
    @Column(name = "discount")
    private Integer discount;
    @JoinColumn(name = "account", referencedColumnName = "account")
    @ManyToOne(optional = false)
    private Account account;
    @JoinColumn(name = "typeId", referencedColumnName = "typeId")
    @ManyToOne(optional = false)
    private Category type;

    public Product() {
    }

    public Product(String productId) {
        this.productId = productId;
    }

    public Product(String productId, String productName) {
        this.productId = productId;
        this.productName = productName;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public Date getPostedDate() {
        return postedDate;
    }

    public void setPostedDate(Date postedDate) {
        this.postedDate = postedDate;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Category getType() {
        return type;
    }

    public void setType(Category type) {
        this.type = type;
    }
    
    public int getFinalPrice() {
        return price - (price * discount/100);
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productId != null ? productId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Product)) {
            return false;
        }
        Product other = (Product) object;
        if ((this.productId == null && other.productId != null) || (this.productId != null && !this.productId.equals(other.productId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.entities.Product[ productId=" + productId + " ]";
    }

}

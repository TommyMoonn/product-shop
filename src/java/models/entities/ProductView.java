package models.entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity(name = "ProductView")
@Table(name = "ProductViews")
public class ProductView implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "viewId")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer viewId;
    @Column(name = "viewDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date viewDate;
    @JoinColumn(name = "account", referencedColumnName = "account")
    @ManyToOne
    private Account account;
    @JoinColumn(name = "productId", referencedColumnName = "productId")
    @ManyToOne(optional = false)
    private Product product;

    public ProductView() {
    }

    public ProductView(Integer viewId) {
        this.viewId = viewId;
    }

    public Integer getViewId() {
        return viewId;
    }

    public void setViewId(Integer viewId) {
        this.viewId = viewId;
    }

    public Date getViewDate() {
        return viewDate;
    }

    public void setViewDate(Date viewDate) {
        this.viewDate = viewDate;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (viewId != null ? viewId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductView)) {
            return false;
        }
        ProductView other = (ProductView) object;
        if ((this.viewId == null && other.viewId != null) || (this.viewId != null && !this.viewId.equals(other.viewId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.entities.ProductViews[ viewId=" + viewId + " ]";
    }

}

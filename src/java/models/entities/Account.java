package models.entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "accounts")
public class Account implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "account")
    private String account;
    @Column(name = "pass")
    private String pass;
    @Column(name = "lastName")
    private String lastName;
    @Column(name = "firstName")
    private String firstName;
    @Column(name = "birthday")
    @Temporal(TemporalType.TIMESTAMP)
    private Date birthday;
    @Column(name = "gender")
    private Boolean gender;
    @Column(name = "phone")
    private String phone;
    @Column(name = "isUse")
    private Boolean active;
    @Column(name = "roleInSystem")
    private Integer roleInSystem;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "account")
    private Collection<Product> productsCollection;

    public Account() {
    }

    public Account(String account) {
        this.account = account;
    }

    public Account(String account, String pass, String firstName) {
        this.account = account;
        this.pass = pass;
        this.firstName = firstName;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Boolean getGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean isUse) {
        this.active = isUse;
    }

    public Integer getRoleInSystem() {
        return roleInSystem;
    }

    public void setRoleInSystem(Integer roleInSystem) {
        this.roleInSystem = roleInSystem;
    }

    @XmlTransient
    public Collection<Product> getProductsCollection() {
        return productsCollection;
    }

    public void setProductsCollection(Collection<Product> productsCollection) {
        this.productsCollection = productsCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (account != null ? account.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Account)) {
            return false;
        }
        Account other = (Account) object;
        if ((this.account == null && other.account != null) || (this.account != null && !this.account.equals(other.account))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.entities.Account[ account=" + account + " ]";
    }

}

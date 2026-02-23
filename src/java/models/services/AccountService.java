package models.services;

import exceptions.ValidationException;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import models.entities.Account;
import models.entities.Role;
import utilities.JPAUtil;

public class AccountService implements Accessible<Account> {

    private EntityManager em;

    public AccountService() {
        this.em = JPAUtil.getEntityManager();
    }

    @Override
    public void create(Account entity) {
        if (findById(entity.getAccount()) != null) {
            throw new ValidationException("Account already exists.");
        }
        validate(entity);

        em.getTransaction().begin();
        em.persist(entity);
        em.getTransaction().commit();
    }

    @Override
    public Account update(Account entity) {
        if (entity == null) {
            throw new ValidationException("Account does not exist.");
        }
        validate(entity);

        em.getTransaction().begin();
        Account a = em.merge(entity);
        em.getTransaction().commit();
        return a;
    }

    @Override
    public void delete(String id) {
        Account a = findById(id);
        if (a == null) {
            throw new ValidationException("Account does not exist.");
        }
        
        Long count = em.createQuery("SELECT COUNT(p) FROM Product p WHERE p.account = :account", Long.class)
                .setParameter("account", a)
                .getSingleResult();

        if (count > 0) {
            throw new ValidationException("Cannot delete account because it owns existing products.");
        }
        
        em.getTransaction().begin();
        em.remove(a);
        em.getTransaction().commit();
    }

    @Override
    public Account findById(String id) {
        return em.find(Account.class, id);
    }

    @Override
    public List<Account> findAll() {
        return em.createQuery("SELECT a FROM Account a", Account.class).getResultList();
    }

    public Account updateIsUsed(String account, boolean status) {
        Account a = findById(account);
        if (a == null) {
            throw new ValidationException("Account does not exist.");
        }

        em.getTransaction().begin();
        a.setActive(status);
        a = em.merge(a);
        em.getTransaction().commit();
        return a;
    }

    public Account authenticate(String account, String pass) {
        try {
            return em.createQuery("SELECT a FROM Account a WHERE a.account = :account AND a.pass = :pass", Account.class)
                    .setParameter("account", account)
                    .setParameter("pass", pass)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    //helper class to enforce business rules on server-side
    private void validate(Account a) {
        if (a == null) {
            throw new ValidationException("Account cannot be null.");
        }
        if (a.getAccount() == null
                || a.getAccount().length() < 4
                || a.getAccount().length() > 20) {
            throw new ValidationException("Account name must be 4–20 characters, letters, numbers, underscore only");
        }
        if (a.getPass() == null) {
            throw new ValidationException("Password cannot be empty.");
        }
        if (a.getFirstName() == null || a.getLastName() == null
                || !a.getFirstName().matches("[\\p{L} ]+")
                || !a.getLastName().matches("[\\p{L} ]+")) {
            throw new ValidationException("First and last name must only contain letters and spaces");
        }
        if (a.getBirthday() == null) {
            throw new ValidationException("Birthday is required.");
        }
        if (a.getBirthday().after(new Date())) {
            throw new ValidationException("Birthday cannot be in the future.");
        }
        if (a.getPhone() == null || !a.getPhone().matches("0[0-9]{9}")) {
            throw new ValidationException("Phone number must start with 0 and have 10 digits");
        }
        if (!Role.isValid(a.getRoleInSystem())) {
            throw new ValidationException("Invalid role.");
        }
    }

}

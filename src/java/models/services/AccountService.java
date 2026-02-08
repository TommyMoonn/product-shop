package models.services;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import models.entities.Account;
import utilities.JPAUtil;

public class AccountService implements Accessible<Account> {

    private EntityManager em;

    public AccountService() {
        this.em = JPAUtil.getEntityManager();
    }

    @Override
    public void create(Account entity) {
        em.getTransaction().begin();
        em.persist(entity);
        em.getTransaction().commit();
    }

    @Override
    public Account update(Account entity) {
        em.getTransaction().begin();
        Account a = em.merge(entity);
        em.getTransaction().commit();
        return a;
    }

    @Override
    public void delete(String id) {
        em.getTransaction().begin();
        Account a = findById(id);
        if (a != null) {
            em.remove(a);
        }
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

    public Account updateIsUsed(String account, boolean active) {
        Account a = findById(account);
        if (a == null) return null;
        
        em.getTransaction().begin();
        a.setActive(active);
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

}

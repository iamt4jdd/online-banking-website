package DAO;

import business.Customer;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

public class CustomerDAO extends JpaDAO<Customer> implements GenericDAO<Customer> {

    @Override
    public Customer create(Customer t) {
        return super.create(t);
    }

    @Override
    public Customer get(Object id) {
        return super.find(Customer.class, id);
    }

    @Override
    public void delete(Object id) {
        super.delete(Customer.class, id);

    }

    @Override
    public List<Customer> listAll() {
        return super.findWithNamedQuery("");
    }

    @Override
    public long count() {

        return super.countWithNamedQuery("");
    }

    public Customer findByEmail(String email, String citizenId) {

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("email", email);
        parameters.put("citizenId", citizenId);

        List<Customer> result = super.findWithNamedQuery("SELECT c FROM Customer c WHERE c.email = :email OR c.citizenId = :citizenId", parameters);

        if (!result.isEmpty()) {
            return result.get(0);
        }

        return null;
    }

    public Customer checkLogin(String email, String password) {

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("email", email);
        parameters.put("password", password);

        List<Customer> result = super.findWithNamedQuery("SELECT c FROM Customer c "
                + "WHERE c.email = :email AND c.password = :password", parameters);

        if (!result.isEmpty()) {
            return result.get(0);
        }

        return null;
    }

    public String customerSignup(String fullName, String email, String password, String citizenId,
            String phoneNumber, String dateOfBirth, String address) {

        String message = "";
        Customer existCustomer = findByEmail(email, citizenId);
        if (existCustomer != null) {
            if (existCustomer.getEmail().equals(email)) {
                message = "Could not create new customer: the email " + email
                        + " is already registered by another customer.";
            } else if (existCustomer.getCitizenId().equals(citizenId)) {
                message = "Could not create new customer: the citizenId " + citizenId
                        + " is already registered by another customer.";
            }
        } else {

            Customer customerEntity = new Customer();
            customerEntity.setCustomerId(generateUniqueId());
            customerEntity.setName(fullName);
            customerEntity.setCustomerType("Regular");
            customerEntity.setEmail(email);
            customerEntity.setPassword(password);
            customerEntity.setPhoneNumber(phoneNumber);
            customerEntity.setDateofBirth(LocalDate.parse(dateOfBirth));
            customerEntity.setCitizenId(citizenId);
            customerEntity.setAddress(address);

            message = "The account has been created successfully.";
            create(customerEntity);
        }
        return message;
    }

}

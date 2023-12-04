package DAO;

import business.Customer;
import business.Employee;
import Exception.HandleException;
import common.HashGenerator;
import common.MailSender;
import controller.User.SignupServlet;
import jakarta.mail.MessagingException;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmployeeDAO extends JpaDAO<Employee> implements GenericDAO<Employee> {

    @Override
    public Employee create(Employee t) {
        return super.create(t);
    }

    @Override
    public Employee get(Object id) {
        return super.find(Employee.class, id);
    }

    @Override
    public void delete(Object id) {
        super.delete(Employee.class, id);

    }

    @Override
    public List<Employee> listAll() {
        return super.findWithNamedQuery("");
    }

    @Override
    public long count() {

        return super.countWithNamedQuery("");
    }

    public Employee findByEmailOrCitizenId(String email, String citizenId) {

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("email", email);
        parameters.put("citizenId", citizenId);

        List<Employee> result = super.findWithNamedQuery(
                "SELECT e FROM Employee e WHERE e.email = :email OR e.citizenId = :citizenId", parameters);

        if (!result.isEmpty()) {
            return result.get(0);
        }

        return null;
    }

    public List<Employee> findAllEmployee() {
        List<Employee> result = super.findWithNamedQuery("SELECT e FROM Employee e");

        if (!result.isEmpty()) {
            return result;
        }

        return null;
    }

    public Employee createEmployee(String fullName, String email, String password, String citizenId, String phoneNumber, String dateOfBirth, String address, String role) throws HandleException {
        Employee employeeEntity = new Employee();
        Employee existingEmployee = findByEmailOrCitizenId(email, citizenId);
        String encryptedPassword = HashGenerator.generateMD5(password);

        if (existingEmployee != null) {
            if (existingEmployee.getEmail().equals(email)) {
                throw new HandleException("The employee with Email " + email + " is already registered.", 409);
            } else if (existingEmployee.getCitizenId().equals(citizenId)) {
                throw new HandleException("The employee with Citizen Identity " + citizenId + " is already registered.",409);
            }
        } else {
            employeeEntity.setEmployeeId(generateUniqueId());
            employeeEntity.setName(fullName);
            employeeEntity.setEmail(email);
            employeeEntity.setPassword(encryptedPassword);
            employeeEntity.setPhoneNumber(phoneNumber);
            employeeEntity.setDateofBirth(LocalDate.parse(dateOfBirth));
            employeeEntity.setCitizenId(citizenId);
            employeeEntity.setAddress(address);
            employeeEntity.setRoles(role);

            String to = email;
            String subject = "Welcome to NND Banking";
            String body = "Dear " + fullName + ",\n\n"
                    + "Thank you for joining our company. Your account is ready for use. "
                    + "You can now start using our services at NND Banking.\n\n"
                    + "If you have any questions about our products or services, please feel free to contact us at any time.\n\n"
                    + "Sincerely,\n\n" + "NND Banking";
            try {
                MailSender.sendMail(to, subject, body);
            } catch (MessagingException ex) {
                Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            create(employeeEntity);
        }
        return null;
    }

}

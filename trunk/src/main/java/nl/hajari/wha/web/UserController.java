package nl.hajari.wha.web;

import java.util.List;
import nl.hajari.wha.domain.User;
import org.springframework.dao.DataAccessException;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.security.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.mail.MailSender;
import org.springframework.beans.factory.annotation.Autowired;

@RooWebScaffold(path = "user", automaticallyMaintainView = true, formBackingObject = User.class)
@RequestMapping("/user/**")
@Controller
public class UserController implements UserDetailsService {

    @Autowired
    private transient MailSender mailTemplate;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
        List<User> users = User.findUsersByUsernameEquals(username).getResultList();
        if (users.size() == 1) {
            return users.get(0);
        }
        throw new UsernameNotFoundException("Username: [ " + username + " ] not found!");
    }

    public void sendMessage(String mailFrom, String subject, String mailTo, String message) {
        org.springframework.mail.SimpleMailMessage simpleMailMessage = new org.springframework.mail.SimpleMailMessage();
        simpleMailMessage.setFrom(mailFrom);
        simpleMailMessage.setSubject(subject);
        simpleMailMessage.setTo(mailTo);
        simpleMailMessage.setText(message);
        mailTemplate.send(simpleMailMessage);
    }
}

package ptithcm.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.bean.Mailer;
import ptithcm.entity.User;

@Controller
@Transactional
@RequestMapping("/forget/")
public class ForgetPasswordController {
	@Autowired
	Mailer mailer;
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	public String codeSave=null;
	public String emailSave=null;
	public User user=null;
	public boolean testEmailExist(String email) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE email ='" + email + "'";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		if(list.size()!=0)return true;
		return false;
	}
	public User getUserByEmail(String email) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE email ='" + email + "'";
		Query query = session.createQuery(hql);
		User list = (User)query.list().get(0);
		return list;
	}
	@RequestMapping("requestEmail")
	public String requestEmail(ModelMap model) {
		model.addAttribute("btnStatus", "sendEmail");
		return "forget/requestEmail";
	}
	@RequestMapping(value="requestEmail", params="sendEmail")
	public String sendEmail(ModelMap model, @RequestParam("email")String email) {
		model.addAttribute("email", email);
		if(!testEmailExist(email)) {
			model.addAttribute("btnStatus", "sendEmail");
			model.addAttribute("message", "Email is not registered!!!");
			return"forget/requestEmail";
		}
		String codeRandom= Support.generateRandomString();
		codeSave=codeRandom;
		emailSave=email;
		mailer.send("longsk123456789@gmail.com", email, "Mã xác thực quên mật khẩu",
				"\nMã xác thực là: " + codeRandom);
		model.addAttribute("btnStatus", "confirm");
		return "forget/requestEmail";
	}
	@RequestMapping(value="requestEmail", params="confirm")
	public String confirm(ModelMap model, @RequestParam("code")String code) {
		if(!code.equals(codeSave)) {
			model.addAttribute("btnStatus", "sendEmail");
			model.addAttribute("message", "Code not match. Please send email again!!!");
			emailSave=null;
			return"forget/requestEmail";
		}
		user=getUserByEmail(emailSave);
		model.addAttribute("username", user.getUsername());
		return "forget/changePassword";
	}
	
	public int update(Object object) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(object);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	
	@RequestMapping(value="requestEmail", params="supply")
	public String supply(ModelMap model, 
			@RequestParam("password1")String password1,@RequestParam("password2")String password2) {
		if(!password1.equals(password2)) {
			model.addAttribute("message", "Repeat password not match!!!");
			model.addAttribute("username", user.getUsername());
			return "forget/changePassword";
		}
		user.setPassword(password1);
		int check = this.update(user);
		if (check != 0) {
			model.addAttribute("message", "Update password successfully");
			user=null;
			return "login";
		} else {
			model.addAttribute("message", "Update password fail");
			model.addAttribute("username", user.getUsername());
		}
		return "forget/changePassword";
	}
}

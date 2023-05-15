package ptithcm.controller;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.bean.Mailer;
import ptithcm.entity.User;

@Controller
@Transactional
@RequestMapping("/user/")
public class UserController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	@Autowired
	Mailer mailer;
	public boolean testUsernameExist(String username) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE username ='" + username + "'";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		if(list.size()!=0)return true;
		return false;
	}
	
	public List<User> getUserList() {
		Session session = factory.getCurrentSession();
		String hql = "FROM User";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
	}
	public User getUser(String username) {
		Session session = factory.getCurrentSession();
		String hql = "from User where username=:username";
		Query query = session.createQuery(hql);
		query.setParameter("username",username);
		User user = (User) query.list().get(0);
		return user;
	}
	public boolean testEmailExist(String email) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE email ='" + email + "'";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		if(list.size()!=0)return true;
		return false;
	}
	
	public boolean testPhoneExist(String phone) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE phonenumber ='" + phone + "'";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		if(list.size()!=0)return true;
		return false;
	}
	
	public boolean testPhoneRegex(String phone) {
		Pattern pattern = Pattern.compile("^[0-9]{10}$");
	    Matcher matcher = pattern.matcher(phone);
	   	return matcher.matches();
	}
	public boolean testEmailRegex(String email) {
		Pattern pattern = Pattern.compile("^(.+)@(\\S+)$");
	    Matcher matcher = pattern.matcher(email);
	   	return matcher.matches();
	}
	
	public int insert(Object object) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(object);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
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
	
	public int delete(Object object) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.delete(object);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	public String list(ModelMap model) {
		List<User> userList = getUserList();
		User newUser=new User();
		newUser.setPassword("123");//set mật khẩu mặc định
//		String codeRandom= Support.generateRandomString();
//		newUser.setPassword(codeRandom);
		model.addAttribute("user",newUser);
		model.addAttribute("userList", userList);
		return "user/manage";
	}
	@RequestMapping(value="list",params="btnAdd",method=RequestMethod.POST)
	public String addUser(ModelMap model,@Validated @ModelAttribute("user") User user, BindingResult errors) {
		
		if(testUsernameExist(user.getUsername())) {
			errors.rejectValue("username", "user", "Username đã được đăng ký");
		}
		if(testEmailExist(user.getEmail())) {
			errors.rejectValue("email", "user", "Email đã được đăng ký");
		}
		if(!testEmailRegex(user.getEmail())) {
			errors.rejectValue("email", "user", "Không đúng định dạng: example@gmail.com");
		}
		if(testPhoneExist(user.getPhonenumber())) {
			errors.rejectValue("phonenumber", "user", "Số điện thoại đã được đăng ký");
		}
		if(!testPhoneRegex(user.getPhonenumber())) {
			errors.rejectValue("phonenumber", "user", "Không đúng định dạng 10 số");
		}
		if(user.getBirthday()==null) {
			errors.rejectValue("birthday", "user", "Vui lòng nhập ngày sinh");
		}
		if(!errors.hasErrors()) {
			int check = this.insert(user);
			if (check != 0) {
//				mailer.send("longsk123456789@gmail.com", user.getEmail(), "Mật khẩu tài khoản mới",
//				"\nMật khẩu của bạn là: " + user.getPassword());
				model.addAttribute("message", "Thêm thành công");
				User newUser=new User();
				newUser.setPassword("123");//set mật khẩu mặc định cho user mới
//				String codeRandom= Support.generateRandomString();
//				newUser.setPassword(codeRandom);
				model.addAttribute("user", newUser);
			} else {
				
				model.addAttribute("message", "Thêm thất bại");
			}
		}
		else {
			model.addAttribute("message", "Lỗi input");
		}
		List<User> userList = getUserList();
		model.addAttribute("userList", userList);
		return "user/manage";
	}
	@RequestMapping(value="/list/{username}", params="linkDelete")
	public String deleteUser(ModelMap model, @PathVariable("username")String username, User user) {
		User userDelete = getUser(username);
		int check=delete(userDelete);
		if(check==1) {
			model.addAttribute("message", "Xóa tài khoản thành công");
		}
		else {
			model.addAttribute("message", "Xóa tài khoản thất bại");
		}
		List<User> userList = getUserList();
		model.addAttribute("user", user);
		model.addAttribute("userList", userList);
		return "user/manage";
	}
	@RequestMapping(value="/list/{username}", params="linkEdit")
	public String editUser(ModelMap model, @PathVariable("username")String username, User user) {
		User userEdit = getUser(username);
		if(userEdit.getLock()) {
			userEdit.setLock(false);
		}
		else userEdit.setLock(true);
		int check=update(userEdit);
		if(check==1) {
			model.addAttribute("message", "Cập nhật thành công");
		}
		else {
			model.addAttribute("message", "Cập nhật thất bại");
		}
		List<User> userList = getUserList();
		model.addAttribute("user", user);
		model.addAttribute("userList", userList);
		return "user/manage";
	}
	@RequestMapping(value="/register/form",method=RequestMethod.GET)
	public String formRegister(ModelMap model) {
		model.addAttribute("user", new User());
		return "user/register";
	}
	
	@RequestMapping(value="/register/form",method=RequestMethod.POST)
	public String applyRegister(ModelMap model,@Validated @ModelAttribute("user")User user, BindingResult errors,
			@RequestParam("password2")String password2) {
		user.setLock(false);
		user.setPermission("Audience");
		if(testUsernameExist(user.getUsername())) {
			errors.rejectValue("username", "user", "Username đã được đăng ký");
		}
		if(!password2.equals(user.getPassword())) {
			errors.rejectValue("password", "user", "Mật khẩu xác nhận không khớp");
		}
		if(testEmailExist(user.getEmail())) {
			errors.rejectValue("email", "user", "Email đã được đăng ký");
		}
		if(!testEmailRegex(user.getEmail())) {
			errors.rejectValue("email", "user", "Không đúng định dạng: example@gmail.com");
		}
		if(testPhoneExist(user.getPhonenumber())) {
			errors.rejectValue("phonenumber", "user", "Số điện thoại đã được đăng ký");
		}
		if(!testPhoneRegex(user.getPhonenumber())) {
			errors.rejectValue("phonenumber", "user", "Không đúng định dạng 10 số");
		}
		if(user.getBirthday()==null) {
			errors.rejectValue("birthday", "user", "Vui lòng nhập ngày sinh");
		}
		if(!errors.hasErrors()) {
			
			int check = this.insert(user);
			if (check != 0) {
				model.addAttribute("message", "Đăng ký thành công");
				model.addAttribute("user", new User());
			} else {
				model.addAttribute("password2", password2);
				model.addAttribute("message", "Đăng ký thất bại");
			}
		}
		else {
			model.addAttribute("password2", password2);
			model.addAttribute("message", "Lỗi input");
		}
		return "user/register";
	}
	
	@RequestMapping(value="/info",method=RequestMethod.GET)
	public String infoForm(ModelMap model) {
		model.addAttribute("user", LoginController.user);
		model.addAttribute("btnStatus", "btnEdit");
		return "user/info";
	}
	@RequestMapping(value="/info",params="btnEdit",method=RequestMethod.POST)
	public String infoInput(ModelMap model, User user) {
		model.addAttribute("user", user);
		model.addAttribute("btnStatus", "btnSave");
		return "user/info";
	}
	@RequestMapping(value="/info",params="btnSave",method=RequestMethod.POST)
	public String infoEdit(ModelMap model,@Validated @ModelAttribute("user")User user, BindingResult errors) {
		
		if(!user.getEmail().equals(LoginController.user.getEmail())&&testEmailExist(user.getEmail())) {
			errors.rejectValue("email", "user", "Email đã được đăng ký");
		}
		if(!testEmailRegex(user.getEmail())) {
			errors.rejectValue("email", "user", "Không đúng định dạng: example@gmail.com");
		}
		if(!user.getPhonenumber().equals(LoginController.user.getPhonenumber())&&testPhoneExist(user.getPhonenumber())) {
			errors.rejectValue("phonenumber", "user", "Số điện thoại đã được đăng ký");
		}
		if(!testPhoneRegex(user.getPhonenumber())) {
			errors.rejectValue("phonenumber", "user", "Không đúng định dạng 10 số");
		}
		if(user.getBirthday()==null) {
			errors.rejectValue("birthday", "user", "Vui lòng nhập ngày sinh");
		}
		if(!errors.hasErrors()) {
			int check = this.update(user);
			if (check != 0) {
				model.addAttribute("message", "Chỉnh sửa thành công");
				model.addAttribute("btnStatus", "btnEdit");
				LoginController.user=user;
			} else {
				model.addAttribute("message", "Chỉnh sửa thất bại");
				model.addAttribute("btnStatus", "btnSave");
			}
		}
		else {
			model.addAttribute("message", "Lỗi input");
			model.addAttribute("btnStatus", "btnSave");
		}
		return "user/info";
	}
	@RequestMapping(value="/changePassword",method=RequestMethod.GET)
	public String changePasswordForm(ModelMap model) {
		return "user/changePassword";
	}
	@RequestMapping(value="/changePassword",method=RequestMethod.POST)
	public String changePassword(ModelMap model, HttpServletRequest request) {
		String oldPassword=request.getParameter("oldPassword");
		String password1=request.getParameter("password1");
		String password2=request.getParameter("password2");
		if(oldPassword.isBlank()||password1.isBlank()||password2.isBlank()) {
			model.addAttribute("message","Vui lòng điền đầy đủ thông tin");
		}
		else if(!oldPassword.equals(LoginController.user.getPassword())) {
			model.addAttribute("message","Mật khẩu cũ không chính xác");
		}
		else if(!password2.equals(password1)) {
			model.addAttribute("message","Mật khẩu xác nhận lại không khớp");
		}
		else {
			LoginController.user.setPassword(password1);
			int check = this.update(LoginController.user);
			if (check != 0) {
				model.addAttribute("message","Đổi mật khẩu thành công");
				return "user/changePassword";
			}
			else {
				model.addAttribute("message","Đổi mật khẩu thất bại");
			}
		}
		model.addAttribute("oldPassword", oldPassword);
		model.addAttribute("password1", password1);
		model.addAttribute("password2", password2);
		return "user/changePassword";
	}
}

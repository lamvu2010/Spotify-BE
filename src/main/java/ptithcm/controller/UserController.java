package ptithcm.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.bean.Mailer;
import ptithcm.bean.Time;
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
	
	@ModelAttribute("nations")
	public List<String> getNationList(){
		String []arrNations=new String[] {"Vietnam","England", "China","Japan"};
		List<String> listNations=Arrays.asList(arrNations);
		return listNations;
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
		model.addAttribute("month", "");
		model.addAttribute("user",newUser);
		model.addAttribute("userList", userList);
		return "user/manage";
	}
	@RequestMapping(value="list",params="btnAdd",method=RequestMethod.POST)
	public String addUser(ModelMap model,HttpServletRequest request,@Validated @ModelAttribute("user") User user, BindingResult errors) throws ParseException {
		
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
		
		String year=request.getParameter("year");
		String month=request.getParameter("month");
		String day=request.getParameter("day");
		Time time=new Time(day,month,year);
		user.setBirthday(time.getSqlDate());
		
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
				model.addAttribute("day", time.getDay());
				model.addAttribute("month", time.getMonth());
				model.addAttribute("year",time.getYear());
				model.addAttribute("message", "Thêm thất bại");
			}
		}
		else {
			model.addAttribute("day", time.getDay());
			model.addAttribute("month", time.getMonth());
			model.addAttribute("year",time.getYear());
			model.addAttribute("message", "Lỗi input");
		}
		List<User> userList = getUserList();
		model.addAttribute("userList", userList);
		return "user/manage";
	}
	@RequestMapping(value="/list/{username}", params="linkDelete")
	public String deleteUser(ModelMap model, @PathVariable("username")String username, User user, HttpServletRequest request) {
		User userDelete = getUser(username);
		int check=delete(userDelete);
		if(check==1) {
			model.addAttribute("message", "Xóa tài khoản thành công");
		}
		else {
			model.addAttribute("message", "Xóa tài khoản thất bại");
		}
		List<User> userList = getUserList();
		String day=request.getParameter("day");
		String month=request.getParameter("month");
		String year=request.getParameter("year");
		if(day!=null)model.addAttribute("day", day);
		if(month!=null)model.addAttribute("month",month);
		if(year!=null)model.addAttribute("year", year);
		model.addAttribute("user", user);
		model.addAttribute("userList", userList);
		return "user/manage";
	}
	@RequestMapping(value="/list/{username}", params="linkEdit")
	public String editUser(ModelMap model, @PathVariable("username")String username, User user, HttpServletRequest request) {
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
		String day=request.getParameter("day");
		String month=request.getParameter("month");
		String year=request.getParameter("year");
		if(day!=null)model.addAttribute("day", day);
		if(month!=null)model.addAttribute("month",month);
		if(year!=null)model.addAttribute("year", year);
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
			HttpServletRequest request) throws ParseException {
		user.setLock(false);
		user.setPermission("Audience");
		String repeatpass=request.getParameter("repeatpass");
		String day=request.getParameter("day");
		String month=request.getParameter("month");
		String year=request.getParameter("year");
		
		try {
			Time time = new Time(day,month,year);
			user.setBirthday(time.getSqlDate());
		}
		catch(Exception ex){
			errors.rejectValue("birthday", "user", "Error convert: "+ex.getMessage());
			user.setBirthday(null);
		}
		if(testUsernameExist(user.getUsername())) {
			errors.rejectValue("username", "user", "Username is existing");
		}
		if(!repeatpass.equals(user.getPassword())) {
			errors.rejectValue("password", "user", "Password repeat not match");
		}
		if(testEmailExist(user.getEmail())) {
			errors.rejectValue("email", "user", "Email is existing");
		}
		if(!testEmailRegex(user.getEmail())) {
			errors.rejectValue("email", "user", "Error regex: example@gmail.com");
		}
		if(testPhoneExist(user.getPhonenumber())) {
			errors.rejectValue("phonenumber", "user", "Phonenumber is existing");
		}
		if(!testPhoneRegex(user.getPhonenumber())) {
			errors.rejectValue("phonenumber", "user", "Not match regex: 10 number");
		}
		if(!errors.hasErrors()) {
			
			int check = this.insert(user);
			if (check != 0) {
				model.addAttribute("message", "Sign up successfull");
				model.addAttribute("user", new User());
			} else {
				model.addAttribute("repeatpass", repeatpass);
				model.addAttribute("message", "Sign up fail!!!");
				model.addAttribute("year", year);
				model.addAttribute("day", day);
				model.addAttribute("repeatpass", repeatpass);
			}
		}
		else {
			model.addAttribute("repeatpass", repeatpass);
			model.addAttribute("message", "Error input");
			model.addAttribute("year", year);
			model.addAttribute("day", day);
			model.addAttribute("repeatpass", repeatpass);
		}
		return "user/register";
	}
	
	@RequestMapping(value="/info",method=RequestMethod.GET)
	public String infoForm(ModelMap model) {
		Time time = new Time();
		time.initBySqlDate(LoginController.user.getBirthday());
		model.addAttribute("user", LoginController.user);
		model.addAttribute("year", time.getYear());
		model.addAttribute("month", time.getMonth());
		model.addAttribute("day", time.getDay());
		model.addAttribute("btnStatus", "btnEdit");
		return "user/info";
	}
	@RequestMapping(value="/info",params="btnEdit",method=RequestMethod.POST)
	public String infoInput(ModelMap model) {
		
		model.addAttribute("user", LoginController.user);
		Time time = new Time();
		time.initBySqlDate(LoginController.user.getBirthday());
		model.addAttribute("year", time.getYear());
		model.addAttribute("month", time.getMonth());
		model.addAttribute("day", time.getDay());
		model.addAttribute("btnStatus", "btnSave");
		
		return "user/info";
	}
	@RequestMapping(value="/info",params="btnSave",method=RequestMethod.POST)
	public String infoEdit(ModelMap model,@Validated @ModelAttribute("user")User user, BindingResult errors, HttpServletRequest request) {
		
		String year=request.getParameter("year");
		String month=request.getParameter("month");
		String day=request.getParameter("day");
		System.out.println(year+month+day);
		Time time=new Time(day,month,year);
		try {
			
			user.setBirthday(time.getSqlDate());
			System.out.println(user.getBirthday().toString());
		}
		catch(Exception ex) {
			errors.rejectValue("birthday", "user", "Error conver: "+ex.getMessage());
		}
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
			for(ObjectError e:errors.getAllErrors()) {
				System.out.println(e.getDefaultMessage());
			}
			model.addAttribute("message", "Error input");
			model.addAttribute("btnStatus", "btnSave");
		}
		model.addAttribute("year", time.getYear());
		model.addAttribute("month", time.getMonth());
		model.addAttribute("day", time.getDay());
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

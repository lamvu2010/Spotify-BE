package ptithcm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.User;

@Transactional
@Controller
@RequestMapping("/home/")
public class LoginController {
	public static User user=null;
	@Autowired
	SessionFactory factory;
	
	
	public List<User> getUser(String username) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE username ='" + username + "'";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
	}
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String showLogin() {
		return"login";
	}
	@RequestMapping(value="login",method=RequestMethod.POST)
	public String login(HttpServletRequest rq, ModelMap model, HttpSession sessionUser) {
		String username = rq.getParameter("username");
		String password = rq.getParameter("password");
		if (username.equals("") || password.equals("")) {
			model.addAttribute("message", "Vui lòng nhập đủ thông tin");
			return "login";
		} else {
			List<User>list=getUser(username);
			if (list.size()==1) {
				String passwordCorrect=list.get(0).getPassword();
					if(!password.equals(passwordCorrect)) {
						model.addAttribute("username", username);
						model.addAttribute("message", "Sai mật khẩu");
						return "login";
					}
					else {
						user=list.get(0);
						if(user.getLock()) {
							model.addAttribute("username", username);
							model.addAttribute("message", "Chúng tôi rất tiếc, tài khoản của bạn đã bị khóa");
							user=null;
							return "login";
						}
						sessionUser.setAttribute("permission", user.getPermission());
						if(user.getPermission().equals("Audience")) {
							model.addAttribute("message", "Đăng nhập thành công với quyền hạn người nghe");
							return"login";
						}
						else if(user.getPermission().equals("Admin")) {
							model.addAttribute("message", "Đăng nhập thành công với quyền hạn quản trị website");
							return"login";
						}
						else if(user.getPermission().equals("Artist")) {
							model.addAttribute("message", "Đăng nhập thành công với quyền hạn nghệ sĩ");
							return"login";
						}
					}
					
				}
			else {
				model.addAttribute("message", "Tài khoản không tồn tại");
				return "login";
			}
		}
		return "login";
	}

	@RequestMapping("logout")
	public String logout(ModelMap model, HttpSession sessionUser) {
		sessionUser.removeAttribute("permission");
		user=null;
		return"login";
	}
}

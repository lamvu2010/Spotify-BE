package ptithcm.controller;

import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.bean.Time;
import ptithcm.entity.Genre;
import ptithcm.entity.History;
import ptithcm.entity.InformationTrack;
import ptithcm.entity.LikedTracks;
import ptithcm.entity.ListTracks;
import ptithcm.entity.Playlist;
import ptithcm.entity.Track;
import ptithcm.entity.User;

@Transactional
@Controller
@RequestMapping("/audience/")
public class AudienceController {
	@Autowired
	SessionFactory factory;
	// Show thư viện
	@RequestMapping(value = "/library", method = RequestMethod.GET)
	public String library(ModelMap model, String user) {
		user = LoginController.user.getUsername();
		List<Playlist> playlist = playlists(user);
		List<Track> likedtracks = listLikeTracks(user);
		model.addAttribute("playlists", playlist);
		model.addAttribute("playlistShow", likedtracks);
		model.addAttribute("namePlaylist", "LoveSongs");
		model.addAttribute("type", "private");
		return "audience/lib";
		
	}

	// Show một playlist
	@RequestMapping(value = "/show1Playlist", method = RequestMethod.GET)
	public String showAPlaylist(ModelMap model, HttpServletRequest request) {
		String id = request.getParameter("idPlaylist");
		List<Playlist> playlist = playlists(LoginController.user.getUsername());
		String name = request.getParameter("namePlaylist");
		List<Track> list = listTracksPlaylist(id);
		model.addAttribute("playlistShow", list);
		model.addAttribute("namePlaylist", name);
		model.addAttribute("playlists", playlist);
		model.addAttribute("type", "private");
		return "audience/lib";
	}

	// Lấy danh sách playlist của bản thân
	public List<Playlist> playlists(String user) {
		Session session = factory.getCurrentSession();
		String hql = "From Playlist where username = :user";
		Query query = session.createQuery(hql);
		query.setString("user", user);
		List<Playlist> list = query.list();
		return list;
	}

	// Lấy danh sách các bài hát yêu thích
	public List<Track> listLikeTracks(String user) {
		Session session = factory.getCurrentSession();
		String hql = "From Track where id_track in (Select track.id_track From LikedTracks Where username = :user)";
		Query query = session.createQuery(hql);
		query.setString("user", user);
		List<Track> list = query.list();
		return list;
	}

	// Show view home của audience
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String homepage(ModelMap model) {
		String user = LoginController.user.getUsername();
		List<Genre> listGenre = listGenre();
		List<User> listArtist = listUser();
		List<Playlist> playlist = playlists(user);
		model.addAttribute("genres", listGenre);
		model.addAttribute("artists", listArtist);
		model.addAttribute("playlists", playlist);
		return "audience/home";
	}

	// Lay 1 danh sach nhac theo 1 the loai
	public List<Track> listTracksGenre(String genre) {
		Session session = factory.getCurrentSession();
		String hql = "From Track Where genre.type = :genre And status = 'pending' And isPublic = '0' ";
		Query query = session.createQuery(hql);
		query.setString("genre", genre);
		List<Track> list = query.list();
		return list;
	}

	// Lay 1 danh sach nhac theo 1 artist
	public List<Track> listTracksArtist(String username) {
		Session session = factory.getCurrentSession();
		String hql = "From Track Where username = :username And status = 'pending' And isPublic = '0'";
		Query query = session.createQuery(hql);
		query.setString("username", username);
		List<Track> list = query.list();
		return list;
	}

	// Lay danh sach nhac cua 1 playlist
	public List<Track> listTracksPlaylist(String idPlaylist) {
		Session session = factory.getCurrentSession();
		String hql = "from Track where id_track in (select track.id_track from ListTracks where playlist.id_playlist = :idPlaylist)";
		Query query = session.createQuery(hql);
		query.setString("idPlaylist", idPlaylist);
		List<Track> list = query.list();
		return list;
	}

	// Lấy danh sách các thể loại nhạc
	public List<Genre> listGenre() {
		Session session = factory.getCurrentSession();
		String hql = "From Genre";
		Query query = session.createQuery(hql);
		List<Genre> list = query.list();
		return list;
	}

	// Lấy danh sách các nghệ sĩ
	public List<User> listUser() {
		Session session = factory.getCurrentSession();
		String hql = "From User Where permission = 'Artist' ";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
	}

	// Lấy danh sách các bài hát
	public List<Track> listTracks() {
		Session session = factory.getCurrentSession();
		String hql = "From Track";
		Query query = session.createQuery(hql);
		List<Track> list = query.list();
		return list;
	}

	// Thêm một playlist
	@RequestMapping(value = "/addPlaylist", method = RequestMethod.POST)
	public String addPlaylist(HttpServletRequest request, ModelMap model) {
		Playlist playlist = new Playlist();
		playlist.setName(request.getParameter("namePlaylist"));
		playlist.setUser(LoginController.user);
		addPlaylist(playlist);
		return homepage(model);
	}

	public int addPlaylist(Playlist playlist) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(playlist);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			System.out.println(0);
			return 0;
		} finally {
			session.close();
		}
		System.out.println(1);
		return 1;
	}

	@RequestMapping(value = "/genre", method = RequestMethod.POST)
	public String showGenrePlaylist(HttpServletRequest request, ModelMap model) {
		String genre = request.getParameter("nameGenre");
		List<Track> list = listTracksGenre(genre);
		List<Playlist> playlist = playlists(LoginController.user.getUsername());
		model.addAttribute("playlistShow", list);
		model.addAttribute("namePlaylist", genre);
		model.addAttribute("playlists", playlist);
		model.addAttribute("type", "public");
		return "audience/lib";
	}

	@RequestMapping(value = "/artist", method = RequestMethod.POST)
	public String showArtistPlaylist(HttpServletRequest request, ModelMap model) {
		String username = request.getParameter("idArtist");
		String fullname = request.getParameter("fullnameArtist");
		List<Track> list = listTracksArtist(username);
		List<Playlist> playlist = playlists(LoginController.user.getUsername());
		model.addAttribute("playlistShow", list);
		model.addAttribute("namePlaylist", fullname);
		model.addAttribute("playlists", playlist);
		model.addAttribute("type", "public");
		return "audience/lib";
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String showAllTracks(ModelMap model) {
		List<Playlist> playlist = playlists(LoginController.user.getUsername());
		List<Track> tracks = listTracks();
		model.addAttribute("playlists", playlist);
		model.addAttribute("tracks", tracks);
		return "audience/search";
	}

	public void deleteListTrack(String id) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String hql = "delete from ListTracks where playlist.id_playlist = :id ";
			Query query = session.createQuery(hql);
			query.setString("id", id);
			query.executeUpdate();
			t.commit();
		} catch (Exception e) {
			t.rollback();
		}finally {
			session.close();
		}
	}
	public void deletePlaylist(String id) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String hql1 = "delete from Playlist where id_playlist = :id";
			Query query1 = session.createQuery(hql1);
			query1.setString("id", id);
			query1.executeUpdate();
			t.commit();
		}
		catch(Exception e) {
			t.rollback();
		}finally {
			session.close();
		}
	}
	
	@RequestMapping(value = "/deletePlaylist", method = RequestMethod.POST)
	public String deletePlaylist(HttpServletRequest request, ModelMap model) {
		String id = request.getParameter("idPlaylist_delete");
		deleteListTrack(id);
		deletePlaylist(id);
		return homepage(model);
	}
	
	public void addTrackToPlaylist(String id_track, String id_playlist) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		Playlist playlist = new Playlist();
		playlist.setId_playlist(Long.parseLong(id_playlist));
		Track track = new Track();
		track.setId_track(Long.parseLong(id_track));
		try {
			ListTracks new_track = new ListTracks();
			new_track.setPlaylist(playlist);
			new_track.setTrack(track);
			session.save(new_track);
			t.commit();
		}catch(Exception e) {
			t.rollback();
		}finally {
			session.close();
		}
	}
	
	public void addTrackToLoveSongs(String id_track) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		Track track = new Track();
		track.setId_track(Long.parseLong(id_track));
		try {
			LikedTracks new_track = new LikedTracks();
			new_track.setTrack(track);
			new_track.setUser(LoginController.user);
			session.save(new_track);
			t.commit();
		}catch(Exception e) {
			t.rollback();
		}finally {
			session.close();
		}
	}
	
	@RequestMapping(value = "/addTrack", method = RequestMethod.POST)
	public String addTrackToPlaylist(HttpServletRequest request, ModelMap model) {
		String id_track = request.getParameter("id_track");
		String id_playlist = request.getParameter("namePlaylist_add");
		System.out.println(id_playlist);
		if(id_playlist.equals("999999")) {
			addTrackToLoveSongs(id_track);
			System.out.println("100");
			return showAllTracks(model);
		}
		addTrackToPlaylist(id_track,id_playlist);
		return showAllTracks(model);
	}
	
	public void deleteTrackFromPlaylist(String id_track, String id_playlist) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String hql = "delete from ListTracks where playlist.id_playlist = :id_playlist "
					+ "and track.id_track = :id_track ";
			Query query = session.createQuery(hql);
			query.setString("id_playlist",id_playlist);
			query.setString("id_track", id_track);
			query.executeUpdate();
			System.out.println("0");
			t.commit();
		}catch(Exception e) {
			System.out.println("1");
			System.out.println(e.getMessage());
			t.rollback();
		}
	}
	
	@RequestMapping(value = "/deleteTrack", method = RequestMethod.POST)
	public String deleteTrackFromPlaylist(HttpServletRequest request, ModelMap model) {
		String id_track = request.getParameter("idTrack");
		String id_playlist = request.getParameter("idPlaylist");
		System.out.println(id_track);
		System.out.println(id_playlist);
		deleteTrackFromPlaylist(id_track, id_playlist);
		return "audience/lib";
	}
	@RequestMapping(value="/changePassword",method=RequestMethod.GET)
	public String changePasswordForm(ModelMap model) {
		return "audience/changePassword";
	}
	@RequestMapping(value="/changePassword",method=RequestMethod.POST)
	public String changePassword(ModelMap model, HttpServletRequest request) {
		String oldPassword=request.getParameter("oldPassword");
		String password1=request.getParameter("password1");
		String password2=request.getParameter("password2");
		if(oldPassword.isBlank()||password1.isBlank()||password2.isBlank()) {
			model.addAttribute("message","Please input fully");
		}
		else if(!oldPassword.equals(LoginController.user.getPassword())) {
			model.addAttribute("message","Old password not match");
		}
		else if(!password2.equals(password1)) {
			model.addAttribute("message","Repeat password not match");
		}
		else {
			LoginController.user.setPassword(password1);
			int check = this.update(LoginController.user);
			if (check != 0) {
				model.addAttribute("message","Change password successfully");
				return "audience/changePassword";
			}
			else {
				model.addAttribute("message","Change password fail!!!");
			}
		}
		model.addAttribute("oldPassword", oldPassword);
		model.addAttribute("password1", password1);
		model.addAttribute("password2", password2);
		return "audience/changePassword";
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

	@RequestMapping(value="/info",method=RequestMethod.GET)
	public String infoForm(ModelMap model) {
		Time time = new Time();
		time.initBySqlDate(LoginController.user.getBirthday());
		model.addAttribute("user", LoginController.user);
		model.addAttribute("year", time.getYear());
		model.addAttribute("month", time.getMonth());
		model.addAttribute("day", time.getDay());
		model.addAttribute("btnStatus", "btnEdit");
		return "audience/info";
	}
	public boolean testEmailExist(String email) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE email ='" + email + "'";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		if(list.size()!=0)return true;
		return false;
	}
	
	public boolean testUsernameExist(String username) {
		Session session = factory.getCurrentSession();
		String hql = "FROM User WHERE username ='" + username + "'";
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
	
	public boolean checkYear(int year) {
		int currentYear=Year.now().getValue();
		if(year<currentYear)return true;
		return false;
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
		
		return "audience/info";
	}
	@RequestMapping(value="/info",params="btnSave",method=RequestMethod.POST)
	public String infoEdit(ModelMap model,@Validated @ModelAttribute("user")User user, BindingResult errors, HttpServletRequest request) {
		
		String year=request.getParameter("year");
		String month=request.getParameter("month");
		String day=request.getParameter("day");
		System.out.println(year+month+day);
		Time time=new Time(day,month,year);
		if(!checkYear(Integer.valueOf(year))) {
			errors.rejectValue("birthday", "user", "year< now");
		}
		else {
			
			try {
				
				user.setBirthday(time.getSqlDate());
				System.out.println(user.getBirthday().toString());
			}
			catch(Exception ex) {
				errors.rejectValue("birthday", "user", "Error conver: "+ex.getMessage());
			}
		}
		if(!user.getEmail().equals(LoginController.user.getEmail())&&testEmailExist(user.getEmail())) {
			errors.rejectValue("email", "user", "Email is existing");
		}
		if(!testEmailRegex(user.getEmail())) {
			errors.rejectValue("email", "user", "Not match: example@gmail.com");
		}
		
		if(!testPhoneRegex(user.getPhonenumber())) {
			errors.rejectValue("phonenumber", "user", "Not match: 10 number");
		}
		if(!errors.hasErrors()) {
			int check = this.update(user);
			if (check != 0) {
				model.addAttribute("message", "Edit successfully");
				model.addAttribute("btnStatus", "btnEdit");
				LoginController.user=user;
			} else {
				model.addAttribute("message", "Edit fail!!!");
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
		return "audience/info";
	}
}
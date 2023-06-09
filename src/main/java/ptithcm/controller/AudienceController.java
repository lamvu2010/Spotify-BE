package ptithcm.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.Genre;
import ptithcm.entity.InformationTrack;
import ptithcm.entity.LikedTracks;
import ptithcm.entity.Playlist;
import ptithcm.entity.Track;
import ptithcm.entity.User;

@Controller
@RequestMapping("/audience/")
@Transactional
public class AudienceController {
	@Autowired
	SessionFactory factory;
	
	// Show thư viện
	@RequestMapping(value="/library", method = RequestMethod.GET)
	public String library(ModelMap model, String user) {
		user = LoginController.user.getUsername();
		List <Playlist> playlist = playlists(user);
		List <Track> likedtracks = listLikeTracks(user);
		model.addAttribute("playlists",playlist);
		model.addAttribute("playlistShow", likedtracks);
		model.addAttribute("namePlaylist", "LoveSongs");
		return "audience/lib";
	}
	
	// Show một playlist
	@RequestMapping(value="/show1Playlist", method = RequestMethod.GET)
	public String showAPlaylist(ModelMap model, HttpServletRequest request) {
		String id = request.getParameter("idPlaylist");
		List <Playlist> playlist = playlists(LoginController.user.getUsername());
		String name = request.getParameter("namePlaylist");
		List<Track> list = listTracksPlaylist(id);
		model.addAttribute("playlistShow",list);
		model.addAttribute("namePlaylist",name);
		model.addAttribute("playlists",playlist);
		return "audience/lib";
	}
	
	
	// Lấy danh sách playlist của bản thân
	public List <Playlist> playlists(String user){
		Session session = factory.getCurrentSession();
		String hql = "From Playlist where username = :user";
		Query query = session.createQuery(hql);
		query.setString("user", user);
		List<Playlist> list = query.list();
		return list;
	}
	
	// Lấy danh sách các bài hát yêu thích
	public List<Track> listLikeTracks(String user){
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
		model.addAttribute("artists",listArtist);
		model.addAttribute("playlists",playlist);
		return "audience/home";
	}
	
	// Lay 1 danh sach nhac theo 1 the loai
	public List<Track> listTracksGenre(String genre){
		Session session = factory.getCurrentSession();
		String hql = "From Track Where genre.type = :genre And status = 'pending' And isPublic = '0' ";
		Query query = session.createQuery(hql);
		query.setString("genre",genre);
		List<Track> list = query.list();
		return list;
	}
	
	//Lay 1 danh sach nhac theo 1 artist
	public List<Track> listTracksArtist(String username){
		Session session = factory.getCurrentSession();
		String hql = "From Track Where username = :username And status = 'pending' And isPublic = '0'";
		Query query = session.createQuery(hql);
		query.setString("username",username);
		List<Track> list = query.list();
		return list;
	}
	
	// Lay danh sach nhac cua 1 playlist
	public List<Track> listTracksPlaylist(String idPlaylist){
		Session session = factory.getCurrentSession();
		String hql = "from Track where id_track in (select track.id_track from ListTracks where playlist.id_playlist = :idPlaylist)";
		Query query = session.createQuery(hql);
		query.setString("idPlaylist", idPlaylist);
		List<Track> list = query.list();
		return list;
	}
	
	// Lấy danh sách các thể loại nhạc
	public List<Genre> listGenre(){
		Session session = factory.getCurrentSession();
		String hql = "From Genre";
		Query query = session.createQuery(hql);
		List<Genre> list = query.list();
		return list;
	}
	
	// Lấy danh sách các nghệ sĩ
	public List<User> listUser(){
		Session session = factory.getCurrentSession();
		String hql = "From User Where permission = 'Artist' ";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
	}
	// Lấy danh sách các bài hát
	public List<Track> listTracks(){
		Session session = factory.getCurrentSession();
		String hql = "From Track";
		Query query = session.createQuery(hql);
		List<Track> list = query.list();
		return list;
	}
	// Thêm một playlist	
	@RequestMapping(value="/addPlaylist" , method = RequestMethod.POST)
	public String addPlaylist(HttpServletRequest request,ModelMap model) {
		Playlist playlist = new Playlist();
		playlist.setName(request.getParameter("namePlaylist"));
		playlist.setUser(LoginController.user);
		addPlaylist(playlist);
		return homepage(model) ;
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
	
	@RequestMapping(value="/genre",method=RequestMethod.POST)
	public String showGenrePlaylist(HttpServletRequest request,ModelMap model) {
		String genre = request.getParameter("nameGenre");
		List<Track> list = listTracksGenre(genre);
		List <Playlist> playlist = playlists(LoginController.user.getUsername());
		model.addAttribute("playlistShow",list);
		model.addAttribute("namePlaylist",genre);
		model.addAttribute("playlists",playlist);
		return "audience/lib";
	}
	@RequestMapping(value="/artist",method=RequestMethod.POST)
	public String showArtistPlaylist(HttpServletRequest request,ModelMap model) {
		String username = request.getParameter("idArtist");
		String fullname = request.getParameter("fullnameArtist");
		List<Track> list = listTracksArtist(username);
		List <Playlist> playlist = playlists(LoginController.user.getUsername());
		model.addAttribute("playlistShow",list);
		model.addAttribute("namePlaylist",fullname);
		model.addAttribute("playlists",playlist);
		return "audience/lib";
	}
	@RequestMapping(value="/search",method=RequestMethod.GET)
	public String showArtistPlaylist(ModelMap model) {
		List <Playlist> playlist = playlists(LoginController.user.getUsername());
		List<Track> tracks = listTracks();
		model.addAttribute("playlists",playlist);
		model.addAttribute("tracks", tracks);
		return "audience/search";
	}
}
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
		List <LikedTracks> likedtracks = listLikeTracks(user);
		model.addAttribute("playlists",playlist);
		model.addAttribute("likedTracks", likedtracks);
		return "audience/library";
	}
	
	// Show một playlist
	@RequestMapping(value="/library/{id_playlist}",params = "linkEdit")
	public String showAPlaylist(ModelMap model,
			@PathVariable("id_playlist") long id) {
		System.out.println(id);
		List<Track> list = listTracksPlaylist(id);
		model.addAttribute("playlist",list);
		return "audience/listTracks";
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
	public List<LikedTracks> listLikeTracks(String user){
		Session session = factory.getCurrentSession();
		String hql = "From LikedTracks Where username = :user";
		Query query = session.createQuery(hql);
		query.setString("user", user);
		List<LikedTracks> list = query.list();
		return list;
	}
	
	// Show view home của audience
	@RequestMapping(value = "home", method = RequestMethod.POST)
	public String homepage(ModelMap model) {
		return "audience/home";
	}
	
	// Lay 1 danh sach nhac theo 1 the loai
	public List<Track> listTracksGenre(String genre){
		Session session = factory.getCurrentSession();
		String hql = "From Track Where genre = :genre And status = 'fulfill' And isPublic = '1' ";
		Query query = session.createQuery(hql);
		query.setString("genre",genre);
		List<Track> list = query.list();
		return list;
	}
	
	//Lay 1 danh sach nhac theo 1 artist
	public List<Track> listTracksArtist(String username){
		Session session = factory.getCurrentSession();
		String hql = "From Track Where username = :username And status = 'fulfill' And isPublic = '1'";
		Query query = session.createQuery(hql);
		query.setString("username",username);
		List<Track> list = query.list();
		return list;
	}
	
	// Lay danh sach nhac cua 1 playlist
	public List<Track> listTracksPlaylist(long idPlaylist){
		Session session = factory.getCurrentSession();
		String hql = "from Track where id_track in (select track.id_track from ListTracks where playlist.id_playlist = :idPlaylist)";
		Query query = session.createQuery(hql);
		query.setLong("idPlaylist", idPlaylist);
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
		String hql = "From User Where ";
		Query query = session.createQuery(hql);
		List<User> list = query.list();
		return list;
	}
	
	// Thêm một playlist
	@RequestMapping(value="/library/addPlaylist",method = RequestMethod.GET)
	public String addPlaylist() {
		return "audience/addPlaylist";
	}
	
	@RequestMapping(value="/library/addplaylist" , method = RequestMethod.POST)
	public String addPlaylist(HttpServletRequest request) {
		Playlist playlist = new Playlist();
		playlist.setName(request.getParameter("namePlaylist"));
		addPlaylist(playlist);
		return "audience/library";
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
}
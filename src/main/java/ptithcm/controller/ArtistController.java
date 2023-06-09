package ptithcm.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;

import ptithcm.entity.Genre;
import ptithcm.entity.History;
import ptithcm.entity.InformationTrack;
import ptithcm.entity.ListTracks;
import ptithcm.entity.Playlist;
import ptithcm.entity.Track;
import ptithcm.entity.User;

@Controller
@RequestMapping("/artist/")
@Transactional
public class ArtistController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	List<User>artistList=null;
	
	//Tải dữ liệu
	public List<Playlist> getAlbumList() {
		Session session = factory.getCurrentSession();
		String hql = "from Playlist where user.username=:username";
		Query query = session.createQuery(hql);
		query.setParameter("username", LoginController.user.getUsername());
		List<Playlist> list = query.list();
		return list;
	}
	public Playlist getAlbum(Long id_playlist) {
		Session session = factory.getCurrentSession();
		String hql = "from Playlist where id_playlist=:id_playlist";
		Query query = session.createQuery(hql);
		query.setParameter("id_playlist", id_playlist);
		Playlist list = (Playlist)query.list().get(0);
		return list;
	}
	public List<Track> getTrackList() {
		Session session = factory.getCurrentSession();
		String hql = "from Track where user.username=:username and status='fulfill'";
		Query query = session.createQuery(hql);
		query.setParameter("username", LoginController.user.getUsername());
		List<Track> list = query.list();
		return list;
	}
//	public Track getTrack(Long id_track) {
//		Session session=factory.getCurrentSession();
//		Track track=(Track)session.get(Track.class, id_track);
//		return track;
//	}
	
	public Track getTrack(Long id_track) {
		Session session = factory.getCurrentSession();
		String hql = "from Track where id_track=:id_track";
		Query query = session.createQuery(hql);
		query.setParameter("id_track", id_track);
		Track list = (Track)query.list().get(0);
		return list;
	}
	
	public List<Track> getTrackAlbum(Long id_playlist) {
		Session session = factory.getCurrentSession();
		String hql = "from Track where user.username=:username and id_track in "
				+ "(select track.id_track from ListTracks where playlist.id_playlist=:id_playlist)";
		Query query = session.createQuery(hql);
		query.setParameter("username", LoginController.user.getUsername());
		query.setParameter("id_playlist", id_playlist);
		List<Track> list = query.list();
		return list;
	}
	public List<Track> getNotTrackAlbum(Long id_playlist) {
		Session session = factory.getCurrentSession();
		//Thêm đk status='fulfill'
		String hql = "from Track where user.username=:username and status='fulfill' and id_track not in "
				+ "(select track.id_track from ListTracks where playlist.id_playlist=:id_playlist)";
		Query query = session.createQuery(hql);
		query.setParameter("username", LoginController.user.getUsername());
		query.setParameter("id_playlist", id_playlist);
		List<Track> list = query.list();
		return list;
	}
	public ListTracks getListTracks(Long id_track, Long id_playlist) {
		Session session = factory.getCurrentSession();
		String hql = "from ListTracks where id_track=:id_track and id_playlist=:id_playlist";
		Query query = session.createQuery(hql);
		query.setParameter("id_track", id_track);
		query.setParameter("id_playlist", id_playlist);
		ListTracks list = (ListTracks)query.list().get(0);
		return list;
	}
	@ModelAttribute("genreList")
	public List<Genre> getGenreList() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Genre";
		Query query = session.createQuery(hql);
		List<Genre> list = query.list();
		return list;
	}
	@ModelAttribute("artists")
	public List<User> getArtists(){
		Session session = factory.getCurrentSession();
		String hql = "FROM User where permission='Artist' and username <>:artist";
		Query query = session.createQuery(hql);
		query.setParameter("artist", LoginController.user.getUsername());
		List<User> list = query.list();
		return list;
	}
	public User getArtist(String username) {
		Session session = factory.getCurrentSession();
		User user = (User)session.get(User.class, username);
		return user;
	}
	
	public List<User> getFollowers(){
		if(LoginController.user==null)return null;
		Session session = factory.getCurrentSession();
		String id_artist=LoginController.user.getUsername();
		String hql = "from User where username in (select user.username from Followers where artist.username=:id_artist)";
		Query query = session.createQuery(hql);
		query.setParameter("id_artist",id_artist);
		List<User> list = query.list();
		return list;
	}
	
	public Long countFollowers() {
		Session session = factory.getCurrentSession();
		String id_artist=LoginController.user.getUsername();
		String hql = "select count(*) from Followers where artist.username=:id_artist";
		Query query = session.createQuery(hql);
		query.setParameter("id_artist",id_artist);
		Long count=(Long)query.uniqueResult();
		return count;
	}
	
	
	
	//views
	@RequestMapping("/home")
	public String getHome(ModelMap model) {
		model.addAttribute("follow",countFollowers().toString());
		return"artist/home";
	}
	public int insert(Object object) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(object);
			t.commit();
		} catch (Exception e) {
			System.out.println(e.getMessage());
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
	
	public int update(Object object) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(object);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			System.out.println(e.getMessage());
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	
	public int merge(Object object) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.merge(object);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			System.out.println(e.getMessage());
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	
	public int delete(Long id_playlist) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String hql = "DELETE FROM ListTracks WHERE id_playlist=:id_playlist";
			Query query = session.createQuery(hql);
			query.setParameter("id_playlist", id_playlist);
			query.executeUpdate();
			Playlist album=getAlbum(id_playlist);
			session.delete(album);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	
	public int addTrack(Track track) {
		if(LoginController.user==null) {
			System.out.println("Error LoginController!!!");
			return 0;
		}
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			
			track.setUser(LoginController.user);
			session.save(track);
			Track temp=(Track)session.get(Track.class, track.getId_track());
			
			//Thêm bản thân nghệ sĩ
			InformationTrack x= new InformationTrack(temp, LoginController.user);
			session.save(x);
			for(User artist:artistList) {
				x=new InformationTrack(temp,artist);
				session.save(x);
			}
			t.commit();
		} catch (Exception e) {
			t.rollback();
			System.out.println(e.getMessage());
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}
	
	@RequestMapping(value = "/submitTrack", method=RequestMethod.GET)
	public String formSubmit(ModelMap model) {
		Track newTrack=new Track();
		if(artistList==null)artistList=new ArrayList<User>();
		if(!artistList.isEmpty())artistList.removeAll(artistList);
		model.addAttribute("track", newTrack);
		model.addAttribute("btnStatus", "btnSubmit");
		model.addAttribute("artistList", artistList);
		return "artist/submitTrack";
	}
	@RequestMapping(value = "/submitTrack", params="btnSubmit",method=RequestMethod.POST)
	public String submit(ModelMap model, @Validated @ModelAttribute("track")Track track, BindingResult errors,
			@RequestParam("photo")MultipartFile photo,@RequestParam("music")String music) {
		if(!photo.getOriginalFilename().isEmpty()) {
		try {
			String photoPath=context.getRealPath("/resources/img/track/"+photo.getOriginalFilename());
			System.out.println(photoPath);
				photo.transferTo(new File(photoPath));
				track.setImage(photo .getOriginalFilename());
			}
			catch(Exception e) {
				errors.rejectValue("image", "track", "save error!");
			}
		}else track.setImage(null);
		if(!music.isEmpty()) {
	           track.setPath(music);
	        
		}else errors.rejectValue("path", "track", "Please choose music");
		if(!errors.hasErrors()) {
			model.addAttribute("btnStatus", "btnConfirm");
		}
		else{
			model.addAttribute("message", "input error!");
			model.addAttribute("btnStatus", "btnSubmit");
		}
		model.addAttribute("artistList", artistList);
		return "artist/submitTrack";
	}
	@RequestMapping(value = "/submitTrack/{id_artist}", params="linkAdd")
	public String addArtist(ModelMap model,@ModelAttribute("track")Track track,
			@PathVariable("id_artist")String id_artist) {
		User artist=getArtist(id_artist);
		if(!artistList.contains(artist))artistList.add(artist);
		model.addAttribute("btnStatus", "btnSubmit");
		model.addAttribute("artistList", artistList);
		return "artist/submitTrack";
	}
	@RequestMapping(value = "/submitTrack/{id_artist}", params="linkDelete")
	public String deleteArtist(ModelMap model,@ModelAttribute("track")Track track,
			@PathVariable("id_artist")String id_artist) {
		
		
		User artist=getArtist(id_artist);
		if(artistList.contains(artist))artistList.remove(artist);
		model.addAttribute("btnStatus", "btnSubmit");
		model.addAttribute("artistList", artistList);
		return "artist/submitTrack";
	}
	@RequestMapping(value = "/submitTrack", params="btnConfirm",method=RequestMethod.POST)
	public String confirmSubmit(ModelMap model, @ModelAttribute("track")Track track) {
		if(track.getImage().isBlank())track.setImage(null);
		int check=addTrack(track);
		if(check==1) {
			model.addAttribute("message", "submit successfully");
			Track newTrack=new Track();
			model.addAttribute("track", newTrack);
			model.addAttribute("btnStatus", "btnSubmit");
			if(!artistList.isEmpty())artistList.removeAll(artistList);
		}
		else {
			model.addAttribute("message","submit failed");
			model.addAttribute("btnStatus", "btnSubmit");
		}
		return "artist/submitTrack";
	}
	
	@RequestMapping(value="/index/track/{id_track}",params="linkEdit")
	public String editTrack(ModelMap model,@PathVariable("id_track")Long id_track , @ModelAttribute("album")Playlist album) {
		Track track=getTrack(id_track);
		
		if(track!=null) {
			if(track.getIsPublic()) {
				track.setIsPublic(false);
				int result=this.merge(track);
				if(result==1)model.addAttribute("message", "hidden successfully");
				else model.addAttribute("message", "hidden fail!!!");
			}
			else {
				track.setIsPublic(true);
				int result=this.merge(track);
				if(result==1)model.addAttribute("message", "show successfully");
				else model.addAttribute("message", "show fail!!!");
			}
		}
		else model.addAttribute("message", "get track failed");
		List<Playlist>albumList=getAlbumList();
		List<Track>trackList=getTrackList();
		model.addAttribute("albumList",albumList);
		model.addAttribute("trackList", trackList);
		return"artist/index";
	}
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public String album(ModelMap model) {
		List<Playlist>albumList=getAlbumList();
		List<Track>trackList=getTrackList();
		Playlist playlist=new Playlist();
		playlist.setUser(LoginController.user);
		model.addAttribute("album", playlist);
		model.addAttribute("albumList",albumList);
		model.addAttribute("trackList", trackList);
		model.addAttribute("btnStatus", "btnAdd");
		return"artist/index";
	}
	@RequestMapping(value="/index", params="btnAdd")
	public String addAlbum(ModelMap model,@Validated @ModelAttribute("album")Playlist album, BindingResult errors,
			@RequestParam("photo")MultipartFile photo) {
		if(!photo.getOriginalFilename().isEmpty()) {
			try {
				String photoPath=context.getRealPath("/resources/img/album/"+photo.getOriginalFilename());
					photo.transferTo(new File(photoPath));
					album.setImage(photo .getOriginalFilename());
				}
				catch(Exception e) {
					errors.rejectValue("image", "track", "save error!");
				}
			}else album.setImage(null);
		if(!errors.hasErrors())
		{
			int check=insert(album);
			if(check==1) {
				Playlist playlist=new Playlist();
				playlist.setUser(LoginController.user);
				model.addAttribute("album", playlist);
				model.addAttribute("message", "Add album successfully");
			}
			else model.addAttribute("message", "Add album failed!");
		}
		else model.addAttribute("message","input error!");
		List<Playlist>albumList=getAlbumList();
		List<Track>trackList=getTrackList();;
		model.addAttribute("albumList",albumList);
		model.addAttribute("trackList", trackList);
		model.addAttribute("btnStatus", "btnAdd");
		return"artist/index";
	}
	
	@RequestMapping(value="/index/album/{id_playlist}",params="linkEdit")
	public String editAlbum(ModelMap model,@PathVariable("id_playlist")Long id_playlist ) {
		Playlist album=getAlbum(id_playlist);
		
		if(album!=null) {
			if(album.getIsPublic()) {
				album.setIsPublic(false);
				int result=this.update(album);
				if(result==1)model.addAttribute("message", "hidden successfully");
				else model.addAttribute("message", "hidden fail!!!");
			}
			else {
				album.setIsPublic(true);
				int result=this.update(album);
				if(result==1)model.addAttribute("message", "show successfully");
				else model.addAttribute("message", "show fail!!!");
			}
		}
		else model.addAttribute("message", "get album failed");
		Playlist playlist=new Playlist();
		playlist.setUser(LoginController.user);
		model.addAttribute("album", playlist);
		List<Playlist>albumList=getAlbumList();
		List<Track>trackList=getTrackList();
		model.addAttribute("albumList",albumList);
		model.addAttribute("trackList", trackList);
		model.addAttribute("btnStatus","btnAdd");
		return"artist/index";
	}
	@RequestMapping(value="/index/album/{id_playlist}",params="linkDelete")
	public String deleteAlbum(ModelMap model,@PathVariable("id_playlist")Long id_playlist ) {
		
		int check=delete(id_playlist);
		if(check==1) {
			model.addAttribute("message", "Delete Successfully");
		}
		else model.addAttribute("message", "Delete Failed!");
		List<Playlist>albumList=getAlbumList();
		List<Track>trackList=getTrackList();
		Playlist playlist=new Playlist();
		playlist.setUser(LoginController.user);
		model.addAttribute("album", playlist);
		model.addAttribute("albumList",albumList);
		model.addAttribute("trackList", trackList);
		model.addAttribute("btnStatus","btnAdd");
		return"artist/index";
	}
	@RequestMapping(value="/index/album/{id_playlist}",params="linkShowAlbum")
	public String showAlbum(ModelMap model,@PathVariable("id_playlist")Long id_playlist ) {
		String name=getAlbum(id_playlist).getName();
		List<Track>trackAlbum=getTrackAlbum(id_playlist);
		List<Track>notTrackAlbum=getNotTrackAlbum(id_playlist);
		model.addAttribute("name", name);
		model.addAttribute("id_playlist", id_playlist);
		model.addAttribute("trackAlbum", trackAlbum);
		model.addAttribute("notTrackAlbum", notTrackAlbum);
		return"artist/album";
	}
	@RequestMapping(value="/index/album/{id_playlist}/{id_track}",params="linkDown")
	public String downTrack(ModelMap model,@PathVariable("id_playlist")Long id_playlist,
			@PathVariable("id_track")Long id_track, HttpServletRequest request) {
		String name=getAlbum(id_playlist).getName();
		ListTracks listTracks=getListTracks(id_track,id_playlist);
		int check=delete(listTracks);
		if(check==1) {
			model.addAttribute("message", "Down successfully");
		}
		else model.addAttribute("message", "Down failed!");
		List<Track>trackAlbum=getTrackAlbum(id_playlist);
		List<Track>notTrackAlbum=getNotTrackAlbum(id_playlist);
		model.addAttribute("name", name);
		model.addAttribute("id_playlist", id_playlist);
		model.addAttribute("trackAlbum", trackAlbum);
		model.addAttribute("notTrackAlbum", notTrackAlbum);
		return"artist/album";
	}
	@RequestMapping(value="/index/album/{id_playlist}/{id_track}",params="linkUp")
	public String upTrack(ModelMap model,@PathVariable("id_playlist")Long id_playlist,
			@PathVariable("id_track")Long id_track, HttpServletRequest request) {
		String name=getAlbum(id_playlist).getName();
		ListTracks listTracks=new ListTracks();
		listTracks.setPlaylist(getAlbum(id_playlist));
		listTracks.setTrack(getTrack(id_track));
		int check=insert(listTracks);
		if(check==1) {
			model.addAttribute("message", "Up successfully");
		}
		else model.addAttribute("message", "Up failed!");
		List<Track>trackAlbum=getTrackAlbum(id_playlist);
		List<Track>notTrackAlbum=getNotTrackAlbum(id_playlist);
		model.addAttribute("name", name);
		model.addAttribute("id_playlist", id_playlist);
		model.addAttribute("trackAlbum", trackAlbum);
		model.addAttribute("notTrackAlbum", notTrackAlbum);
		return"artist/album";
	}

	@RequestMapping(value="followers")
	public String getFollowersPage(ModelMap model) {
		model.addAttribute("follow", countFollowers().toString());
		model.addAttribute("followers", getFollowers());
		return "artist/followers";
	}
}
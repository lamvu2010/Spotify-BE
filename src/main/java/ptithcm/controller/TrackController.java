package ptithcm.controller;

import java.io.File;
import java.util.Base64;
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
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ptithcm.entity.Genre;
import ptithcm.entity.Track;

@Controller
@RequestMapping("/track/")
@Transactional
public class TrackController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	@ModelAttribute("genreList")
	public List<Genre> getGenreList() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Genre";
		Query query = session.createQuery(hql);
		List<Genre> list = query.list();
		return list;
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
	
	@RequestMapping(value = "/submit", method=RequestMethod.GET)
	public String formSubmit(ModelMap model) {
		Track newTrack=new Track();
		newTrack.setUser(LoginController.user);
		model.addAttribute("track", newTrack);
		model.addAttribute("btnStatus", "btnSubmit");model.addAttribute("btnStatus", "btnSubmit");
		return "track/submit";
	}
	@RequestMapping(value = "/submit", params="btnSubmit",method=RequestMethod.POST)
	public String submit(ModelMap model, @Validated @ModelAttribute("track")Track track, BindingResult errors,
			@RequestParam("photo")MultipartFile photo,@RequestParam("music")String music) {
		if(!photo.getOriginalFilename().isEmpty()) {
		try {
			String photoPath=context.getRealPath("/resources/img/track/"+photo.getOriginalFilename());
				photo.transferTo(new File(photoPath));
				track.setImage(photo .getOriginalFilename());
			}
			catch(Exception e) {
				errors.rejectValue("image", "track", "Lỗi lưu hình");
			}
		}else track.setImage(null);
		if(!music.isEmpty()) {
	           track.setPath(music);
	           System.out.println(track.getPath());
	        
		}else errors.rejectValue("path", "track", "Vui lòng chọn nhạc");
		if(!errors.hasErrors()) {
			model.addAttribute("btnStatus", "btnConfirm");
		}
		else{
			model.addAttribute("message", "Lỗi input");
			model.addAttribute("btnStatus", "btnSubmit");
		}
		return "track/submit";
	}
	@RequestMapping(value = "/submit", params="btnConfirm",method=RequestMethod.POST)
	public String confirmSubmit(ModelMap model, @ModelAttribute("track")Track track) {
		int check=insert(track);
		if(check==1) {
			model.addAttribute("message", "Nộp thành công");
			Track newTrack=new Track();
			newTrack.setUser(LoginController.user);
			model.addAttribute("track", newTrack);
			model.addAttribute("btnStatus", "btnSubmit");
		}
		else {
			model.addAttribute("message","Nộp thất bại");
			model.addAttribute("btnStatus", "btnSubmit");
		}
		return "track/submit";
	}
}
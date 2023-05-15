package ptithcm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {
	@RequestMapping("admin")
	public String getAdmin() {
		return"user/manage";
	}
	@RequestMapping("audience")
	public String getAudience() {
		return"user/manage";
	}
	@RequestMapping("artist")
	public String getArtist() {
		return"user/manage";
	}
}

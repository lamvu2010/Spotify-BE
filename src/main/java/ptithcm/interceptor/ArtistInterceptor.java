package ptithcm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ArtistInterceptor extends HandlerInterceptorAdapter  {
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("permission")==null||!session.getAttribute("permission").equals("Artist")){
			response.sendRedirect("http://localhost:8080/Spotify/home/login.htm");
			return false;
		}
		return true;
	}
}

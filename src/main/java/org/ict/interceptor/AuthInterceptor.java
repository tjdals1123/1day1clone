package org.ict.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class AuthInterceptor extends HandlerInterceptorAdapter{
	
	private void saveDest(HttpServletRequest req) {
		
		String uri = req.getRequestURI();
		
		String query = req.getQueryString();
		
		if(query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}
		
		if(req.getMethod().equals("GET")) {
			log.info("dest: " + (uri + query));
			req.getSession().setAttribute("dest", uri + query);
		}
	}
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("login")==null) {
			
			log.info("current user id not logined");
			
			saveDest(request);
			
			response.sendRedirect("/user/login");
			return false;
		}
		
		return true;
	}
	
	

	
}

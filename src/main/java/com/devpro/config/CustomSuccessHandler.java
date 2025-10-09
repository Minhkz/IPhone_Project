package com.devpro.config;

import com.devpro.models.User;
import com.devpro.service.impl.EmailService;
import com.devpro.service.impl.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;


public class CustomSuccessHandler implements AuthenticationSuccessHandler {
    @Autowired
    private UserService userService;

    @Autowired
    private EmailService emailService;


    protected String determineTargetUrl(final Authentication authentication) {

        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_USER", "/client/homes");
        roleTargetUrlMap.put("ROLE_ADMIN", "/admin");
        roleTargetUrlMap.put("ROLE_STAFF", "/admin/orders");

        final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (final GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            if (roleTargetUrlMap.containsKey(authorityName)) {
                return roleTargetUrlMap.get(authorityName);
            }
        }

        throw new IllegalStateException();
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request, Authentication authentication) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);

        String username = authentication.getName();
        User user = userService.getUserByUsername(username);
        if (user != null) {
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("avatar", user.getAvatar());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("id", user.getId());
            session.setAttribute("role", user.getRole().getName().toString().trim());
            int sum = 0;
            if (user.getCart() != null && user.getCart().getSum() != null) {
                sum = user.getCart().getSum();
            }
            session.setAttribute("sum", sum);
            emailService.sendLoginSuccessEmail(user.getEmail(), user.getFullName());
        }else {
            user = userService.getUserByEmail(username);
            if (user != null) {
                session.setAttribute("fullName", user.getFullName());
                session.setAttribute("avatar", user.getAvatar());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("id", user.getId());
                session.setAttribute("role", user.getRole().getName().toString().trim());
                int sum = 0;
                if (user.getCart() != null && user.getCart().getSum() != null) {
                    sum = user.getCart().getSum();
                }
                emailService.sendLoginSuccessEmail(user.getEmail(), user.getFullName());
            }
        }


    }

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        String targetUrl = determineTargetUrl(authentication);
        if (response.isCommitted()) {

            return;
        }

        redirectStrategy.sendRedirect(request, response, targetUrl);
        clearAuthenticationAttributes(request, authentication);

    }
}

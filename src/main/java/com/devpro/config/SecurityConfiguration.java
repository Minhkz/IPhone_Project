package com.devpro.config;

import com.devpro.service.CustomUserDetailsService;
import com.devpro.service.impl.RoleService;
import com.devpro.service.impl.UserService;
import com.devpro.service.userinfo.CustomOAuth2UserService;
import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;



@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(UserService userService) {
        return new CustomUserDetailsService(userService);
    }

    @Bean
    public SpringSessionRememberMeServices rememberMeServices() {
        SpringSessionRememberMeServices rememberMeServices = new SpringSessionRememberMeServices();

        rememberMeServices.setAlwaysRemember(true);

        return rememberMeServices;
    }

    @Bean
    public CustomSuccessHandler customSuccessHandler() {
        return new CustomSuccessHandler();
    }

    @Bean
    public DaoAuthenticationProvider authProvider(
            PasswordEncoder passwordEncoder,
            UserDetailsService userDetailsService) {

        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        authProvider.setHideUserNotFoundExceptions(false);

        return authProvider;
    }

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http, UserService userService) throws Exception {
        // v6. lamda
        http
                .authorizeHttpRequests(authorize -> authorize
                        .dispatcherTypeMatchers(DispatcherType.FORWARD,
                                DispatcherType.INCLUDE)
                        .permitAll()

                        .requestMatchers("/client/homes/**", "/products/**", "/signup/**", "/admin/images/**",
                                "/client/**", "/css/**", "/js/**", "/images/**", "/", "/admin/css/**", "/admin/assets/**"
                        , "/admin/js/**")
                        .permitAll()
                        .requestMatchers("/admin/orders/**", "/admin/reviews/**", "/admin").hasAnyRole("STAFF", "ADMIN")
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated())
                .oauth2Login(oauth2 -> oauth2
                        .loginPage("/client/homes/signin")
                        .successHandler(customSuccessHandler())
                        .failureUrl("/signin?error")
                        .userInfoEndpoint(user -> user
                                .userService(new CustomOAuth2UserService(userService)))
                )




                .sessionManagement((sessionManagement) -> sessionManagement
                        .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
                        .invalidSessionUrl("/signin?expired")
                        .maximumSessions(1)
                        .maxSessionsPreventsLogin(false))

                .logout(logout -> logout.deleteCookies("JSESSIONID").invalidateHttpSession(true))

                .rememberMe(r -> r.rememberMeServices(rememberMeServices()))
                .formLogin(formLogin -> formLogin
                        .loginPage("/client/homes/signin")
                        .failureUrl("/client/homes/signin?error")
                        .successHandler(customSuccessHandler())
                        .permitAll());
                http.exceptionHandling(ex -> ex.accessDeniedPage("/error/403"));

        return http.build();
    }

}

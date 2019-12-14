package com.github.rkruk.findmenow.controllers;

import com.github.rkruk.findmenow.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/register")
public class RegisterPageController {

    private UserService userService;

    @Autowired
    public RegisterPageController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public String showRegisterPage() {
        return "/WEB-INF/views/register-page.jsp";
    }

    @PostMapping
    public String createUser(String username, String password, String firstName, String lastName) {
        userService.registerUser(username, password, firstName, lastName, true, "ROLE_USER", null);
        return "redirect:/login";
    }
}

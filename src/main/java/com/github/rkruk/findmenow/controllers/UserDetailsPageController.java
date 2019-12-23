package com.github.rkruk.findmenow.controllers;

import com.github.rkruk.findmenow.dtos.PlaceDTO;
import com.github.rkruk.findmenow.dtos.UserDTO;
import com.github.rkruk.findmenow.services.PlaceService;
import com.github.rkruk.findmenow.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user-details")
public class UserDetailsPageController {

    private UserService userService;
    private PlaceService placeService;

    public UserDetailsPageController(UserService userService,
                                     PlaceService placeService) {
        this.userService = userService;
        this.placeService = placeService;
    }

    @GetMapping
    public String showUserDetailsPage(Model model,
                                      Principal principal,
                                      Long id,
                                      @RequestParam(name = "tab", required = false, defaultValue = "0") Long activeTab) {
        String loggedUserUsername = principal.getName();
        Long loggedUserId = userService.getIdOfLoggedUser(loggedUserUsername);
        UserDTO loggedUserDTO = userService.getOne(loggedUserId);
        UserDTO userDTO = userService.getOne(id);
        List<PlaceDTO> placeDTOS = new ArrayList<>();
        if (userDTO.getPlacesId() != null) {
            List<Long> placesId = userDTO.getPlacesId();
            for (Long placeId : placesId) {
                placeDTOS.add(placeService.getPlaceDTOById(placeId));
            }
        }
        model.addAttribute("activeTab", activeTab);
        model.addAttribute("loggedUserDTO", loggedUserDTO);
        model.addAttribute("userDTO", userDTO);
        model.addAttribute("placeDTOS", placeDTOS);
        return "/WEB-INF/views/user-panel.jsp";
    }
}

package com.github.rkruk.findmenow.controllers;

import com.github.rkruk.findmenow.dtos.PlaceDTO;
import com.github.rkruk.findmenow.dtos.SchemeDTO;
import com.github.rkruk.findmenow.dtos.UserDTO;
import com.github.rkruk.findmenow.services.PlaceService;
import com.github.rkruk.findmenow.services.SchemeService;
import com.github.rkruk.findmenow.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user-panel")
public class UserPanelPageController {

    private UserService userService;
    private PlaceService placeService;
    private SchemeService schemeService;


    @Autowired
    public UserPanelPageController(UserService userService, PlaceService placeService, SchemeService schemeService) {
        this.userService = userService;
        this.placeService = placeService;
        this.schemeService = schemeService;
    }

    @GetMapping
    public String showUserPanelPage(Model model,
                                    Principal principal,
                                    Long id,
                                    @RequestParam(name = "tab", required = false, defaultValue = "0") Long activeTab) {
        String loggedUserUsername = principal.getName();
        Long loggedUserId = userService.getIdOfLoggedUser(loggedUserUsername);
        UserDTO loggedUserDTO = userService.getOne(loggedUserId);
        UserDTO userDTO = null;
        if (id != null) {
            userDTO = userService.getOne(id);
        } else {
            userDTO = loggedUserDTO;
        }
        List<PlaceDTO> placeDTOS = new ArrayList<>();
        if (userDTO.getPlacesId() != null) {
            List<Long> placesId = userDTO.getPlacesId();
            for (Long placeId : placesId) {
                placeDTOS.add(placeService.getPlaceDTOById(placeId));
            }
        }
        model.addAttribute("loggedUserDTO", loggedUserDTO);
        model.addAttribute("userDTO", userDTO);
        model.addAttribute("activeTab", activeTab);
        model.addAttribute("placeDTOS", placeDTOS);
        return "/WEB-INF/views/user-panel.jsp";
    }

    @GetMapping("/deactivate-user")
    public String deactivateUser(Principal principal,
                                 Long id) {
        String username = principal.getName();
        Long loggedUserId = userService.getIdOfLoggedUser(username);
        if (loggedUserId.equals(id)) {
            userService.deactivateUser(id);
        }
        else {
            return "redirect:/";
        }
        return "redirect:/logout";
    }

    @GetMapping("/take-place")
    public String showTakePlacePage(Model model,
                                    @RequestParam(required = false, defaultValue = "0", name = "id") Long visibleSchemeId) {
        List<SchemeDTO> allActiveSchemeDTOS = schemeService.getAllActiveSchemeDTOs();
        model.addAttribute("allActiveSchemeDTOS", allActiveSchemeDTOS);
        if (visibleSchemeId.equals(0L) && allActiveSchemeDTOS.size() > 0) {
            visibleSchemeId = allActiveSchemeDTOS.get(0).getId();
        }
        model.addAttribute("visibleSchemeId", visibleSchemeId);
        List<PlaceDTO> availablePlaceDTOS = placeService.getAllFreePlaceDTOBySchemeId(visibleSchemeId);
        model.addAttribute("availablePlaceDTOS", availablePlaceDTOS);
        return "/WEB-INF/views/take-place.jsp";
    }

    @PostMapping("/take-place")
    public String takePlace(Principal principal, Long placeId) {
        PlaceDTO placeDTO = placeService.getPlaceDTOById(placeId);
        String username = principal.getName();
        Long id = userService.getIdOfLoggedUser(username);
        UserDTO userDTO = userService.getOne(id);
        userService.bookPlaceForUser(userDTO, placeDTO);
        return "redirect:/user-panel";
    }
}

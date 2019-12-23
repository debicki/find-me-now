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
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

@Controller
@RequestMapping("/")
public class DashboardPageController {

    private PlaceService placeService;
    private UserService userService;
    private SchemeService schemeService;


    @Autowired
    public DashboardPageController(PlaceService placeService, SchemeService schemeService, UserService userService) {
        this.placeService = placeService;
        this.schemeService = schemeService;
        this.userService = userService;
    }

    @GetMapping
    public String showDashboardPage(Model model,
                                    @RequestParam(required = false, defaultValue = "0", name = "id") Long visibleSchemeId,
                                    @RequestParam(required = false) String search) {
        List<SchemeDTO> allActiveSchemeDTOS = schemeService.getAllActiveSchemeDTOs();

        if (search == null || search.length() == 0) {
            model.addAttribute("activeSearch", false);
        } else {
            model.addAttribute("activeSearch", true);
        }

        if (search != null && search.length() > 0) {
            UserDTO userDTO = userService.getUserDTOByLastName(search);
            List<PlaceDTO> placeDTOS = new ArrayList<>();
            HashSet<Long> schemeIds = new HashSet<>();
            if (userDTO != null) {
                placeDTOS = placeService.getPlaceDTOSByUser(userDTO.getId());
                schemeIds = new HashSet<>();
                for (PlaceDTO placeDTO : placeDTOS) {
                    Long schemeId = placeDTO.getSchemeId();
                    schemeIds.add(schemeId);
                }
            }
            model.addAttribute("placeDTOS", placeDTOS);
            model.addAttribute("schemeIds", schemeIds);
            model.addAttribute("lastName", search);
        }

        model.addAttribute("allActiveSchemeDTOS", allActiveSchemeDTOS);
        if (visibleSchemeId.equals(0L) && allActiveSchemeDTOS.size() > 0) {
            visibleSchemeId = allActiveSchemeDTOS.get(0).getId();
        }
        model.addAttribute("visibleSchemeId", visibleSchemeId);

        return "/WEB-INF/views/dashboard.jsp";
    }

    @PostMapping
    public String userToBeFound(String search) {
        return "redirect:/?search=" + search;
    }
}

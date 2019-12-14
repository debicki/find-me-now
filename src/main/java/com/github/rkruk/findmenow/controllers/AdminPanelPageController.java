package com.github.rkruk.findmenow.controllers;

import com.github.rkruk.findmenow.dtos.PlaceDTO;
import com.github.rkruk.findmenow.dtos.SchemeDTO;
import com.github.rkruk.findmenow.dtos.UserDTO;
import com.github.rkruk.findmenow.services.PlaceService;
import com.github.rkruk.findmenow.services.SchemeService;
import com.github.rkruk.findmenow.services.StorageService;
import com.github.rkruk.findmenow.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin-panel")
public class AdminPanelPageController {

    private StorageService storageService;
    private SchemeService schemeService;
    private UserService userService;
    private PlaceService placeService;

    @Autowired
    public AdminPanelPageController(StorageService storageService,
                                    SchemeService schemeService,
                                    UserService userService, PlaceService placeService) {
        this.storageService = storageService;
        this.schemeService = schemeService;
        this.userService = userService;
        this.placeService = placeService;
    }

    @GetMapping
    public String showAdminPanelPage(Model model,
                                     @RequestParam(name = "tab", required = false, defaultValue = "0") Long tabNumber) {
        model.addAttribute("tabNumber", tabNumber);
        List<SchemeDTO> allSchemeDTOs = new ArrayList<>();
        List<UserDTO> allUserDTOs = new ArrayList<>();
        if (tabNumber == 0) {
            allSchemeDTOs = schemeService.getAllSchemeDTOs();
        } else if (tabNumber == 1) {
            allUserDTOs = userService.getAllUserDTOs();
        }
        model.addAttribute("allSchemeDTOs", allSchemeDTOs);
        model.addAttribute("allUserDTOs", allUserDTOs);
        return "/WEB-INF/views/admin-panel.jsp";
    }

    @GetMapping("/add-scheme")
    public String showSchemesAddingPage() {
        return "/WEB-INF/views/add-scheme.jsp";
    }

    @PostMapping("/add-scheme")
    public String storeFileWithScheme(String name, MultipartFile file, String description) {
        Long schemeId = storageService.storeFile(name, file, description).getId();
        return "redirect:/admin-panel/add-places?scheme=" + schemeId;
    }

    @GetMapping("/add-places")
    public String showPlacesAddingPage(Model model,
                                       @RequestParam(name = "scheme") Long schemeId) {
        List<PlaceDTO> allPlacesDTOs = placeService.getAllPlaceDTOsBySchemeId(schemeId);
        model.addAttribute("schemeId", schemeId);
        model.addAttribute("allPlacesDTOs", allPlacesDTOs);
        return "/WEB-INF/views/add-places.jsp";
    }

    @PostMapping("/add-places")
    public String addNewPlaceOnScheme(@RequestParam(name = "id") Long schemeId,
                                      String name,
                                      Long positionX,
                                      Long positionY) {
        placeService.addPlace(schemeId, name, positionX, positionY);
        return "redirect:/admin-panel/add-places?scheme=" + schemeId;
    }

    @GetMapping("/activate-scheme")
    public String activateScheme(Long id) {
        schemeService.activateScheme(id);
        return "redirect:/scheme-details?id=" + id;
    }

    @GetMapping("/deactivate-scheme")
    public String deactivateScheme(Long id) {
        schemeService.deactivateScheme(id);
        return "redirect:/scheme-details?id=" + id;
    }

    @GetMapping("/activate-user")
    public String activateUser(Long id) {
        userService.activateUser(id);
        return "redirect:/user-details?id=" + id;
    }

    @GetMapping("/deactivate-user")
    public String deactivateUser(Long id) {
        userService.deactivateUser(id);
        return "redirect:/user-details?id=" + id;
    }
}

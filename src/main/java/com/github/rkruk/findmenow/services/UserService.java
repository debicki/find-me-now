package com.github.rkruk.findmenow.services;

import com.github.rkruk.findmenow.dtos.PlaceDTO;
import com.github.rkruk.findmenow.dtos.UserDTO;
import com.github.rkruk.findmenow.models.Place;
import com.github.rkruk.findmenow.models.User;
import com.github.rkruk.findmenow.repositories.PlaceRepository;
import com.github.rkruk.findmenow.repositories.UserRepository;
import com.github.rkruk.findmenow.utils.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {

    private UserRepository userRepository;
    private ModelMapper modelMapper;
    private PasswordEncoder passwordEncoder;
    private PlaceRepository placeRepository;

    @Autowired
    public UserService(UserRepository userRepository, ModelMapper modelMapper, PasswordEncoder passwordEncoder, PlaceRepository placeRepository) {
        this.userRepository = userRepository;
        this.modelMapper = modelMapper;
        this.passwordEncoder = passwordEncoder;
        this.placeRepository = placeRepository;
    }

    public void registerUser(String username, String password, String firstName, String lastName, boolean active, String role, Place place) {
        userRepository.save(new User(username, passwordEncoder.encode(password), firstName, lastName, true, role, null));
    }

    public UserDTO getOne(Long id) {
        User user = userRepository.getOne(id);
        return modelMapper.convert(user);
    }

    public Long getIdOfLoggedUser(String username) {
        User user = userRepository.findByUsernameEquals(username);
        return user.getId();
    }

    public UserDTO getUserDTOByLastName(String lastName) {
        User user = userRepository.findByLastNameEquals(lastName);
        if (user == null) {
            return null;
        }
        return modelMapper.convert(user);
    }

    public List<UserDTO> getAllUserDTOs() {
        List<User> allUsers = userRepository.findAll();
        List<UserDTO> allUserDTOS = new ArrayList<>();
        for (User user : allUsers) {
            allUserDTOS.add(modelMapper.convert(user));
        }
        return allUserDTOS;
    }

    public void activateUser(Long id) {
        User user = userRepository.getOne(id);
        user.setActive(true);
        userRepository.save(user);
    }

    public void deactivateUser(Long id) {
        User user = userRepository.getOne(id);
        user.setActive(false);
        userRepository.save(user);
    }

    public List<PlaceDTO> getPlaceDTOListOfSearchedUser(String lastName) {
        User user = userRepository.findByLastNameEquals(lastName);
        List<Place> places = user.getPlaces();
        List<PlaceDTO> placesDTO = new ArrayList<>();
        for (Place place : places) {
            placesDTO.add(modelMapper.convert(place));
        }
        return placesDTO;
    }

    public void bookPlaceForUser(UserDTO userDTO, PlaceDTO placeDTO) {
        User user = userRepository.getOne(userDTO.getId());
        Place place = placeRepository.getOne(placeDTO.getId());
        List<Place> places = user.getPlaces();
        places.add(place);
        user.setPlaces(places);
        userRepository.save(user);
    }
}

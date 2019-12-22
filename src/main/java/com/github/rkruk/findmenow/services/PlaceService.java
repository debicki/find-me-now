package com.github.rkruk.findmenow.services;

import com.github.rkruk.findmenow.dtos.PlaceDTO;
import com.github.rkruk.findmenow.models.Place;
import com.github.rkruk.findmenow.models.User;
import com.github.rkruk.findmenow.repositories.PlaceRepository;
import com.github.rkruk.findmenow.repositories.SchemeRepository;
import com.github.rkruk.findmenow.repositories.UserRepository;
import com.github.rkruk.findmenow.utils.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PlaceService {

    private PlaceRepository placeRepository;
    private SchemeRepository schemeRepository;
    private UserRepository userRepository;
    private ModelMapper modelMapper;

    @Autowired
    public PlaceService(PlaceRepository placeRepository, SchemeRepository schemeRepository, UserRepository userRepository, ModelMapper modelMapper) {
        this.placeRepository = placeRepository;
        this.schemeRepository = schemeRepository;
        this.userRepository = userRepository;
        this.modelMapper = modelMapper;
    }


    public void addPlace(Long schemeId, String name, Long positionX, Long positionY) {
        placeRepository.save(new Place(name, "", schemeRepository.getOne(schemeId), positionX, positionY));
    }

    public List<PlaceDTO> getAllPlaceDTOsBySchemeId(Long id) {
        List<Place> allPlaces = placeRepository.findAll();
        List<PlaceDTO> allPlacesDTO = new ArrayList<>();
        for (Place place : allPlaces) {
            if (place.getScheme().getId().equals(id))
            allPlacesDTO.add(modelMapper.convert(place));
        }
        return allPlacesDTO;
    }

    public PlaceDTO getPlaceDTOById(Long id) {
        return modelMapper.convert(placeRepository.getOne(id));
    }

    public List<PlaceDTO> getAllFreePlaceDTOBySchemeId(Long schemeId) {

        List<Place> availablePlaces = placeRepository.findPlaceBySchemeId(schemeId);
        List<User> userOccupyingPlaces = userRepository.findAll();
        List<PlaceDTO> availablePlacesDTO = new ArrayList<>();
        for (User user : userOccupyingPlaces) {
            if (user.getPlaces() != null) {
                List<Place> places = user.getPlaces();
                for (Place place : places) {
                    availablePlaces.remove(placeRepository.getOne(place.getId()));
                }
            }
        }
        for (Place place : availablePlaces) {
            availablePlacesDTO.add(modelMapper.convert(place));
        }
        System.out.println(availablePlacesDTO.size());
        return availablePlacesDTO;
    }

    public PlaceDTO getPlaceDTOByName(String placeName) {
        Place place = placeRepository.findPlaceByName(placeName);
        return modelMapper.convert(place);
    }

    public List<PlaceDTO> getPlaceDTOSByUser(Long id) {
        User user = userRepository.getOne(id);
        List<Place> places = user.getPlaces();
        List<PlaceDTO> userPlacesDTO = new ArrayList<>();
        for (Place place : places) {
            PlaceDTO placeDTO = modelMapper.convert(place);
            userPlacesDTO.add(placeDTO);
        }
        return userPlacesDTO;
     }
}

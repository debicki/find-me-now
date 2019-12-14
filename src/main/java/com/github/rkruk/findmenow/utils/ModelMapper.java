package com.github.rkruk.findmenow.utils;

import com.github.rkruk.findmenow.dtos.PlaceDTO;
import com.github.rkruk.findmenow.dtos.SchemeDTO;
import com.github.rkruk.findmenow.dtos.UserDTO;
import com.github.rkruk.findmenow.models.Place;
import com.github.rkruk.findmenow.models.Scheme;
import com.github.rkruk.findmenow.models.User;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class ModelMapper {

    public SchemeDTO convert(Scheme scheme) {
        return new SchemeDTO(
                scheme.getId(),
                scheme.getName(),
                scheme.getFileName(),
                scheme.getDescription(),
                scheme.getActive());
    }

    public UserDTO convert(User user) {
        List<Long> placesId = new ArrayList<>();
        if (user.getPlaces() != null) {
            List<Place> places = user.getPlaces();
            for (Place place : places) {
                placesId.add(place.getId());
            }
        }
        return new UserDTO(
                user.getId(),
                user.getUsername(),
                user.getFirstName(),
                user.getLastName(),
                user.getActive(),
                user.getRole(),
                placesId);
    }

    public PlaceDTO convert(Place place) {
        Long schemeId = null;
        if (place.getScheme() != null) {
            schemeId = place.getScheme().getId();
        }
        return new PlaceDTO(
                place.getId(),
                place.getName(),
                place.getDescription(),
                place.getCoordinateX(),
                place.getCoordinateY(),
                schemeId);
    }
}

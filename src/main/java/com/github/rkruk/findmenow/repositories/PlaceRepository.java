package com.github.rkruk.findmenow.repositories;

import com.github.rkruk.findmenow.models.Place;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlaceRepository extends JpaRepository <Place, Long> {

    List<Place> findPlaceBySchemeId(Long schemeId);

    Place findPlaceByName(String name);
}

package com.github.rkruk.findmenow.dtos;

import java.util.Objects;

public class OccupiedPlaceInSchemeDTO {
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OccupiedPlaceInSchemeDTO that = (OccupiedPlaceInSchemeDTO) o;
        return Objects.equals(PlaceId, that.PlaceId) &&
                Objects.equals(SchemeId, that.SchemeId) &&
                Objects.equals(UserId, that.UserId);
    }

    public Long getPlaceId() {
        return PlaceId;
    }

    public void setPlaceId(Long placeId) {
        PlaceId = placeId;
    }

    public Long getSchemeId() {
        return SchemeId;
    }

    public void setSchemeId(Long schemeId) {
        SchemeId = schemeId;
    }

    public Long getUserId() {
        return UserId;
    }

    public void setUserId(Long userId) {
        UserId = userId;
    }

    private Long PlaceId;
    private Long SchemeId;
    private Long UserId;

}

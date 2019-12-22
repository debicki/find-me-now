package com.github.rkruk.findmenow.dtos;

import lombok.*;

@Getter
@Setter
@EqualsAndHashCode
@AllArgsConstructor
@ToString
public class PlaceDTO {

    private Long id;
    private String name;
    private String description;
    private Long coordinateX;
    private Long coordinateY;
    private Long schemeId;
}

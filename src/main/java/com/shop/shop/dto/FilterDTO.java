package com.shop.shop.dto;

import java.util.Set;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FilterDTO {

    private Set<String> brandList;
    private Set<String> sizeList;
    private Set<String> colorList;
    private Set<String> genderList;
    private Double maxPrice;
}

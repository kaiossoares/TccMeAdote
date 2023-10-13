package com.tccmeadote.meadote.controllers;

import com.tccmeadote.meadote.dto.AnimalTypesDTO;
import com.tccmeadote.meadote.dto.AnimalTypesResponse;
import com.tccmeadote.meadote.entities.AnimalTypes;
import com.tccmeadote.meadote.services.AnimalTypesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/animal-types")
public class AnimalTypesController {
    @Autowired
    private AnimalTypesService service;

    @GetMapping
    public AnimalTypesResponse findAnimalTypes() {
        List<AnimalTypesDTO> animalTypeDTOList = service.findAnimalTypes().stream()
                .map(animalType -> new AnimalTypesDTO(animalType.getId(), animalType.getAnimalTypes()))
                .collect(Collectors.toList());

        return new AnimalTypesResponse(animalTypeDTOList);
    }
}

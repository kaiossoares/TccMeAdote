package com.tccmeadote.meadote.dto;

import java.util.List;

public class AnimalTypesResponse {
    private List<AnimalTypesDTO> AnimalTypes;

    public List<AnimalTypesDTO> getAnimalTypes() {
        return AnimalTypes;
    }

    public void setAnimalTypes(List<AnimalTypesDTO> animalTypes) {
        AnimalTypes = animalTypes;
    }

    public AnimalTypesResponse(List<AnimalTypesDTO> animalTypes) {
        this.AnimalTypes = animalTypes;
    }
}

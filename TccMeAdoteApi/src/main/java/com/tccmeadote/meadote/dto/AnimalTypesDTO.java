package com.tccmeadote.meadote.dto;

public class AnimalTypesDTO {
    private Short id;
    private String animalType;

    public AnimalTypesDTO(Short id, String animalType) {
        this.id = id;
        this.animalType = animalType;
    }

    public Short getId() {
        return id;
    }

    public void setId(Short id) {
        this.id = id;
    }

    public String getAnimalType() {
        return animalType;
    }

    public void setAnimalType(String animalType) {
        this.animalType = animalType;
    }

}


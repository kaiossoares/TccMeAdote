package com.tccmeadote.meadote.dto;

import java.util.List;

public class AnimalPostDetailsDTO {
    private Long id;
    private String animalName;
    private String animalType;
    private String breedName;
    private String sex;
    private String age;
    private String description;
    private List<String> imageUrls;


    public AnimalPostDetailsDTO() {
    }

    public AnimalPostDetailsDTO(Long id, String animalName, String animalType, String breedName, String sex, String age, String description, List<String> imageUrls) {
        this.id = id;
        this.animalName = animalName;
        this.animalType = animalType;
        this.breedName = breedName;
        this.sex = sex;
        this.age = age;
        this.description = description;
        this.imageUrls = imageUrls;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAnimalName() {
        return animalName;
    }

    public void setAnimalName(String animalName) {
        this.animalName = animalName;
    }

    public String getAnimalType() {
        return animalType;
    }

    public void setAnimalType(String animalType) {
        this.animalType = animalType;
    }

    public String getBreedName() {
        return breedName;
    }

    public void setBreedName(String breedName) {
        this.breedName = breedName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getImageUrls() {
        return imageUrls;
    }

    public void setImageUrls(List<String> imageUrls) {
        this.imageUrls = imageUrls;
    }
}

package com.tccmeadote.meadote.dto;

public class AnimalPostResponseDTO {
    private int id;
    private String animalName;
    private String animalType;
    private String breedName;
    private String sex;
    private String age;
    private String firstImageUrl;
    private boolean favorite;

    public AnimalPostResponseDTO() {
    }

    public AnimalPostResponseDTO(int id, String animalName, String animalType, String breedName, String sex, String age, String firstImageUrl, boolean favorite) {
        this.id = id;
        this.animalName = animalName;
        this.animalType = animalType;
        this.breedName = breedName;
        this.sex = sex;
        this.age = age;
        this.firstImageUrl = firstImageUrl;
        this.favorite = favorite;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public String getFirstImageUrl() {
        return firstImageUrl;
    }

    public void setFirstImageUrl(String firstImageUrl) {
        this.firstImageUrl = firstImageUrl;
    }

    public boolean isFavorite() {
        return favorite;
    }

    public void setFavorite(boolean favorite) {
        this.favorite = favorite;
    }
}

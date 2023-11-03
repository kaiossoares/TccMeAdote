package com.tccmeadote.meadote.services;

import com.tccmeadote.meadote.entities.AnimalPost;

import java.util.List;

public class AnimalPostRequest {
    private AnimalPost animalPost;
    private List<String> photoUrls;

    public AnimalPost getAnimalPost() {
        return animalPost;
    }

    public void setAnimalPost(AnimalPost animalPost) {
        this.animalPost = animalPost;
    }

    public List<String> getPhotoUrls() {
        return photoUrls;
    }

    public void setPhotoUrls(List<String> photoUrls) {
        this.photoUrls = photoUrls;
    }
}

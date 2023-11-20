package com.tccmeadote.meadote.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "post_photos")
public class PostPhotos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "post_id")
    private AnimalPost animalPost;
    @Column(name = "photo_url")
    private String photoUrl;

    public PostPhotos() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photorl) {
        this.photoUrl = photorl;
    }

    public AnimalPost getAnimalPost() {
        return animalPost;
    }

    public void setAnimalPost(AnimalPost animalPost) {
        this.animalPost = animalPost;
    }
}

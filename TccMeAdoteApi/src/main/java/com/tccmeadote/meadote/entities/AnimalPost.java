package com.tccmeadote.meadote.entities;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "animal_posts")
public class AnimalPost {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "animal_name")
    private String animalName;
    @Column(name = "animal_type_id")
    private Integer animalTypeId;
    @Column(name = "breed_id")
    private Integer breedId;
    @Column(name = "sex")
    private String sex;
    @Column(name = "age")
    private String age;
    @Column(name = "description")
    private String description;
    @Column(name = "user_firebase_uid")
    private String userFirebaseUid;

    @OneToMany(mappedBy = "animalPost", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PostPhotos> postPhotos;

    public AnimalPost(){

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAnimalName() {
        return animalName;
    }

    public void setAnimalName(String animalName) {
        this.animalName = animalName;
    }

    public Integer getAnimalTypeId() {
        return animalTypeId;
    }

    public void setAnimalTypeId(Integer animalTypeId) {
        this.animalTypeId = animalTypeId;
    }

    public Integer getBreedId() {
        return breedId;
    }

    public void setBreedId(Integer breedId) {
        this.breedId = breedId;
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

    public String getUserFirebaseUid() {
        return userFirebaseUid;
    }

    public void setUserFirebaseUid(String userFirebaseUid) {
        this.userFirebaseUid = userFirebaseUid;
    }

    public List<PostPhotos> getPostPhotos() {
        return postPhotos;
    }

    public void setPostPhotos(List<PostPhotos> postPhotoss) {
        this.postPhotos = postPhotoss;
    }
}

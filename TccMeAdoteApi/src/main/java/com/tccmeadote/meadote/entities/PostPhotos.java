package com.tccmeadote.meadote.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "post_photos")
public class PostPhotos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "post_id")
    private Integer postId;
    @Column(name = "photo_url")
    private String photoUrl;

    public PostPhotos(){

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photorl) {
        this.photoUrl = photorl;
    }
}

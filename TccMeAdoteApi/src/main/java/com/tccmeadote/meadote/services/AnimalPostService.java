package com.tccmeadote.meadote.services;

import com.tccmeadote.meadote.entities.AnimalPost;
import com.tccmeadote.meadote.entities.PostPhotos;
import com.tccmeadote.meadote.repositories.AnimalPostRepository;
import com.tccmeadote.meadote.repositories.PostPhotosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnimalPostService {

    private final AnimalPostRepository animalPostRepository;
    private final PostPhotosRepository postPhotosRepository;

    @Autowired
    public AnimalPostService(AnimalPostRepository animalPostRepository, PostPhotosRepository postPhotosRepository) {
        this.animalPostRepository = animalPostRepository;
        this.postPhotosRepository = postPhotosRepository;
    }
    public AnimalPost createAnimalPost(AnimalPost animalPost, List<String> photoUrls) {
        System.out.println("Dados recebidos: " + animalPost);
        System.out.println("Dados recebidos urls: " + photoUrls);
        AnimalPost savedAnimalPost = animalPostRepository.save(animalPost);

        int animalPostId = savedAnimalPost.getId();

        for (String photoUrl : photoUrls) {
            PostPhotos postPhotos = new PostPhotos();
            postPhotos.setPostId(animalPostId);
            postPhotos.setPhotoUrl(photoUrl);
            postPhotosRepository.save(postPhotos);
        }

        return savedAnimalPost;
    }

}

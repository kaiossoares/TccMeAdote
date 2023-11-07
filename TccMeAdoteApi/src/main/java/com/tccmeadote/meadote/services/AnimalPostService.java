package com.tccmeadote.meadote.services;

import com.tccmeadote.meadote.dto.AnimalPostResponseDTO;
import com.tccmeadote.meadote.entities.AnimalPost;
import com.tccmeadote.meadote.entities.PostPhotos;
import com.tccmeadote.meadote.repositories.AnimalPostRepository;
import com.tccmeadote.meadote.repositories.PostPhotosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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

    public List<AnimalPostResponseDTO> getAnimalPostsWithFirstImageUrl() {
        List<Object[]> queryResult = animalPostRepository.getAnimalPostsWithFirstImageUrl();
        List<AnimalPostResponseDTO> dtos = new ArrayList<>();

        for (Object[] row : queryResult) {
            AnimalPostResponseDTO dto = new AnimalPostResponseDTO();
            dto.setId((int) row[0]);
            dto.setAnimalName((String) row[1]);
            dto.setAnimalType((String) row[2]);
            dto.setBreedName((String) row[3]);
            dto.setSex((String) row[4]);
            dto.setAge((String) row[5]);
            dto.setFirstImageUrl((String) row[6]);
            dtos.add(dto);
        }
        return dtos;
    }

    public List<AnimalPostResponseDTO> getAnimalPostsWithFirstImageUrlByAnimalType(Long animalTypeId) {
        List<Object[]> queryResult = animalPostRepository.getAnimalPostsWithFirstImageUrlByAnimalType(animalTypeId);
        List<AnimalPostResponseDTO> dtos = new ArrayList<>();

        for (Object[] row : queryResult) {
            AnimalPostResponseDTO dto = new AnimalPostResponseDTO();
            dto.setId((int) row[0]);
            dto.setAnimalName((String) row[1]);
            dto.setAnimalType((String) row[2]);
            dto.setBreedName((String) row[3]);
            dto.setSex((String) row[4]);
            dto.setAge((String) row[5]);
            dto.setFirstImageUrl((String) row[6]);
            dtos.add(dto);
        }
        return dtos;
    }

    public List<AnimalPostResponseDTO> getAnimalPostsByFirebaseUserUid(String firebaseUserUid) {
        List<Object[]> queryResult = animalPostRepository.getAnimalPostsByFirebaseUserUid(firebaseUserUid);
        List<AnimalPostResponseDTO> dtos = new ArrayList<>();

        for (Object[] row : queryResult) {
            AnimalPostResponseDTO dto = new AnimalPostResponseDTO();
            dto.setId((int) row[0]);
            dto.setAnimalName((String) row[1]);
            dto.setAnimalType((String) row[2]);
            dto.setBreedName((String) row[3]);
            dto.setSex((String) row[4]);
            dto.setAge((String) row[5]);
            dto.setFirstImageUrl((String) row[6]);
            dtos.add(dto);
        }
        return dtos;
    }

    public List<AnimalPostResponseDTO> findFavoritesAnimalPostsByUserUid(String firebaseUserUid) {
        List<Object[]> queryResult = animalPostRepository.findFavoritesAnimalPostsByUserUid(firebaseUserUid);
        List<AnimalPostResponseDTO> dtos = new ArrayList<>();

        for (Object[] row : queryResult) {
            AnimalPostResponseDTO dto = new AnimalPostResponseDTO();
            dto.setId((int) row[0]);
            dto.setAnimalName((String) row[1]);
            dto.setAnimalType((String) row[2]);
            dto.setBreedName((String) row[3]);
            dto.setSex((String) row[4]);
            dto.setAge((String) row[5]);
            dto.setFirstImageUrl((String) row[6]);
            dtos.add(dto);
        }
        return dtos;
    }
}

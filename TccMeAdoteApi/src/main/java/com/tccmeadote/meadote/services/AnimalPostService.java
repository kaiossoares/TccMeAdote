package com.tccmeadote.meadote.services;

import com.tccmeadote.meadote.dto.AnimalPostDetailsDTO;
import com.tccmeadote.meadote.dto.AnimalPostResponseDTO;
import com.tccmeadote.meadote.entities.AnimalPost;
import com.tccmeadote.meadote.entities.Favorites;
import com.tccmeadote.meadote.entities.PostPhotos;
import com.tccmeadote.meadote.repositories.AnimalPostRepository;
import com.tccmeadote.meadote.repositories.FavoritesRepository;
import com.tccmeadote.meadote.repositories.PostPhotosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AnimalPostService {

    private final AnimalPostRepository animalPostRepository;
    private final PostPhotosRepository postPhotosRepository;
    private final FavoritesRepository favoritesRepository;

    private boolean isFavorite(Object value) {
        return value != null && value.equals(1);
    }

    @Autowired
    public AnimalPostService(AnimalPostRepository animalPostRepository, PostPhotosRepository postPhotosRepository, FavoritesRepository favoritesRepository) {
        this.animalPostRepository = animalPostRepository;
        this.postPhotosRepository = postPhotosRepository;
        this.favoritesRepository = favoritesRepository;
    }
    public AnimalPost createAnimalPost(AnimalPost animalPost, List<String> photoUrls) {
        System.out.println("Dados recebidos: " + animalPost);
        System.out.println("Dados recebidos urls: " + photoUrls);
        AnimalPost savedAnimalPost = animalPostRepository.save(animalPost);

        int animalPostId = savedAnimalPost.getId();

        for (String photoUrl : photoUrls) {
            PostPhotos postPhotos = new PostPhotos();
            postPhotos.setAnimalPost(animalPost);
            postPhotos.setPhotoUrl(photoUrl);
            postPhotosRepository.save(postPhotos);
        }

        return savedAnimalPost;
    }

    public List<AnimalPostResponseDTO> getAnimalPostsWithFirstImageUrlAndFavoriteStatus(String firebaseUserUid) {
        List<Object[]> queryResult = animalPostRepository.getAnimalPostsWithFirstImageUrlAndFavoriteStatus(firebaseUserUid);
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
            Object value = row[7];
            dto.setFavorite(((Number) value).intValue() == 1);
            dtos.add(dto);
        }
        return dtos;
    }

    public List<AnimalPostResponseDTO> getAnimalPostsWithFirstImageUrlByAnimalType(Long animalTypeId, String firebaseUserUid) {
        List<Object[]> queryResult = animalPostRepository.getAnimalPostsWithFirstImageUrlByAnimalType(animalTypeId, firebaseUserUid);
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
            Object value = row[7];
            if (value instanceof Number) {
                dto.setFavorite(((Number) value).intValue() == 1);
            } else {
                dto.setFavorite(false);
            }

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
            Object value = row[7];
            dto.setFavorite((Long) value == 1);
            dtos.add(dto);
        }
        return dtos;
    }

    @Transactional
    public void deleteAnimalPostAndRelatedEntities(Long animalPostId) {
        AnimalPost animalPost = animalPostRepository.findById(animalPostId).orElse(null);

        if (animalPost != null) {
            if (animalPost.getPostPhotos() != null) {
                for (PostPhotos photo : animalPost.getPostPhotos()) {
                    photo.setAnimalPost(null);
                }
            }

            favoritesRepository.deleteFavoriteByPostId(animalPostId);

            animalPostRepository.delete(animalPost);
        }
    }

    public List<AnimalPostDetailsDTO> getAnimalPostDetailsById(Long postId) {
        List<Object[]> rawResults = animalPostRepository.findAnimalPostDetailsById(postId);

        return rawResults.stream()
                .map(result -> new AnimalPostDetailsDTO(
                        ((Number) result[0]).longValue(),
                        (String) result[1],
                        (String) result[2],
                        (String) result[3],
                        (String) result[4],
                        (String) result[5],
                        (String) result[6],
                        Arrays.asList(((String) result[7]).split(", "))
                ))
                .collect(Collectors.toList());
    }
}

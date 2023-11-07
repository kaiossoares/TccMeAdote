package com.tccmeadote.meadote.repositories;

import com.tccmeadote.meadote.dto.AnimalPostResponseDTO;
import com.tccmeadote.meadote.entities.AnimalPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface AnimalPostRepository extends JpaRepository<AnimalPost, Long> {
    List<AnimalPost> findByUserFirebaseUid(String userFirebaseUid);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO post_photos (post_id, photo_url) VALUES (:postId, :url)", nativeQuery = true)
    void savePostPhotos(@Param("postId") Long postId, @Param("url") String url);

    @Query(value = "SELECT ap.id, ap.animal_name, " +
            "at.animal_type AS animal_type, " +
            "b.breed_name AS breed_name, " +
            "ap.sex, " +
            "ap.age, " +
            "(SELECT pp.photo_url FROM post_photos pp WHERE pp.post_id = ap.id ORDER BY pp.id LIMIT 1) AS first_image_url " +
            "FROM animal_posts ap " +
            "JOIN animal_types at ON ap.animal_type_id = at.id " +
            "JOIN breeds b ON ap.breed_id = b.id " +
            "ORDER BY ap.id", nativeQuery = true)
    List<Object[]> getAnimalPostsWithFirstImageUrl();

    @Query(value = "SELECT ap.id, ap.animal_name, " +
            "at.animal_type AS animal_type, " +
            "b.breed_name AS breed_name, " +
            "ap.sex, " +
            "ap.age, " +
            "(SELECT pp.photo_url FROM post_photos pp WHERE pp.post_id = ap.id ORDER BY pp.id LIMIT 1) AS first_image_url " +
            "FROM animal_posts ap " +
            "JOIN animal_types at ON ap.animal_type_id = at.id " +
            "JOIN breeds b ON ap.breed_id = b.id " +
            "WHERE at.id = :animalTypeId " +
            "ORDER BY ap.id", nativeQuery = true)
    List<Object[]> getAnimalPostsWithFirstImageUrlByAnimalType(@Param("animalTypeId") Long animalTypeId);

    @Query(value = "SELECT ap.id, ap.animal_name, " +
            "at.animal_type AS animal_type, " +
            "b.breed_name AS breed_name, " +
            "ap.sex, " +
            "ap.age, " +
            "(SELECT pp.photo_url FROM post_photos pp WHERE pp.post_id = ap.id ORDER BY pp.id LIMIT 1) AS first_image_url " +
            "FROM animal_posts ap " +
            "JOIN animal_types at ON ap.animal_type_id = at.id " +
            "JOIN breeds b ON ap.breed_id = b.id " +
            "WHERE ap.user_firebase_uid = :firebaseUserUid " +
            "ORDER BY ap.id", nativeQuery = true)
    List<Object[]> getAnimalPostsByFirebaseUserUid(@Param("firebaseUserUid") String firebaseUserUid);

    @Query(value = "SELECT ap.id, ap.animal_name, " +
            "at.animal_type AS animal_type, " +
            "b.breed_name AS breed_name, " +
            "ap.sex, " +
            "ap.age, " +
            "(SELECT pp.photo_url FROM post_photos pp WHERE pp.post_id = ap.id ORDER BY pp.id LIMIT 1) AS first_image_url " +
            "FROM animal_posts ap " +
            "JOIN animal_types at ON ap.animal_type_id = at.id " +
            "JOIN breeds b ON ap.breed_id = b.id " +
            "JOIN favorites f ON ap.id = f.post_id " +
            "WHERE f.user_firebase_uid = :firebaseUserUid " +
            "ORDER BY ap.id", nativeQuery = true)
    List<Object[]> findFavoritesAnimalPostsByUserUid(@Param("firebaseUserUid") String firebaseUserUid);
}

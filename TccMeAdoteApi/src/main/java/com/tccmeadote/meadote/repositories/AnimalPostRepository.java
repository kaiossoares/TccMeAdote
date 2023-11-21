package com.tccmeadote.meadote.repositories;

import com.tccmeadote.meadote.entities.AnimalPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface AnimalPostRepository extends JpaRepository<AnimalPost, Long> {
    List<AnimalPost> findByUserFirebaseUid(String userFirebaseUid);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO post_photos (post_id, photo_url) VALUES (:postId, :url)", nativeQuery = true)
    void savePostPhotos(@Param("postId") Long postId, @Param("url") String url);

    @Query(value = "SELECT ap.id, ap.animal_name, " + "at.animal_type AS animal_type, " + "b.breed_name AS breed_name, " + "ap.sex, " + "ap.age, " + "(SELECT pp.photo_url FROM post_photos pp WHERE pp.post_id = ap.id ORDER BY pp.id LIMIT 1) AS first_image_url, " + "CASE WHEN fav.post_id IS NOT NULL THEN 1 ELSE 0 END AS is_favorite " + "FROM animal_posts ap " + "JOIN animal_types at ON ap.animal_type_id = at.id " + "JOIN breeds b ON ap.breed_id = b.id " + "LEFT JOIN favorites fav ON ap.id = fav.post_id AND fav.user_firebase_uid = :firebaseUserUid " + "ORDER BY ap.id", nativeQuery = true)
    List<Object[]> getAnimalPostsWithFirstImageUrlAndFavoriteStatus(@Param("firebaseUserUid") String firebaseUserUid);

    @Query(value = "SELECT ap.id, ap.animal_name, " + "at.animal_type AS animal_type, " + "b.breed_name AS breed_name, " + "ap.sex, " + "ap.age, " + "(SELECT pp.photo_url FROM post_photos pp WHERE pp.post_id = ap.id ORDER BY pp.id LIMIT 1) AS first_image_url, " + "IF(fav.post_id IS NOT NULL, 1, 0) AS is_favorite " + "FROM animal_posts ap " + "JOIN animal_types at ON ap.animal_type_id = at.id " + "JOIN breeds b ON ap.breed_id = b.id " + "LEFT JOIN favorites fav ON ap.id = fav.post_id AND fav.user_firebase_uid = :userFirebaseUid " + "WHERE at.id = :animalTypeId " + "ORDER BY ap.id", nativeQuery = true)
    List<Object[]> getAnimalPostsWithFirstImageUrlByAnimalType(@Param("animalTypeId") Long animalTypeId, @Param("userFirebaseUid") String userFirebaseUid);

    @Query(value = "SELECT ap.id, ap.animal_name, " + "at.animal_type AS animal_type, " + "b.breed_name AS breed_name, " + "ap.sex, " + "ap.age, " + "(SELECT pp.photo_url FROM post_photos pp WHERE pp.post_id = ap.id ORDER BY pp.id LIMIT 1) AS first_image_url " + "FROM animal_posts ap " + "JOIN animal_types at ON ap.animal_type_id = at.id " + "JOIN breeds b ON ap.breed_id = b.id " + "WHERE ap.user_firebase_uid = :firebaseUserUid " + "ORDER BY ap.id", nativeQuery = true)
    List<Object[]> getAnimalPostsByFirebaseUserUid(@Param("firebaseUserUid") String firebaseUserUid);

    @Query(value = "SELECT " + "ap.id AS post_id, " + "ap.animal_name, " + "at.animal_type AS animal_type, " + "b.breed_name AS breed_name, " + "ap.sex, " + "ap.age, " + "(SELECT pp.photo_url FROM post_photos pp WHERE pp.post_id = ap.id ORDER BY pp.id LIMIT 1) AS first_image_url, " + "CASE WHEN fav.post_id IS NOT NULL THEN 1 ELSE 0 END AS is_favorite " + "FROM animal_posts ap " + "JOIN animal_types at ON ap.animal_type_id = at.id " + "JOIN breeds b ON ap.breed_id = b.id " + "LEFT JOIN favorites fav ON ap.id = fav.post_id AND fav.user_firebase_uid = :firebaseUserUid " + "WHERE fav.post_id IS NOT NULL " + "ORDER BY ap.id", nativeQuery = true)
    List<Object[]> findFavoritesAnimalPostsByUserUid(@Param("firebaseUserUid") String firebaseUserUid);

    @Query(value = "SELECT ap.id, ap.animal_name, " +
            "at.animal_type AS animal_type, " +
            "b.breed_name AS breed_name, " +
            "ap.sex, " +
            "ap.age, " +
            "ap.description, " +
            "(SELECT GROUP_CONCAT(pp.photo_url SEPARATOR ', ') FROM post_photos pp WHERE pp.post_id = ap.id) AS all_image_urls " +
            "FROM animal_posts ap " +
            "JOIN animal_types at ON ap.animal_type_id = at.id " +
            "JOIN breeds b ON ap.breed_id = b.id " +
            "WHERE ap.id = :postId " +
            "ORDER BY ap.id", nativeQuery = true)
    List<Object[]> findAnimalPostDetailsById(@Param("postId") Long postId);

    Optional<AnimalPost> findById(Long id);
}

package com.tccmeadote.meadote.repositories;

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
}

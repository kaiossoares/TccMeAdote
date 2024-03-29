package com.tccmeadote.meadote.repositories;

import com.tccmeadote.meadote.entities.Favorites;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FavoritesRepository extends JpaRepository<Favorites, Long> {
    Optional<Favorites> findByUserFirebaseUidAndPostId(String userFirebaseUid, Long postId);

    void deleteFavoriteByPostId(Long postId);
}

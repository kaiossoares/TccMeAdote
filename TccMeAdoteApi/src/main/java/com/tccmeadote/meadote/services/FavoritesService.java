package com.tccmeadote.meadote.services;

import com.tccmeadote.meadote.entities.Favorites;
import com.tccmeadote.meadote.repositories.FavoritesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class FavoritesService {
    private final FavoritesRepository favoritesRepository;

    @Autowired
    public FavoritesService(FavoritesRepository favoritesRepository) {
        this.favoritesRepository = favoritesRepository;
    }

    public void addFavorite(String userFirebaseUid, Long postId) {
        Optional<Favorites> favoritoExistente = favoritesRepository.findByUserFirebaseUidAndPostId(userFirebaseUid, postId);
        if (favoritoExistente.isEmpty()) {
            Favorites favorites = new Favorites();
            favorites.setUserFirebaseUid(userFirebaseUid);
            favorites.setPostId(postId);
            favoritesRepository.save(favorites);
        }
    }

    public void removeFavorite(String userFirebaseUid, Long postId) {
        Optional<Favorites> favoritoExistente = favoritesRepository.findByUserFirebaseUidAndPostId(userFirebaseUid, postId);
        favoritoExistente.ifPresent(favoritesRepository::delete);
    }
}


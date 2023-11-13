package com.tccmeadote.meadote.controllers;

import com.tccmeadote.meadote.services.FavoritesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/favorites")
public class FavoritesController {

    private final FavoritesService favoritesService;

    @Autowired
    public FavoritesController(FavoritesService favoritesService) {
        this.favoritesService = favoritesService;
    }

    @PostMapping("/add")
    public ResponseEntity<String> addFavorite(@RequestBody Map<String, String> requestBody) {
        String userFirebaseUid = requestBody.get("userFirebaseUid");
        Long postId = Long.parseLong    (requestBody.get("postId"));
        favoritesService.addFavorite(userFirebaseUid, postId);
        return ResponseEntity.ok("Favorito adicionado com sucesso.");
    }

    @DeleteMapping("/remove")
    public ResponseEntity<String> removeFavorite(@RequestBody Map<String, Object> requestBody) {
        String userFirebaseUid = (String) requestBody.get("userFirebaseUid");
        Object postIdObject = requestBody.get("postId");

        Long postId;
        if (postIdObject instanceof Long) {
            postId = (Long) postIdObject;
        } else if (postIdObject instanceof Integer) {
            postId = ((Integer) postIdObject).longValue();
        } else {
            return ResponseEntity.badRequest().body("Formato inválido para o postId.");
        }

        favoritesService.removeFavorite(userFirebaseUid, postId);

        return ResponseEntity.ok("Favorito removido com sucesso.");
    }
}


package com.tccmeadote.meadote.controllers;

import com.tccmeadote.meadote.dto.AnimalPostResponseDTO;
import com.tccmeadote.meadote.services.AnimalPostRequest;
import com.tccmeadote.meadote.services.AnimalPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/posts")
public class AnimalPostController {

    private final AnimalPostService animalPostService;

    @Autowired
    public AnimalPostController(AnimalPostService animalPostService) {
        this.animalPostService = animalPostService;
    }

    @PostMapping("/post")
    public ResponseEntity<String> createAnimalPost(@RequestBody AnimalPostRequest animalPostRequest) {
        animalPostService.createAnimalPost(animalPostRequest.getAnimalPost(), animalPostRequest.getPhotoUrls());
        return ResponseEntity.status(HttpStatus.CREATED).body("Post de animal criado com sucesso.");
    }

    @GetMapping("/list")
    public ResponseEntity<List<AnimalPostResponseDTO>> getAnimalPosts() {
        List<AnimalPostResponseDTO> animalPosts = animalPostService.getAnimalPostsWithFirstImageUrl();
        return ResponseEntity.ok(animalPosts);
    }

    @GetMapping("/list/{animalTypeId}")
    public ResponseEntity<List<AnimalPostResponseDTO>> getAnimalPostsByAnimalType(@PathVariable Long animalTypeId) {
        List<AnimalPostResponseDTO> animalPosts = animalPostService.getAnimalPostsWithFirstImageUrlByAnimalType(animalTypeId);
        return ResponseEntity.ok(animalPosts);
    }

    @GetMapping("/list/uid/{firebaseUserUid}")
    public ResponseEntity<List<AnimalPostResponseDTO>> getAnimalPostsByFirebaseUserUid(@PathVariable String firebaseUserUid) {
        List<AnimalPostResponseDTO> animalPosts = animalPostService.getAnimalPostsByFirebaseUserUid(firebaseUserUid);
        return ResponseEntity.ok(animalPosts);
    }
}

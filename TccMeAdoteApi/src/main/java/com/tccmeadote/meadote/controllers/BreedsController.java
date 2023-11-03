package com.tccmeadote.meadote.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tccmeadote.meadote.entities.Breeds;
import com.tccmeadote.meadote.services.BreedsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/breeds")
public class BreedsController {

    @Autowired
    private BreedsService service;

    @GetMapping
    public List<Breeds> findBreeds() {
        return service.findBreeds();
    }

    @GetMapping("/{id}")
    public ResponseEntity<List<Breeds>> findBreedsByAnimalTypeId(@PathVariable Short id) {
        List<Breeds> breedsList = service.findAnimalsBreedsById(id);
        if (!breedsList.isEmpty()) {
            return ResponseEntity.ok(breedsList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/{breedName}/{animalTypeId}")
    public ResponseEntity<Map<String, Integer>> getBreedId(
            @PathVariable String breedName,
            @PathVariable int animalTypeId) {
        Integer breedId = service.getIdByBreedName(breedName, animalTypeId);
        Map<String, Integer> response = new HashMap<>();
        if (breedId != null) {
            response.put("id", breedId);
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
    }

}

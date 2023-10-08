package com.tccmeadote.meadote.services;

import java.util.List;

import com.tccmeadote.meadote.entities.Breeds;
import com.tccmeadote.meadote.repositories.BreedsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BreedsService {

    @Autowired
    private BreedsRepository repository;

    public List<Breeds> findBreeds() {
        return repository.findAll();
    }

    public List<Breeds> findAnimalsBreedsById(Short id) {
        return repository.findAnimalsBreedsById(id);
    }
}

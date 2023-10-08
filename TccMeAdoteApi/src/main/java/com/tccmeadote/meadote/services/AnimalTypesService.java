package com.tccmeadote.meadote.services;

import com.tccmeadote.meadote.entities.AnimalTypes;
import com.tccmeadote.meadote.repositories.AnimalTypesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnimalTypesService {

    @Autowired
    private AnimalTypesRepository repository;

    public List<AnimalTypes> findAnimalTypes() {
        return repository.findAll();
    }

}

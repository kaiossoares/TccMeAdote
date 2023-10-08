package com.tccmeadote.meadote.controllers;

import com.tccmeadote.meadote.entities.AnimalTypes;
import com.tccmeadote.meadote.services.AnimalTypesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping(value = "/animal-types")
public class AnimalTypesController {
    @Autowired
    private AnimalTypesService service;

    @GetMapping
    public List<AnimalTypes> findAnimalTypes() {
        return service.findAnimalTypes();
    }
}

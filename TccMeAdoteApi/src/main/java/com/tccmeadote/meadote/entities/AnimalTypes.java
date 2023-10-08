package com.tccmeadote.meadote.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "animal_types")
public class AnimalTypes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short id;

    @Column(name = "animal_type")
    private String animalTypes;

    public AnimalTypes(){

    }

    public Short getId() {
        return id;
    }

    public void setId(Short id) {
        this.id = id;
    }

    public String getAnimalTypes() {
        return animalTypes;
    }

    public void setAnimalTypes(String animalTypes) {
        this.animalTypes = animalTypes;
    }
}

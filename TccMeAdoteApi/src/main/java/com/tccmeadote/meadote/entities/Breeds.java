package com.tccmeadote.meadote.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "breeds")
public class Breeds {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short id;

    @Column(name = "breed_name")
    private String breedName;

    @ManyToOne
    @JoinColumn(name = "id_animal_type", referencedColumnName = "id")
    private AnimalTypes animalType;

    public Breeds(){

    }

    public Short getId() {
        return id;
    }

    public void setId(Short id) {
        this.id = id;
    }

    public String getBreedName() {
        return breedName;
    }

    public void setBreedName(String breedName) {
        this.breedName = breedName;
    }

    public AnimalTypes getAnimalType() {
        return animalType;
    }

    public void setAnimalType(AnimalTypes animalType) {
        this.animalType = animalType;
    }
}

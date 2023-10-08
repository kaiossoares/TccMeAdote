package com.tccmeadote.meadote.repositories;

import com.tccmeadote.meadote.entities.Breeds;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BreedsRepository extends JpaRepository<Breeds, Short> {
    @Query("SELECT b FROM Breeds b INNER JOIN b.animalType a WHERE a.id = :animalTypeId")
    List<Breeds> findAnimalsBreedsById(@Param("animalTypeId") Short animalTypeId);

}

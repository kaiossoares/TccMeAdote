package com.tccmeadote.meadote.repositories;

import com.tccmeadote.meadote.entities.AnimalTypes;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AnimalTypesRepository extends JpaRepository<AnimalTypes, Short> {
}

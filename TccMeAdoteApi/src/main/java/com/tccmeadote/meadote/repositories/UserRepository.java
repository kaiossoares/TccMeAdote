package com.tccmeadote.meadote.repositories;

import com.tccmeadote.meadote.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);

    User findByUserFirebaseUid(String userFirebaseUid);
}

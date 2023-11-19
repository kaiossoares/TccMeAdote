package com.tccmeadote.meadote.services;

import com.tccmeadote.meadote.entities.User;
import com.tccmeadote.meadote.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public User registerUser(User user, String userFirebaseUid) {
        Optional<User> existingUser = userRepository.findByEmail(user.getEmail());
        if (existingUser.isPresent()) {
            throw new IllegalArgumentException("E-mail já está em uso.");
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setUserFirebaseUid(userFirebaseUid);

        return userRepository.save(user);
    }

    public User findByUserFirebaseUid(String userFirebaseUid) {
        return userRepository.findByUserFirebaseUid(userFirebaseUid);
    }
}

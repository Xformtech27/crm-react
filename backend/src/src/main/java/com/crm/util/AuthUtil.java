package com.crm.util;

import com.crm.entity.User;
import com.crm.exception.ResourceNotFoundException;
import com.crm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class AuthUtil {

    private final UserRepository userRepository;

    public User getCurrentUser(Authentication auth) {
        return userRepository.findByUserEmail(auth.getName())
                .orElseThrow(() -> new ResourceNotFoundException("User", "email", auth.getName()));
    }
}

package com.github.rkruk.findmenow.repositories;

import com.github.rkruk.findmenow.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    User findByUsernameEquals(String username);

    User findByLastNameEquals(String lastName);
}


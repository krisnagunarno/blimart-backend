package com.bliblifuturebackend.bliblimart.repository;

import com.bliblifuturebackend.bliblimart.model.entity.User;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.ReactiveMongoRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Repository
public interface UserRepository extends ReactiveMongoRepository<User, String> {

    @Query("{ id: { $exists: true }}")
    Flux<User> findAll(final Pageable pageable);

    Mono<User> findByUsername(String username);

}

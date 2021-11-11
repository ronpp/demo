
package com.example.demo.repository;

import com.example.demo.domain.model.File;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.UUID;

public interface FileRepository extends JpaRepository<File, UUID> {
    @Query("select fileid from File")
    List<String> getFileIds();
}
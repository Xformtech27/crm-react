package com.crm.repository;

import com.crm.entity.Project;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProjectRepository extends JpaRepository<Project, Long>, JpaSpecificationExecutor<Project> {
    List<Project> findByUserIdFk(Long userIdFk);
    List<Project> findByProjectStatus(String projectStatus);
    long countByProjectStatus(String projectStatus);

    @Query("SELECT p.projectStatus AS status, COUNT(p) AS count FROM Project p GROUP BY p.projectStatus")
    List<Object[]> countGroupByStatus();
}

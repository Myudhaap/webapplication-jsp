package com.webapplication.respository;

import com.webapplication.entity.Student;

import java.util.List;

public interface IStudentRepository {
  List<Student> getAll();
}

package com.webapplication.respository.impl;

import com.webapplication.entity.Student;
import com.webapplication.respository.IStudentRepository;

import java.util.ArrayList;
import java.util.List;

public class StudentRepository implements IStudentRepository {
  private List<Student> studentList;
  public StudentRepository() {
    studentList = new ArrayList<>();
    studentList.add(new Student("s1", "Student A", "Dept 1", 35));
    studentList.add(new Student("s2", "Student B", "Dept 1", 70));
    studentList.add(new Student("s3", "Student C", "Dept 1", 60));
    studentList.add(new Student("s4", "Student D", "Dept 1", 90));
    studentList.add(new Student("s5", "Student E", "Dept 2", 30));
    studentList.add(new Student("s6", "Student F", "Dept 3", 32));
    studentList.add(new Student("s7", "Student G", "Dept 3", 70));
    studentList.add(new Student("s8", "Student H", "Dept 3", 20));
  }

  @Override
  public List<Student> getAll() {
    return studentList;
  }
}

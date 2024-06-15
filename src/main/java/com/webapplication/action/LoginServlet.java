package com.webapplication.action;

import com.google.gson.Gson;
import com.webapplication.entity.Student;
import com.webapplication.respository.IStudentRepository;
import com.webapplication.respository.impl.StudentRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    IStudentRepository studentRepository = new StudentRepository();
    List<String> studentList = studentRepository.getAll().stream()
        .map(student -> student.getStudentId().toLowerCase()).collect(Collectors.toList());

    String userId = request.getParameter("userId");
    String password = request.getParameter("password");

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    Gson gson = new Gson();
    Map<String, Object> jsonResponse = new HashMap<>();

    if(studentList.contains(userId.toLowerCase()) && password.equalsIgnoreCase("password")){
      jsonResponse.put("success", true);
      jsonResponse.put("message", "Login successfully.");
    }else{
      jsonResponse.put("success", false);
      jsonResponse.put("message", "Invalid username or password.");
    }

    String json = gson.toJson(jsonResponse);
    response.getWriter().write(json);
  }
}

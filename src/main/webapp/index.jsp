<%@ page import="com.webapplication.respository.IStudentRepository" %>
<%@ page import="com.webapplication.respository.impl.StudentRepository" %>
<%@ page import="com.webapplication.entity.Student" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <%
        IStudentRepository studentRepository = new StudentRepository();

        List<Student> studentList = studentRepository.getAll();
        Map<String, List<Student>> departmentStudents = new HashMap<>();

        for(Student student: studentList){
          String department = student.getDepartment();
          if(!departmentStudents.containsKey(department)){
            departmentStudents.put(department, new ArrayList<>());
          }
          departmentStudents.get(department).add(student);
        }

        List<String> departmentName = new ArrayList<>(departmentStudents.keySet());
        Collections.sort(departmentName);
    %>
    <div class="container">
        <h1>Student List</h1>

        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Department</th>
                        <th>Student Id</th>
                        <th>Marks</th>
                        <th class="text-center">Pass%</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if(!departmentStudents.isEmpty()){
                          for(String department: departmentName){
                            List<Student> students = departmentStudents.get(department);
                            int span = students.size();
                            int passStudent = students.stream()
                                    .filter(student -> student.getMark() >= 40 )
                                    .collect(Collectors.toList()).size();

                            double resPass = 0;
                            if(passStudent != 0) resPass = (double) passStudent / span * 100;
                    %>
                            <tr>
                                <td rowspan="<%= span %>"><%= department %></td>
                                <td><a href="#" data-bs-toggle="modal" data-bs-target="#modalStudent-<%=students.get(0).getStudentId()%>"><%= students.get(0).getStudentId() %></a></td>
                                <td><%= students.get(0).getMark() %></td>
                                <td class="text-center" style="vertical-align: middle" rowspan="<%= span %>"><%= (int) resPass %></td>
                            </tr>

                            <div class="modal fade" id="modalStudent-<%=students.get(0).getStudentId()%>" tabindex="-1" aria-labelledby="modalStudent-<%=students.get(0).getStudentId()%>" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">Modal Student-<%=students.get(0).getStudentId()%></h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p><strong>Name:</strong> <%= students.get(0).getStudentName() %></p>
                                            <p><strong>Age:</strong> <%= students.get(0).getMark() %></p>
                                            <p><strong>Status:</strong> <%= students.get(0).getMark() >= 40 ? "Lulus" : "Tidak Lulus" %></p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    <%
                              for (int i = 1; i < span; i++){ %>
                                <tr>
                                    <td><a href="#" data-bs-toggle="modal" data-bs-target="#modalStudent-<%=students.get(i).getStudentId()%>"><%= students.get(i).getStudentId() %></a></td>
                                    <td><%= students.get(i).getMark() %></td>
                                </tr>

                                <div class="modal fade" id="modalStudent-<%=students.get(i).getStudentId()%>" tabindex="-1" aria-labelledby="modalStudent-<%=students.get(i).getStudentId()%>" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5">Modal Student-<%=students.get(i).getStudentId()%></h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p><strong>Name:</strong> <%= students.get(i).getStudentName() %></p>
                                                <p><strong>Age:</strong> <%= students.get(i).getMark() %></p>
                                                <p><strong>Status:</strong> <%= students.get(i).getMark() >= 40 ? "Lulus" : "Tidak Lulus" %></p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                              <%}
                          }
                        }%>
                </tbody>
            </table>
        </div>
    </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>
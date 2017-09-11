package controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import model.Student;

@WebServlet("/HighChartServlet")
public class HighChartServlet extends HttpServlet {

 private static final long serialVersionUID = 1L;

 public HighChartServlet() {
  super();
 }

 protected void doGet(HttpServletRequest request,
   HttpServletResponse response) throws ServletException, IOException {

  List<Student> listOfStudent = getStudentData();

  Gson gson = new Gson();

  String jsonString = gson.toJson(listOfStudent);

  response.setContentType("application/json");

  response.getWriter().write(jsonString);

 }

 private List<Student> getStudentData() {

  List<Student> listOfStudent = new ArrayList<Student>();
  Student s1 = new Student();
  s1.setName("Sandeep");
  s1.setComputerMark(75);
  s1.setMathematicsMark(26);
  listOfStudent.add(s1);

  Student s2 = new Student();
  s2.setName("Bapi");
  s2.setComputerMark(60);
  s2.setMathematicsMark(63);
  listOfStudent.add(s2);

  Student s3 = new Student();
  s3.setName("Raja");
  s3.setComputerMark(40);
  s3.setMathematicsMark(45);
  listOfStudent.add(s3);

  Student s4 = new Student();
  s4.setName("Sonu");
  s4.setMathematicsMark(29);
  s4.setComputerMark(78);
  listOfStudent.add(s4);

  return listOfStudent;
 }
}

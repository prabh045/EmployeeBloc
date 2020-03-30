import 'dart:async';
import 'Employee.dart';
//Stream controllers are gonna be defined for everything, for new objects and functions
//Sink is data input
//Stream is data output
//Pipe is stream controller

//7 steps of bloc
/* 
imports
list of employees
stream controllers
stream sink getters
constructors-> add data , listen to changes
core functions
dispose

*/

class EmployeeBloc {
  List<Employee> employeeList = [
    Employee.getObject(1, "Phoenix", 1000.0),
    Employee.getObject(2, "Pankaj", 2000.0),
    Employee.getObject(3, "Potter", 3000.0),
    Employee.getObject(4, "Pinocio", 4000.0),
  ];

  final employeeListStreamController = StreamController<List<Employee>>();
  //for incremnt and ecerment
  final salaryIncrementStreamController = StreamController<Employee>();
  final salaryDecrementStreamController = StreamController<Employee>();

  //getters

  Stream<List<Employee>> get employeeListStream {
    return employeeListStreamController.stream;
  }

  StreamSink<List<Employee>> get employeeListSink {
    return employeeListStreamController.sink;
  }

  StreamSink<Employee> get employeeSalaryIncrementSink {
    return salaryIncrementStreamController.sink;
  }

  StreamSink<Employee> get employeeSalaryDecrementSink {
    return salaryDecrementStreamController.sink;
  }

  //constructor
  EmployeeBloc() {
    employeeListStreamController.add(employeeList);
    salaryIncrementStreamController.stream.listen(employeeSalaryIncrementEvent);
    salaryDecrementStreamController.stream.listen(employeeSalaryDecrement);
  }

  employeeSalaryIncrementEvent(Employee employee) {
    employee.salary = employee.salary + 500.0;
    employeeListSink.add(employeeList);
  }

  employeeSalaryDecrement(Employee employee) {
    employee.salary = employee.salary - 500.0;
    employeeListSink.add(employeeList);
  }

  void dispose() {
    employeeListStreamController.close();
    salaryIncrementStreamController.close();
    salaryDecrementStreamController.close();

  }
}

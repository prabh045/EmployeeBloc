class Employee {
  int id;
  String name;
  double salary;

  static Employee getObject(int id, String name, double salary) {
    Employee employee = Employee();
    employee.id = id;
    employee.name = name;
    employee.salary = salary;
    return employee;
  }
}

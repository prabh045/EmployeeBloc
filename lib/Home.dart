import 'package:blocdemoemployee/EmployeeBloc.dart';
import 'package:flutter/material.dart';
import 'Employee.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  EmployeeBloc employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    super.dispose();
    employeeBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee app demo"),
      ),
      body: setupUI(context),
    );
  }

  Widget setupUI(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child:  StreamBuilder<List<Employee>>(
        stream: employeeBloc.employeeListStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
          return snapshot.data==null?Container(): ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return cardBuilder(snapshot, index);
            },
          );
        },
      ),
    );
  }

  Widget cardBuilder(AsyncSnapshot<List<Employee>> snapshot, int index) {
    return Card(
      elevation: 4,
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("${snapshot.data[index].id}"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("${snapshot.data[index].name}"),
                Text("${snapshot.data[index].salary}"),
              ],
            ),
            IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: Colors.green,
                ),
                onPressed: () {
                  employeeBloc.employeeSalaryIncrementSink.add(snapshot.data[index]);
                }),
            IconButton(
                icon: Icon(
                  Icons.thumb_down,
                  color: Colors.red,
                ),
                onPressed: (){
                  employeeBloc.employeeSalaryDecrementSink.add(snapshot.data[index]);
                }),
          ],
        ),
      ),
    );
  }
}

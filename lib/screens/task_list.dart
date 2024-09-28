import 'package:flutter/material.dart';
import 'package:note_app/screens/add_task_list.dart';
import 'package:note_app/screens/edit_task_list.dart';

import '../data/api.dart';
import '../model/task.dart';

class TaskListScreen extends StatefulWidget {
  static const String routeName = '/tasklist';


  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> listTask = <Task>[];

  API api = API();

  final TextEditingController _taskController = TextEditingController();

  void _navigateToAddTask() {
    Navigator.pushNamed(context, AddTaskListScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    _getListTask();
  }

  Future<void> _getListTask() async {
    listTask = await api.getTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.white,
          title: Container(
            alignment: Alignment.center,
            child: Text(
              'Danh sách công việc',
              // style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Container(
          // color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: listTask.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditTaskListScreen(task: listTask[index]),
                          ),
                        ).then((updatedTask) {
                          if (updatedTask != null) {
                            setState(() {
                              listTask[index] = updatedTask;
                            });
                          }
                        });
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        elevation: 3,
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listTask[index].content, // Sửa thành `content` thay vì `title`
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      listTask[index].time,
                                      // style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              // Biểu tượng hình ngôi sao
                              IconButton(
                                icon: Icon(
                                  listTask[index].isStarred ? Icons.star : Icons.star_border,
                                  color: listTask[index].isStarred ? Colors.amber[400] : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    listTask[index].isStarred = !listTask[index].isStarred; // Chuyển đổi trạng thái
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAddTask,
          child: Icon(Icons.add),
          // backgroundColor: Colors.white,
          tooltip: 'Thêm công việc',
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
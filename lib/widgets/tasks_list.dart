import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:todolist_app/widgets/task_item.dart';

class TasksList extends StatefulWidget {
  final FirestoreService firestoreService = FirestoreService();

  TasksList({Key? key, required this.tasks}) : super(key: key);

  final List<Task> tasks;

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<Task> taskItems = [];

  @override
  void initState() {
    super.initState();
    // Initialisez taskItems avec les tâches initiales.
    taskItems = widget.tasks;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.firestoreService.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final taskLists = snapshot.data!.docs;
          taskItems.clear(); // Effacez les anciennes tâches pour les remplacer par les nouvelles.

          for (int index = 0; index < taskLists.length; index++) {
            DocumentSnapshot document = taskLists[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String title = data['taskTitle'] ?? ''; // Handle potential null value
            String description = data['taskDesc'] ?? ''; // Handle potential null value
            String categoryString = data['taskCategory'] ?? 'others'; // Handle potential null value

            Category category;
            switch (categoryString) {
              case 'personal':
                category = Category.personal;
                break;
              case 'work':
                category = Category.work;
                break;
              case 'shopping':
                category = Category.shopping;
                break;
              default:
                category = Category.others;
            }
            Task task = Task(
              title: title,
              description: description,
              category: category,
              completed: false,
            );
            taskItems.add(task);
          }

          return ListView.builder(
            itemCount: taskItems.length,
            itemBuilder: (ctx, index) {
              return TaskItem(
                task: taskItems[index],
                taskCompleted: taskItems[index].completed,
                onChanged: (bool? value) {
                  widget.firestoreService.updateTaskCompletedStatus(taskItems[index].id, value ?? false);
                },
                onDelete: (context) {
                  // Supprimez la tâche de la base de données et mettez à jour l'interface utilisateur.
                  final taskId = taskItems[index].id;
                  widget.firestoreService.deleteTask(taskId);
                  setState(() {
                    taskItems.removeAt(index);
                  });
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator(); // Display a loading indicator while waiting for data.
        }
      },
    );
  }
}

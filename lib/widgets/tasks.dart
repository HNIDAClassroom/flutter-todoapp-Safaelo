import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/tasks_list.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'package:todolist_app/services/firestore.dart';
class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService();
  final List<Task> _registeredTasks = [
     Task(
    title: 'Apprendre Flutter',
    description: 'Suivre le cours pour apprendre de nouvelles compétences',
    ///date: DateTime.now(),
    category: Category.work,
    completed: false,
  ),
  Task(
    title: 'Faire les courses',
    description: 'Acheter des provisions pour la semaine',
    ///date: DateTime.now().subtract(Duration(days: 1)),
    category: Category.shopping,
    completed: false,
  ),
  Task(
    title: 'Rediger un CR',
    description: '',
    ///date: DateTime.now().subtract(Duration(days: 2)),
    category: Category.personal,
    completed: false,
  ),
  // Add more tasks with descriptions as needed
  ];

  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onAddTask: _addTask),
    );
  }

  void _addTask(Task task) {
    setState(() {
      _registeredTasks.add(task);
      firestoreService.addTask(task);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.checklist),
            const SizedBox(width: 8),
            Text("TaskHub", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ('LobsterTwo-BoldItalic'),
              fontSize: 24)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTaskOverlay,
         child: const Icon(Icons.assignment_add,size: 28.0,),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/img4.jpg"), // Remplacez 'assets/background_image.png' par le chemin de votre image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
    Colors.black.withOpacity(0.8), // Ajustez l'opacité ici
    BlendMode.dstATop, // Utilisez dstATop pour une superposition d'image
  ), // Ajustez la façon dont l'image est affichée
          ),
        ),
        child: Column(
          children: [
            const Text('To Do List'),
            Expanded(child: TasksList(tasks: _registeredTasks)),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final FirestoreService firestoreService = FirestoreService();
  final Function(BuildContext?) onDelete;

  TaskItem({
    required this.task,
    required this.taskCompleted,
    required this.onChanged,
    required this.onDelete,
  });

  void deleteTask(BuildContext context) {
    final taskId = task.id1;
    firestoreService.deleteTask(taskId);
    onDelete(context);
  }

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.task.completed;
    
  }

  @override
  Widget build(BuildContext context) {
    print(_isCompleted);
    return Padding(
      padding: const EdgeInsets.all(9),
      child: SizedBox(
        height: 80,
        width: 310,
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  widget.onDelete(context);
                },
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(12),
              )
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Color.fromARGB(200, 187, 53, 211),
            child: Padding(
              padding: const EdgeInsets.all(24),
              
              child: Row(
                children: [
                  Checkbox(
                    value: _isCompleted,
                    
                    onChanged: (value) {
                      setState(() {
                        _isCompleted = value ?? false;
                      });
                      widget.onChanged?.call(_isCompleted);
                      widget.firestoreService.updateTaskCompletedStatus(widget.task.id1, _isCompleted);
                    },
                    activeColor: Colors.black,
                    
                  ),
                  _isCompleted
                      ? Text(
                          widget.task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.black,
                            decorationThickness: 1.6,
                          ),
                        )
                      : Text(
                          widget.task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.task.date != null
                            ? '${widget.task.date!.day}/${widget.task.date!.month}/${widget.task.date!.year}'
                            : '',
                        style: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w300, // Ajustez le fontWeight
                          fontStyle: FontStyle.italic, 
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.onAddTask});
  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Category _selectedCategory = Category.personal;
  bool _isCompleted = false;
  DateTime? _selectedDate = DateTime.now();
  String id = uuid.v4();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text(
              'Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddTask(Task(
      title: _titleController.text,
      description: _descriptionController.text,
      date: _selectedDate,
      category: _selectedCategory,
      completed: _isCompleted,
      id1:id ,
    ));

    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedCategory = Category.personal;
      _isCompleted = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            maxLength: 100,
            decoration: InputDecoration(
              labelText: 'Description',
            ),
          ),
Row(
  children: [
    DropdownButton<Category>(
      value: _selectedCategory,
      items: Category.values
          .map((category) => DropdownMenuItem<Category>(
                value: category,
                child: Text(
                  category.name.toUpperCase(),
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value!;
        });
      },
    ),
              Checkbox(
                value: _isCompleted,
                onChanged: (value) {
                  setState(() {
                    _isCompleted = value ?? false;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  enabled: false,
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                        : 'Not Selected',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context);
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _submitTaskData,
            child: const Text('Save Task'),
          ),
        ],
      ),
    );
  }
}

///import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';


class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.onAddTask});
  final void Function (Task task) onAddTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
   Category _selectedCategory = Category.personal;

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
    widget.onAddTask( 
    Task(title: _titleController.text,
    description: _descriptionController.text, 
    /// date: DateTime(2023, 10, 16, 14, 30), 
    category:_selectedCategory)
    );

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
  maxLength: 100, // Définissez la longueur maximale que vous préférez
  decoration: InputDecoration(
    labelText: 'Description',
  ),
),
          Row(
            children: [
              DropdownButton<Category>(
                items: Category.values.map((category)=> DropdownMenuItem<Category>(
                  value:_selectedCategory,
                  child:Text(
                    category.name.toUpperCase(),
                  ),
                ))
                .toList(),
               onChanged: (value) {
                setState(() {
                  _selectedCategory= value!;
                });  
               },
                 ),
              ElevatedButton(
                onPressed: _submitTaskData,
                child: const Text('Save Task'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../model/task.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [];

  final TextEditingController controller = TextEditingController();

  void addTask() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      tasks.add(Task(title: controller.text));
    });

    controller.clear();
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks")),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Enter task...",
                    ),
                  ),
                ),

                IconButton(onPressed: addTask, icon: const Icon(Icons.add)),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: tasks[index],
                  onDelete: () => deleteTask(index),
                  onToggle: () => toggleTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

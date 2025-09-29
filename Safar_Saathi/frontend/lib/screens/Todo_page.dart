import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<String> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  /// 📌 Step 5: Fetch data from Back4App
  Future<void> loadTodos() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Todo'))
      ..orderByDescending('createdAt'); // latest first

    final response = await query.query();

    if (response.success && response.results != null) {
      setState(() {
        todos = response.results!
            .map((e) => (e as ParseObject).get<String>('title') ?? "")
            .toList();
      });
    }
  }

  /// 📌 Step 4: Save data to Back4App
  Future<void> createTodo(String title) async {
    final todo = ParseObject('Todo')
      ..set('title', title)
      ..set('done', false);

    final response = await todo.save();

    if (response.success) {
      await loadTodos(); // refresh list after saving
    } else {
      print('Error: ${response.error?.message}');
    }
  }

  /// 📌 Show dialog to enter new todo
  void showAddTodoDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("New Todo"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter todo title"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                final text = controller.text.trim();
                if (text.isNotEmpty) {
                  createTodo(text);
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadTodos,
          ),
        ],
      ),
      body: todos.isEmpty
          ? const Center(child: Text("No todos yet."))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(todos[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

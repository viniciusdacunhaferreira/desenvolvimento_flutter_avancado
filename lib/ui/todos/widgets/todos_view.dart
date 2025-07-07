import 'package:flutter/material.dart';

import '../../core/todo_editor_dialog.dart';
import '../view_models/todos_view_model.dart';
import 'todos_list_view.dart';

class TodosView extends StatelessWidget {
  const TodosView({super.key, required this.todoViewModel});

  final TodosViewModel todoViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: ListenableBuilder(
        listenable: todoViewModel.load,
        builder: (context, child) {
          if (todoViewModel.load.isRunning) {
            return const Center(child: CircularProgressIndicator());
          } else if (todoViewModel.load.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Error on load todos.'),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      todoViewModel.load.execute();
                    },
                    child: const Text(
                      'Refresh',
                    ),
                  )
                ],
              ),
            );
          } else {
            return child!;
          }
        },
        child: ListenableBuilder(
          listenable: todoViewModel,
          builder: (context, _) {
            return TodosListView(
              todos: todoViewModel.todos,
              viewModel: todoViewModel,
            );
          },
        ),
      ),
      floatingActionButton: ListenableBuilder(
        listenable: todoViewModel.load,
        builder: (context, _) {
          return Visibility(
            visible: todoViewModel.load.completed,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return TodoEditorDialog.newTodo(
                        onSubmitCommand: todoViewModel.addTodo);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

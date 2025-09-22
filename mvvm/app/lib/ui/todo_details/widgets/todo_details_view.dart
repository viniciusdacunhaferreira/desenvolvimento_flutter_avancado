import 'package:flutter/material.dart';

import '../../../utils/result.dart';
import '../../core/todo_editor_dialog.dart';
import '../view_models/todo_details_view_model.dart';

class TodoDetailsView extends StatefulWidget {
  const TodoDetailsView({
    super.key,
    required this.todoDetailsViewModel,
  });

  final TodoDetailsViewModel todoDetailsViewModel;

  @override
  State<TodoDetailsView> createState() => _TodoDetailsViewState();
}

class _TodoDetailsViewState extends State<TodoDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
      ),
      body: ListenableBuilder(
        listenable: widget.todoDetailsViewModel.load,
        builder: (context, child) {
          if (widget.todoDetailsViewModel.load.isRunning) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.todoDetailsViewModel.load.error) {
            return Center(
              child: Text(
                '${widget.todoDetailsViewModel.load.result!.asError.error}',
              ),
            );
          }
          return child!;
        },
        child: ListenableBuilder(
          listenable: widget.todoDetailsViewModel,
          builder: (context, child) {
            final todo = widget.todoDetailsViewModel.todo;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Todo ID: ${todo.id}'),
                  Text('Todo Title: ${todo.title}'),
                  Text('Todo Description: ${todo.description ?? ''}'),
                  Text('Todo Done: ${todo.done}'),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return TodoEditorDialog.editTodo(
                onSubmitCommand: widget.todoDetailsViewModel.updateTodo,
                toto: widget.todoDetailsViewModel.todo,
              );
            },
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

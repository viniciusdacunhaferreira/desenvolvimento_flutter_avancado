import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/todo.dart';
import '../../../routing/routes.dart';
import '../view_models/todos_view_model.dart';

class TodoListTile extends StatefulWidget {
  const TodoListTile({
    super.key,
    required this.todo,
    required this.viewModel,
  });

  final Todo todo;
  final TodosViewModel viewModel;

  @override
  State<TodoListTile> createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  @override
  void initState() {
    widget.viewModel.deleteTodo.addListener(_onDeleteResult);
    widget.viewModel.toggleTodo.addListener(_onToggleResult);
    super.initState();
  }

  @override
  void dispose() {
    widget.viewModel.deleteTodo.removeListener(_onDeleteResult);
    widget.viewModel.toggleTodo.removeListener(_onToggleResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.todoDetails(widget.todo.id)),
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: widget.todo.done,
            onChanged: (value) {
              widget.viewModel.toggleTodo.execute(widget.todo);
            },
          ),
          trailing: IconButton(
            onPressed: () => widget.viewModel.deleteTodo.execute(widget.todo),
            icon: const Icon(Icons.delete),
          ),
          title: Text(
            widget.todo.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }

  void _onDeleteResult() {
    if (widget.viewModel.deleteTodo.completed) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todo deleted successfully.')),
      );
    }

    if (widget.viewModel.deleteTodo.error) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error on delete todo.')),
      );
    }
  }

  void _onToggleResult() {
    if (widget.viewModel.toggleTodo.error) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error on toggle todo.')),
      );
    }
  }
}

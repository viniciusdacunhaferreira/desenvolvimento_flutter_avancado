import 'package:flutter/material.dart';

import '../../../domain/models/todo.dart';
import '../view_models/todos_view_model.dart';
import 'todo_list_tile.dart';

class TodosListView extends StatefulWidget {
  const TodosListView({
    super.key,
    required this.todos,
    required this.viewModel,
  });

  final List<Todo> todos;
  final TodosViewModel viewModel;

  @override
  State<TodosListView> createState() => _TodosListViewState();
}

class _TodosListViewState extends State<TodosListView> {
  @override
  void initState() {
    widget.viewModel.refresh.addListener(_onResult);
    super.initState();
  }

  @override
  void dispose() {
    widget.viewModel.refresh.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.todos.isEmpty) {
      return const Center(
        child: Text('No todo yet.'),
      );
    }
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await widget.viewModel.refresh.execute();
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 88),
        itemCount: widget.todos.length,
        itemBuilder: (context, index) {
          return TodoListTile(
              todo: widget.todos[index], viewModel: widget.viewModel);
        },
      ),
    );
  }

  void _onResult() {
    if (widget.viewModel.refresh.completed) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos reloaded successfully.')),
      );
    }
    if (widget.viewModel.refresh.error) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error on reload todos.')),
      );
    }
  }
}

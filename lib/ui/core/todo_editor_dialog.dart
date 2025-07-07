import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';
import '../../utils/command.dart';

class TodoEditorDialog extends StatefulWidget {
  const TodoEditorDialog._internal(
      {this.newTodoCommand,
      this.editTodoCommand,
      required this.editorMode,
      required this.initialTitle,
      required this.initialDescription,
      this.id,
      this.done});

  final Command2<void, String?, String?>? newTodoCommand;
  final Command1<void, Todo>? editTodoCommand;
  final bool editorMode;
  final String initialTitle;
  final String initialDescription;
  final String? id;
  final bool? done;

  factory TodoEditorDialog.newTodo({
    required Command2<void, String?, String?> onSubmitCommand,
  }) {
    return TodoEditorDialog._internal(
      newTodoCommand: onSubmitCommand,
      editorMode: false,
      initialTitle: '',
      initialDescription: '',
    );
  }

  factory TodoEditorDialog.editTodo({
    required Command1<void, Todo> onSubmitCommand,
    required Todo toto,
  }) {
    return TodoEditorDialog._internal(
      editTodoCommand: onSubmitCommand,
      editorMode: true,
      initialTitle: toto.title,
      initialDescription: toto.description ?? '',
      id: toto.id,
      done: toto.done,
    );
  }

  @override
  State<TodoEditorDialog> createState() => _TodoEditorDialogState();
}

class _TodoEditorDialogState extends State<TodoEditorDialog> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _title.text = widget.initialTitle;
    _description.text = widget.initialDescription;
    if (widget.editorMode) widget.editTodoCommand?.addListener(_onResult);
    if (!widget.editorMode) widget.newTodoCommand?.addListener(_onResult);
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    if (widget.editorMode) widget.editTodoCommand?.removeListener(_onResult);
    if (!widget.editorMode) widget.newTodoCommand?.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.editorMode ? 'Edit Todo' : 'New Todo'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return 'Title is invalid';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _description,
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.editorMode) {
                widget.editTodoCommand?.execute(
                  Todo(
                    id: widget.id!,
                    title: _title.text,
                    done: widget.done!,
                    description: _description.text,
                  ),
                );
              } else {
                widget.newTodoCommand?.execute(
                  _title.text,
                  _description.text,
                );
              }
            }
          },
          child: const Text('Ok'),
        )
      ],
    );
  }

  void _onResult() {
    if (widget.newTodoCommand?.isRunning == true ||
        widget.editTodoCommand?.isRunning == true) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            content: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    } else {
      if (widget.newTodoCommand?.completed == true ||
          widget.editTodoCommand?.completed == true) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.editorMode
                  ? 'Todo edited successfully'
                  : 'Todo created successfully.',
            ),
          ),
        );
      }
      if (widget.newTodoCommand?.error == true ||
          widget.editTodoCommand?.error == true) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.editorMode
                  ? 'Error on edit todo'
                  : 'Error on create todo.',
            ),
          ),
        );
      }

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }
}

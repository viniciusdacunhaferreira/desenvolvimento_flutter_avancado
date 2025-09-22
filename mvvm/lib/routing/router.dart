import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/todo_details/view_models/todo_details_view_model.dart';
import '../ui/todo_details/widgets/todo_details_view.dart';
import '../ui/todos/view_models/todos_view_model.dart';
import '../ui/todos/widgets/todos_view.dart';
import 'routes.dart';

GoRouter routerConfig() {
  return GoRouter(
    initialLocation: Routes.todos,
    routes: [
      GoRoute(
        path: Routes.todos,
        builder: (context, state) {
          return TodosView(
            todoViewModel: TodosViewModel(
              todoRepository: context.read(),
              updateUseCase: context.read(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final todoDetailsViewModel = TodoDetailsViewModel(
                updateTodoUseCase: context.read(),
                todosRepository: context.read(),
              );

              todoDetailsViewModel.load.execute(id);

              return TodoDetailsView(
                todoDetailsViewModel: todoDetailsViewModel,
              );
            },
          )
        ],
      ),
    ],
  );
}

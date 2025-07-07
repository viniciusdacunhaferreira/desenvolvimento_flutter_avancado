import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/todo/todos_repository.dart';
import '../data/repositories/todo/todos_repository_dev.dart';
import '../data/repositories/todo/todos_repository_remote.dart';
import '../data/services/api/api_client.dart';
import '../domain/use_cases/todo/todo_update_use_case.dart';

List<SingleChildWidget> _providersShared = [
  Provider(
    create: (context) => TodoUpdateUseCase(
      todosRepository: context.read(),
    ),
  )
];

List<SingleChildWidget> get providersRemote {
  return [
    Provider(
      create: (context) => ApiClient(host: '192.168.1.14', port: 3000),
    ),
    ChangeNotifierProvider(
      create: (context) => TodosRepositoryRemote(
        apiClient: context.read(),
      ) as TodosRepository,
    ),
    ..._providersShared,
  ];
}

List<SingleChildWidget> get providersLocal {
  return [
    ChangeNotifierProvider(
      create: (context) => TodosRepositoryDev() as TodosRepository,
    ),
    ..._providersShared,
  ];
}

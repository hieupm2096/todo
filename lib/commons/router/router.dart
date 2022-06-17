import 'package:auto_route/auto_route.dart';
import 'package:todo/features/task/pages/all_task_page.dart';
import 'package:todo/features/task/pages/complete_task_page.dart';
import 'package:todo/features/task/pages/incomplete_task_page.dart';
import 'package:todo/features/task/pages/task_tab_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/task',
      page: TaskTabPage,
      initial: true,
      children: [
        AutoRoute(path: '', page: AllTaskPage),
        AutoRoute(path: 'complete', page: CompleteTaskPage),
        AutoRoute(path: 'incomplete', page: IncompleteTaskPage),
      ],
    ),
  ],
)
class $AppRouter {}

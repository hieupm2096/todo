// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:todo/features/task/pages/all_task_page.dart' as _i2;
import 'package:todo/features/task/pages/complete_task_page.dart' as _i3;
import 'package:todo/features/task/pages/incomplete_task_page.dart' as _i4;
import 'package:todo/features/task/pages/task_tab_page.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    TaskTabRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i5.WrappedRoute(child: const _i1.TaskTabPage()));
    },
    AllTaskRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.AllTaskPage());
    },
    CompleteTaskRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.CompleteTaskPage());
    },
    IncompleteTaskRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.IncompleteTaskPage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig('/#redirect',
            path: '/', redirectTo: '/task', fullMatch: true),
        _i5.RouteConfig(TaskTabRoute.name, path: '/task', children: [
          _i5.RouteConfig(AllTaskRoute.name,
              path: '', parent: TaskTabRoute.name),
          _i5.RouteConfig(CompleteTaskRoute.name,
              path: 'complete', parent: TaskTabRoute.name),
          _i5.RouteConfig(IncompleteTaskRoute.name,
              path: 'incomplete', parent: TaskTabRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.TaskTabPage]
class TaskTabRoute extends _i5.PageRouteInfo<void> {
  const TaskTabRoute({List<_i5.PageRouteInfo>? children})
      : super(TaskTabRoute.name, path: '/task', initialChildren: children);

  static const String name = 'TaskTabRoute';
}

/// generated route for
/// [_i2.AllTaskPage]
class AllTaskRoute extends _i5.PageRouteInfo<void> {
  const AllTaskRoute() : super(AllTaskRoute.name, path: '');

  static const String name = 'AllTaskRoute';
}

/// generated route for
/// [_i3.CompleteTaskPage]
class CompleteTaskRoute extends _i5.PageRouteInfo<void> {
  const CompleteTaskRoute() : super(CompleteTaskRoute.name, path: 'complete');

  static const String name = 'CompleteTaskRoute';
}

/// generated route for
/// [_i4.IncompleteTaskPage]
class IncompleteTaskRoute extends _i5.PageRouteInfo<void> {
  const IncompleteTaskRoute()
      : super(IncompleteTaskRoute.name, path: 'incomplete');

  static const String name = 'IncompleteTaskRoute';
}

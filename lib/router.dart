import 'package:cps_patient/presentation/file/screens/file_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cps_patient/presentation/login/screens/login_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
        path: 'file',
        builder: (BuildContext context, GoRouterState state) {
          return const FileScreen();
        })
  ],
);

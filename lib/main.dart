import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection_container.dart';
import 'presentation/blocs/auth_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Clean Architecture',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        },
        initialRoute: '/',
      ),
    );
  }
}

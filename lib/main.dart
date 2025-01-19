import 'package:cps_patient/application/blocs/pdf_bloc.dart';
import 'package:cps_patient/application/blocs/report_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection_container.dart';
import 'application/blocs/auth_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider<ReportBloc>(create: (_) => getIt<ReportBloc>()),
        BlocProvider(create: (_) => getIt<PdfBloc>()),
      ],
      child: MaterialApp(
        title: 'نظام علم الأمراض',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        },
        initialRoute: '/',
      ),
    );
  }
}

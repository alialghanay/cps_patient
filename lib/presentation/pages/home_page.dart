import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/blocs/report_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocProvider(
        create: (_) => context.read<ReportBloc>()..add(FetchReportEvent()),
        child: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            if (state is ReportLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReportError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ReportLoaded) {
              final report = state.report;
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Text('Hello, ${report.patient.name}'),
                  Text('File No: ${report.fileNo}'),
                  Text('File Status: ${report.status}'),
                ],
              );
            }
            return const Center(child: Text('No data available.'));
          },
        ),
      ),
    );
  }
}

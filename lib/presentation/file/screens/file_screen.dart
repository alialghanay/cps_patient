import 'package:cps_patient/domain/file_domain/get_file_repostry_impl.dart';
import 'package:cps_patient/models/file_model.dart';
import 'package:cps_patient/presentation/file/widgets/file_state.dart';
import 'package:cps_patient/presentation/login/screens/login_screen.dart';
import 'package:cps_patient/services/pdf_service.dart';
import 'package:cps_patient/services/auth_service_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cps_patient/presentation/file/widgets/file_details.dart';
import 'package:cps_patient/presentation/styles/theme.dart';
import 'package:cps_patient/presentation/file/cubit/file_cubit.dart';
import 'package:cps_patient/presentation/file/cubit/file_state.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({super.key});

  @override
  _FileScreenState createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  String _username = ''; // ✅ Holds logged-in user's name

  @override
  void initState() {
    super.initState();
    _loadUserData(); // ✅ Load user details on screen init
  }

  Future<void> _loadUserData() async {
    final prefs = SharedPrefService();
    final username = await prefs.getName(); // Fetch username from shared prefs
    if (username != null) {
      setState(() {
        _username = username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FileCubit(FileRepositoryImpl())..fetchPatientReport(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('مرحبا $_username'), // ✅ Shows logged-in user’s name
          actions: [
            IconButton(
              icon: const Icon(Icons.logout,
                  color: Colors.white), // ✅ Logout icon
              onPressed: () =>
                  _confirmLogout(context), // ✅ Call logout function
            ),
          ],
        ),
        body: BlocBuilder<FileCubit, FileState>(
          builder: (context, state) {
            if (state is FileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FileSuccess) {
              final file = state.file;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    FileDetailsWidget(file: file), // Reusable widget
                    const SizedBox(height: 20),
                    FileStateWidget(
                        currentState: file.status), // ✅ Status Widget
                    const SizedBox(height: 20),

                    // ✅ Add the "Download PDF" button only if the file is ready
                    if (file.status == FileStatus.ready_download)
                      ElevatedButton.icon(
                        onPressed: () async {
                          await PdfService.downloadReport(file.id, context);
                        },
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text(
                            'تحميل التقرير'), // Arabic for "Download Report"
                        style: ElevatedButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                  ],
                ),
              );
            } else if (state is FileFailure) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'حدث خطأ أثناء تحميل التقرير', // Arabic for "An error occurred while loading the report"
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.red,
                          ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<FileCubit>().fetchPatientReport();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('إعادة المحاولة'), // Arabic for "Retry"
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// ✅ Show confirmation dialog before logging out
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد تسجيل الخروج'),
          content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _logout(context); // Perform logout
              },
              child: const Text('تسجيل الخروج',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  /// ✅ Logout function
  void _logout(BuildContext context) async {
    final prefs = SharedPrefService();
    await prefs.removeToken(); // ✅ Remove stored token
    await prefs.removeName(); // ✅ Clear username

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const LoginScreen()), // ✅ Redirect to login
    );
  }
}

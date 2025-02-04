import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ Import url_launcher
import 'package:cps_patient/presentation/login/cubit/login_cubit.dart';
import 'package:cps_patient/presentation/login/cubit/login_state.dart';
import 'package:cps_patient/presentation/styles/theme.dart';
import '../../../domain/login_domain/login_repostry_impl.dart';
import '../../file/screens/file_screen.dart';
import '../widgets/login_text_feild.dart';
import '../widgets/password_felid.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// ✅ Function to open the forgot password link in a browser
  Future<void> _launchForgotPassword() async {
    const String resetPasswordUrl = "http://localhost:3000/auth/reset-password";

    if (await canLaunchUrl(Uri.parse(resetPasswordUrl))) {
      await launchUrl(Uri.parse(resetPasswordUrl),
          mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تعذر فتح الرابط. يرجى المحاولة مرة أخرى."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مستشفي طرابلس المركزي'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocListener<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const FileScreen()),
                      );
                    } else if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Image(
                        image: AssetImage('assets/logo.png'),
                        height: 100,
                      ),
                      const SizedBox(height: 40),
                      LoginTextField(
                        labelText: 'اسم المستخدم',
                        hintText: 'أدخل اسم المستخدم الخاص بك',
                        prefixIcon: Icons.person,
                        controller: _usernameController,
                      ),
                      const SizedBox(height: 20),
                      PasswordField(
                        labelText: 'كلمة المرور',
                        hintText: 'أدخل كلمة المرور الخاصة بك',
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 10),

                      /// ✅ Forgot Password Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed:
                              _launchForgotPassword, // ✅ Open reset password link
                          child: const Text(
                            "هل نسيت كلمة المرور؟", // Arabic for "Forgot Password?"
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// ✅ Login Button
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ElevatedButton(
                            onPressed: () {
                              final username = _usernameController.text.trim();
                              final password = _passwordController.text.trim();

                              if (username.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "يرجى ملء جميع الحقول"), // Arabic for "Please fill in all fields"
                                  ),
                                );
                              } else {
                                context
                                    .read<LoginCubit>()
                                    .login(username, password);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: AppTheme.primaryColor,
                            ),
                            child: const Text(
                              'تسجيل الدخول', // Arabic for "Login"
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

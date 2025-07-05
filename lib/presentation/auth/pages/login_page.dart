import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/core/routes/custom_page_route.dart';
import 'package:tekmob_hitnews/presentation/auth/pages/signup_page.dart';
import 'package:tekmob_hitnews/presentation/main_wrapper_page.dart';
import 'package:tekmob_hitnews/presentation/auth/widgets/auth_form_field.dart'; // Import AuthFormField
import 'package:tekmob_hitnews/presentation/auth/widgets/social_login_buttons.dart'; // Import SocialLoginButton

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
    print('Remember Me: $_rememberMe');

    Navigator.of(
      context,
    ).pushReplacement(CustomPageRoute(child: const MainWrapperPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text(
                'Hello Again!',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome back, you\'ve been missed!',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 40),
              // Menggunakan AuthFormField
              AuthFormField(
                controller: _emailController,
                labelText: 'Email Address',
                hintText: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              // Menggunakan AuthFormField untuk password
              AuthFormField(
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _rememberMe = newValue!;
                          });
                        },
                        activeColor: AppColors.primaryColor,
                        checkColor: AppColors.whiteColor,
                      ),
                      Text(
                        'Remember me',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      print('Forgot password?');
                    },
                    child: Text(
                      'Forgot the password ?',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Theme.of(context).dividerColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Or continue with',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Theme.of(context).dividerColor),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  // Menggunakan SocialLoginButton
                  SocialLoginButton(
                    imagePath: 'assets/images/google.png',
                    text: 'Google',
                    onPressed: () {
                      print('Login with Google');
                    },
                  ),
                  const SizedBox(width: 30),
                  // Menggunakan SocialLoginButton
                  SocialLoginButton(
                    imagePath: 'assets/images/facebook.png',
                    text: 'Facebook',
                    onPressed: () {
                      print('Login with Facebook');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CustomPageRoute(child: const SignUpPage()),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

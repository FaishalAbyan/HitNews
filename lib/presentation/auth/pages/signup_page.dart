import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:tekmob_hitnews/core/routes/custom_page_route.dart';
import 'package:tekmob_hitnews/presentation/auth/pages/login_page.dart';
import 'package:tekmob_hitnews/presentation/main_wrapper_page.dart';
import 'package:tekmob_hitnews/presentation/auth/widgets/auth_form_field.dart';
import 'package:tekmob_hitnews/presentation/auth/widgets/social_login_buttons.dart'; // Import kembali SocialLoginButton
import 'package:tekmob_hitnews/presentation/providers/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password and Confirm Password do not match.'),
          backgroundColor: AppColors.errorColor,
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.signUp(_emailController.text, _passwordController.text);

    if (authProvider.status == AuthStatus.authenticated) {
      Navigator.of(
        context,
      ).pushReplacement(CustomPageRoute(child: const MainWrapperPage()));
    } else if (authProvider.status == AuthStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
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
                'Create Account',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to get started!',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 40),
              AuthFormField(
                controller: _fullNameController,
                labelText: 'Full Name',
                hintText: 'Enter your full name',
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              AuthFormField(
                controller: _emailController,
                labelText: 'Email Address',
                hintText: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              AuthFormField(
                controller: _confirmPasswordController,
                labelText: 'Confirm Password',
                hintText: 'Re-enter your password',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscureConfirmText,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmText = !_obscureConfirmText;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return ElevatedButton(
                      onPressed:
                          authProvider.status == AuthStatus.loading
                              ? null
                              : _signUp,
                      child:
                          authProvider.status == AuthStatus.loading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.whiteColor,
                                  strokeWidth: 2,
                                ),
                              )
                              : const Text('Sign Up'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30), // Mengembalikan SizedBox
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
              const SizedBox(height: 30), // Mengembalikan SizedBox
              Row(
                children: [
                  SocialLoginButton(
                    imagePath: 'assets/images/google.png',
                    text: 'Google',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Pendaftaran dengan Google belum tersedia.',
                          ),
                          backgroundColor: AppColors.primaryColor,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  SocialLoginButton(
                    imagePath: 'assets/images/facebook.png',
                    text: 'Facebook',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Pendaftaran dengan Facebook belum tersedia.',
                          ),
                          backgroundColor: AppColors.primaryColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CustomPageRoute(child: const LoginPage()),
                      );
                    },
                    child: Text(
                      'Login',
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

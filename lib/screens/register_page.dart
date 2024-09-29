import 'package:flutter/material.dart';
import 'package:flutter_application/wigget/butom_wigget.dart';
import 'package:flutter_application/wigget/input_wigget.dart';

import '../models/user.dart';
import '../service/userService.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String? errorMessage;
  String? successMessage;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/image/hinh-anh-binh-minh-luc-mat-troi-moc.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Text(
                          'Register',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: media.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              InputWidget(
                                label: 'Email',
                                obscureText: false,
                                onChanged: (value) {
                                  email = value;
                                },
                                icon: null,
                                onIconPressed: () {},
                              ),
                              const SizedBox(height: 20),
                              InputWidget(
                                label: 'Password',
                                obscureText: !isPasswordVisible,
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onChanged: (value) {
                                  password = value;
                                },
                                onIconPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              InputWidget(
                                label: 'Confirm Password',
                                obscureText: !isConfirmPasswordVisible,
                                icon: Icon(
                                  isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onChanged: (value) {
                                  confirmPassword = value;
                                },
                                onIconPressed: () {
                                  setState(() {
                                    isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              if (errorMessage != null)
                                Text(
                                  errorMessage!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              if (successMessage != null)
                                Text(
                                  successMessage!,
                                  style: TextStyle(color: Colors.green),
                                ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.center,
                                child: ButtonWidget(
                                  name: "Register",
                                  color: Colors.blue,
                                  fontSize: 12,
                                  onPressed: () async {
                                    setState(() {
                                      errorMessage = null;
                                      successMessage = null;
                                      isLoading = true;
                                    });

                                    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                                      setState(() {
                                        errorMessage = 'Please fill in all fields.';
                                        isLoading = false;
                                      });
                                    } else if (password != confirmPassword) {
                                      setState(() {
                                        errorMessage = 'Passwords do not match.';
                                        isLoading = false;
                                      });
                                    } else {
                                      try {
                                        //gio thoi gian cho
                                        await Future.delayed(Duration(seconds: 2));
                                        User newUser = User(userName: email, password: password);
                                        await registerUser(newUser);

                                        setState(() {
                                          successMessage = 'Registration successful!';
                                          isLoading = false;
                                        });
                                      } catch (e) {
                                        setState(() {
                                          errorMessage = 'Registration failed. Please try again.';
                                          isLoading = false;
                                        });
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.white.withOpacity(0.4),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

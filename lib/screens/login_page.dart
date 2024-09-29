import 'package:flutter/material.dart';
import 'package:flutter_application/screens/index_page.dart';
import 'package:flutter_application/screens/wellcome_page.dart';
import 'package:flutter_application/service/userService.dart';
import 'package:flutter_application/wigget/butom_wigget.dart';
import 'package:flutter_application/wigget/input_wigget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool isPasswordVisible = false;
  String? errorMessage;
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WellcomePage(),
                              ),
                            );
                          },
                        ),
                        const Text(
                          'Login',
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
                              if (errorMessage != null) // Hiển thị thông báo lỗi
                                Text(
                                  errorMessage!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: ButtonWidget(
                                  name: "Sign In",
                                  color: Colors.blue,
                                  fontSize: 12,
                                  onPressed: () async {
                                    setState(() {
                                      errorMessage = null;
                                      isLoading = true;
                                    });

                                    if (email.isEmpty || password.isEmpty) {
                                      setState(() {
                                        errorMessage = 'Please enter your email and password.';
                                        isLoading = false;
                                      });
                                      return;
                                    }

                                    try {
                                      await Future.delayed(Duration(seconds: 2));

                                      User user = User(userName: email, password: password);
                                      int? userId = await loginUser(user);
                                      print(userId);
                                      if (userId == null) {
                                        setState(() {
                                          errorMessage = 'Invalid email or password.';
                                          isLoading = false;
                                        });
                                      } else {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        await prefs.setInt('userId', userId);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TodoPage(),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      setState(() {
                                        errorMessage = 'Login failed. Please try again.';
                                        isLoading = false;
                                      });
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
            if (isLoading) // Hiển thị CircularProgressIndicator khi isLoading là true
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

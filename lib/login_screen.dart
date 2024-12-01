import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main_menu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errorMessage = '';

  Future<void> _login() async {
// Tentukan username dan password yang valid
    const String validUsername = 'user';
    const String validPassword = '123';

    final String enteredUsername = _usernameController.text;
    final String enteredPassword = _passwordController.text;

    if (enteredUsername.isEmpty || enteredPassword.isEmpty) {
      setState(() {
        errorMessage = 'Username and password are required';
      });
      return;
    }

    if (enteredUsername == validUsername && enteredPassword == validPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainMenu()),
      );
    } else {
      setState(() {
        errorMessage = 'Invalid username or password';
      });
    }

    // const bool isDebugMode = true; // Set to false for production

    // if (isDebugMode) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => MainMenu()),
    //   );
    //   return;
    // }

    // Perform usual login logic here
    // final String enteredUsername = _usernameController.text;
    // final String enteredPassword = _passwordController.text;

    // if (enteredUsername.isEmpty || enteredPassword.isEmpty) {
    //   setState(() {
    //     errorMessage = 'Username and password are required';
    //   });
    //   return;
    // }

    // const String apiUrl = 'http://localhost:5000/users/login';

    // try {
    //   final response = await http.post(
    //     Uri.parse(apiUrl),
    //     headers: {'Content-Type': 'application/json'},
    //     body: json.encode({
    //       'username': enteredUsername,
    //       'password': enteredPassword,
    //     }),
    //   );

    //   if (response.statusCode == 200) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => MainMenu()),
    //     );
    //   } else {
    //     setState(() {
    //       errorMessage = 'Invalid username or password';
    //     });
    //   }
    // } catch (e) {
    //   setState(() {
    //     errorMessage = 'Failed to connect to the server';
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    const double labelTextSize = 14.0;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    'RamyCook',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Let's Cook for Your Long Life!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Username',
                    style: TextStyle(
                      fontSize: labelTextSize,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: 230,
                    child: TextField(
                      controller: _usernameController,
                      style: TextStyle(
                        fontSize: labelTextSize,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(
                          fontSize: labelTextSize,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: labelTextSize,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: 230,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(
                        fontSize: labelTextSize,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          fontSize: labelTextSize,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Forgot your password?',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      minimumSize: Size(200, 50),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: labelTextSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

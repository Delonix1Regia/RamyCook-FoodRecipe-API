import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) =>
                const LoginScreen()), 
        (Route<dynamic> route) => false, 
      );
    });
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg1.png'),
          Center(
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
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
                  // const SizedBox(height: 300),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     print('Pressed');
                  //     // Tambahkan logika navigasi atau aksi lain di sini
                  //   },
                  //   child: Text('Start Cooking!'),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor:
                  //         Colors.white, // Warna latar belakang tombol
                  //     foregroundColor: Colors.black, // Warna teks tombol
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 20, vertical: 10), // Padding tombol
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'form/home.dart'; // Import màn hình HomePage
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0), // Màu nền
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hình ảnh phía trên
            Container(
              height: 190,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/signin.png'), // Đặt ảnh của bạn vào đây
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Phần nội dung đăng nhập
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Connect Smart Safety Energy",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  // TextField Email
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      filled: true,
                      fillColor: Colors.black,
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Thay đổi màu border thành trắng
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  // TextField Password
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.black,
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Thay đổi màu border thành trắng
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  // Quên mật khẩu
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Xử lý khi nhấn Quên mật khẩu
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Nút Login
                  ElevatedButton(
                    onPressed: () {
                      // Điều hướng tới màn hình HomePage khi nhấn Login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 21, 66, 103), // Màu nền của nút
                      minimumSize:
                          Size(double.infinity, 50), // Nút full chiều rộng
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'or',
                    style: TextStyle(color: Colors.white54),
                  ),
                  SizedBox(height: 10),
                  // Nút đăng nhập với Apple
                  ElevatedButton.icon(
                    onPressed: () {
                      // Xử lý khi nhấn Đăng nhập với Apple
                    },
                    icon: Icon(Icons.apple),
                    label: Text('Đăng nhập với Apple'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 182, 53, 53),
                      backgroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Nút đăng nhập với Google
                  ElevatedButton.icon(
                    onPressed: () {
                      // Xử lý khi nhấn Đăng nhập với Google
                    },
                    icon: Icon(Icons.g_mobiledata),
                    label: Text('Đăng nhập với Google'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  // Tạo tài khoản mới
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bạn chưa có tài khoản?",
                        style: TextStyle(color: Colors.white54),
                      ),
                      TextButton(
                        onPressed: () {
                          // Xử lý khi nhấn Đăng ký
                        },
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

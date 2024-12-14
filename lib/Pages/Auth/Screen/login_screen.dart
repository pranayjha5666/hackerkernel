import 'package:flutter/material.dart';
import '../Services/auth_services.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});
  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _isPasswordVisible = false;
  final AuthServices _authServices = AuthServices();

  void login() async {
    setState(() {
      isLoading = true;
    });

    await _authServices.login(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/imgofdonee.png",
                    width: double.infinity,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: InputBorder.none,
                      labelText: 'Email ID',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff239ED0)),
                        ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff239ED0)),
                      ),
                      border: InputBorder.none,
                      suffix: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: Color(0xff239ED0),
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 20),
                  isLoading
                      ? CircularProgressIndicator()
                      : Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: login,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: Color(0xff239ED0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Colors.blue, width: 2),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "OR",
                        style: TextStyle(
                            color: Colors.black26, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.white54,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google.png",
                          height: 20,
                        ),
                        SizedBox(width: 30),
                        Text(
                          'Login with Google',
                          style: TextStyle(
                              color: Color(0xff414a4c),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New to Logistics?",
                        style: TextStyle(
                            color: Color(0xff414a4c),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Register",
                        style: TextStyle(color: Color(0xff239ED0)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/

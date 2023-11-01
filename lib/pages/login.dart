import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome back to MedInvent',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const Text(
              'You have to sign in to continue',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 50, 100, 20),
              child: Image.asset('assets/images/login.jpg',),
            ),
            const SizedBox(height: 20),
            _buildInputField(
              const Icon(Icons.person, color: Colors.grey),
              'Email/Phone No',
              false,
            ),
            const SizedBox(height: 15),
            _buildInputField(
              const Icon(Icons.lock, color: Colors.grey),
              'Password',
              true,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 60.0, top: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                    'Forgot Password?'
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF2980B9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: const Size(0, 50.0),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            )
            ,
            const SizedBox(height: 30),

            const Text('New to MedInvent? Register here'),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(Icon prefixIcon, String hint, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
            child: prefixIcon,
          ),
          hintText: hint,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:recipe/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginForm(),
          _loginButton(),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Recipes",
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a username";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Username",
              ),
            ),
            TextFormField(
              obscureText: true,
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "Enter a password";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            if (username != null && password != null) {
              bool result = await AuthService().login(username!, password!);
              if (!mounted) return; // Ensure widget is still in the widget tree
              if (result) {
                Navigator.pushReplacementNamed(context, "/home");
              } else {
                StatusAlert.show(
                  context,
                  duration: const Duration(seconds: 2),
                  title: 'Login Failed',
                  subtitle: 'Please Try Again',
                  configuration: const IconConfiguration(
                    icon: Icons.error,
                  ),
                  maxWidth: 260,
                );
              }
            }
          }
        },
        child: const Text("Login"),
      ),
    );
  }
}
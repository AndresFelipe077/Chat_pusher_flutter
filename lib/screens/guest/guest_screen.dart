import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

const users = const {'felipe@gmail.com': '123'};

class GuestScreen extends StatelessWidget {
  const GuestScreen({super.key});

  static const routeName = "guest";

  Duration get loginTime => Duration(microseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password:${data.password}');

    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User no exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      scrollable: true,
      hideForgotPasswordButton: true,
      title: 'Chat',
      theme: LoginTheme(
          titleStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white
          ),
      ),
      logo: const AssetImage('assets/images/chat.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      userValidator: (value) {
        if (value == null || !value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      passwordValidator: (value) {
        if (value == null || value.length < 5) {
          return "Please must be at least 5 chars";
        }
        return null;
      },
      onSubmitAnimationCompleted: () {},
      onRecoverPassword: _recoverPassword,
    );
  }
}

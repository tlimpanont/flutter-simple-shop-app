import 'package:flutter/material.dart';
import 'package:flutter_app/simple_webshop/reblocs/AppState.dart';
import 'package:flutter_app/simple_webshop/reblocs/AuthenticationActions.dart';
import 'package:rebloc/rebloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _emailController.text = 'theuy.limpanont@gmail.com';
    _passwordController.text = '12345';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, bool>(
      converter: (AppState state) => state.isLoading,
      builder: (context, dispatcher, bool isLoading) => Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "company@demo.nl", labelText: "Email"),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration:
                        InputDecoration(hintText: "", labelText: "Password"),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          if (!isLoading) {
                            dispatcher(SignInUser(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim()));
                          }
                        },
                        child: (isLoading)
                            ? Text('logging in...')
                            : Text('Login '),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
    );
  }
}

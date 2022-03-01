import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/login/login_bloc.dart';
import 'package:flutter_miarmapp/models/login_dto.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repository_impl.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(authRepository);
        },
        child: _createBody(context));
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: <Widget>[
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo_titulo.png',
                      width: 300,
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Recovery Password \n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.grey,
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextButton(
                      child: const Text('Log In',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255))),
                      style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 101, 233)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Not a member?'),
                    TextButton(
                      child: const Text(
                        'Register now',
                        style: TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                    Color(0x55FFFFFF),
                                    Color(0xFF0000000),
                                  ])),
                                )),
                            Expanded(
                              flex: 2,
                              child: const Text(
                                '            Or continue',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                    Color(0xFF0000000),
                                    Color(0xFFFFFFFF)
                                  ])),
                                )),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                          width: 50,
                        ),
                        Image.network(
                          'https://cdn3.iconfinder.com/data/icons/picons-social/57/56-apple-512.png',
                          width: 70,
                        ),
                        Image.network(
                          'https://cdn3.iconfinder.com/data/icons/capsocial-round/500/facebook-512.png',
                          width: 50,
                        )
                      ],
                    )
                  ],
                )
              ],
            )));
  }*/

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: const Color(0xff0F7EDD),
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (context, state) {
              return state is LoginSuccessState || state is LoginErrorState;
            }, listener: (context, state) {
              if (state is LoginSuccessState) {
                // Shared preferences > guardo el token
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is LoginInitialState || state is LoginLoadingState;
            }, builder: (ctx, state) {
              if (state is LoginInitialState) {
                return buildForm(ctx);
              } else if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return buildForm(ctx);
              }
            })),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.email),
                  suffixIconColor: Colors.white,
                  hintText: 'Email',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value == null || !value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.vpn_key),
                  suffixIconColor: Colors.white,
                  hintText: 'Password',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (value) {
                return (value == null || value.isEmpty)
                    ? 'Write a password'
                    : null;
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                final loginDto = LoginDto(
                    email: emailController.text,
                    password: passwordController.text);
                BlocProvider.of<LoginBloc>(context).add(DoLoginEvent(loginDto));
              }
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'Sign In'.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
    );
  }
}

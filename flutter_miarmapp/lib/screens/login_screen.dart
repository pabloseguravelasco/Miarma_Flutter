import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
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
  }
}

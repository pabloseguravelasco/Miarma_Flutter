import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_miarmapp/constants.dart';
import 'package:flutter_miarmapp/models/post_response.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/public_post/public_post_bloc.dart';
import '../preferences_utils.dart';
import '../repository/post_repository/post_repository.dart';
import '../repository/post_repository/post_repository_impl.dart';
import '../widgets/error_page.dart';
import 'menu_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (context) {
        return PostsBloc(postRepository)..add(const FetchPostWithType());
      },
      child: Scaffold(body: _createSeeProfile(context)),
    ));
  }

  Widget _createSeeProfile(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserFetchedError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<UserBloc>().add(const FetchUserWithType());
            },
          );
        } else if (state is UserFetched) {
          return _createProfile(context, state.usuarioDTO);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _createProfile(BuildContext context, UsuarioDTO usuarioDTO) {
    final contentWidth = MediaQuery.of(context).size.width;
    final contentHeight = MediaQuery.of(context).size.height;

    String imageUrlAvatar =
        usuarioDTO.avatar.replaceAll("http://localhost:8080", Constant.apiUrl);

    return Container(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Icon(Icons.lock),
                  SizedBox(width: 4.0),
                  Text(
                    usuarioDTO.nick,
                    style: TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
                  ),
                  SizedBox(width: 12.0),
                  Container(
                    alignment: Alignment.center,
                    width: 35.0,
                    height: 25.0,
                  )
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.add_box_outlined),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.send),
                    )
                  ],
                ))
          ],
        )),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: new CircleAvatar(
                            backgroundImage: NetworkImage(imageUrlAvatar),
                            radius: 55.0,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              usuarioDTO.numeroPublicaciones.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "Posts",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              usuarioDTO.numeroSeguidores.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "Seguidores",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              usuarioDTO.numeroSeguidos.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "Seguidos",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pablo Segura Velasco",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Text("Sevilla",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ])),
                  SizedBox(height: 12.0),
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 350.0,
                            height: 35.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                width: 2.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            child: Text("Editar Perfil",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ),
                          Icon(Icons.expand_more_outlined,
                              color: Color.fromARGB(255, 0, 0, 0))
                        ]),
                  ),
                  SizedBox(height: 24.0),
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 350.0,
                            height: 35.0,
                            child: Text("Historias Destacadas",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold)),
                          ),
                          Icon(Icons.expand_more_outlined,
                              color: Color.fromARGB(255, 0, 0, 0))
                        ]),
                  ),
                  Divider(
                    color: Colors.grey[800],
                    thickness: 2.0,
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200.0,
                          child: Icon(Icons.grid_on_outlined,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Container(
                          width: 150.0,
                          child: Icon(Icons.portrait_outlined,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.0),
                  Center(
                      child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                      child: Icon(Icons.photo_camera_outlined,
                          color: Color.fromARGB(255, 0, 0, 0), size: 40.0),
                    ),
                    SizedBox(height: 10),
                    Text("No hay Publicaciones",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0)),
                  ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, message) {}

  buildForm(BuildContext ctx) {}
}

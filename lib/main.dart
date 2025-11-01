import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/src/views/admin_todo_page.dart';
import 'package:todo_app/src/views/home_page.dart';
import 'package:todo_app/src/views/login_page.dart';
import 'package:todo_app/src/views/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/login', 
        routes: [
          GoRoute(
            path: '/login',
            name: 'login_page',
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: '/register',
            name: 'register_page',
            builder: (context, state) => RegisterPage(),
          ),
          GoRoute(
            path: '/todos', 
            name: 'todo-list',
            builder: (context, state) => HomePage(),
            routes: [
              GoRoute(
                path: 'create', 
                name: 'new-todo',
                builder: (context, state) => AdminTodoPage(),
              ),
              GoRoute(
                path: ':id', 
                name: 'update-todo',
                builder: (context, state) {
                  print(state.pathParameters);
                  final todo = state.extra as Map<String, dynamic>?; 
                  return AdminTodoPage(todo: todo);
                },
              ),
            ],
          ),
          // GoRoute(
          //   path: '/admin', 
          //   name: 'admin',
          //   builder: (context, state) => AdminTodoPage(),
          // ),
        ],
      ),
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue, 
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue, 
        foregroundColor: Colors.white,
      ),
      useMaterial3: true,
    ),
      debugShowCheckedModeBanner: false,
      title: 'Todo - App',
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/shared/utils.dart'; 
import 'package:todo_app/src/widgets/custom_textfield.dart'; 
import 'package:todo_app/api/todos.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController(); 

  void _login() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    final userFound = logins.any((user) => 
        user['user'] == email && user['password'] == password
    );

    if (userFound) {
      
      Utils.showSnackBar(
        context: context, 
        title: '¡Bienvenido(a)!', 
        color: Colors.green
      );
      
      context.go('/todos'); 
    
    } else {
      Utils.showSnackBar(
        context: context, 
        title: 'Credenciales inválidas. Usuario o contraseña incorrectos.', 
        color: Colors.red
      );
    }
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Bienvenido de nuevo', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue[800])),
              const Text('Accede a tu Cuenta', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 40),

           
              CustomTextField(
                controller: _emailController,
                labelText: 'Correo Institucional',
               keyboardType: TextInputType.emailAddress,
                // Validación simple para el login
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              
              
              CustomTextField(
                controller: _passwordController,
                labelText: 'Contraseña',
                isPassword: true, 
                keyboardType: TextInputType.text,
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800], 
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Iniciar Sesión', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.go('/register'),
                child: Text('¿No tienes cuenta? Regístrate aquí',style: TextStyle(color: Colors.blue[800])
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
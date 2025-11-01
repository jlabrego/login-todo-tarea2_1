import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/shared/utils.dart';
import 'package:todo_app/src/widgets/custom_textfield.dart';
import 'package:todo_app/api/todos.dart'; 

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // --- Funciones de Validación ---

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    // 1. Validar que no esté vacío
    if (_validateRequired(value) != null) return 'El correo es obligatorio.';
    
    // 2. Validar el dominio @unah.hn
    if (!value!.endsWith('@unah.hn')) {
      return 'El correo debe ser @unah.hn';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    // 1. Validar que no esté vacío
    if (_validateRequired(value) != null) return 'La contraseña es obligatoria.';
    
    // 2. Validar longitud 
    if (value!.length < 6) {
      return 'Debe tener al menos 6 caracteres.';
    }
    
    // 3. Validar caracter especial
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Debe tener un caracter especial.';
    }
    return null;
  }
  
  void _register() {
    // Validar todos los campos del formulario
    if (_formKey.currentState!.validate()) {
      
      // 1. Guardar el nuevo usuario en la lista 'logins'
      logins.add({
        'user': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
      });
      
      // 2. Mostrar mensaje de exito con tu Util
      Utils.showSnackBar(
        context: context, 
        title: '¡Registro Exitoso! Ya puedes iniciar sesión.',
        color: Colors.green,
      );
      
      // 3. Navegar de vuelta al Login
      context.go('/login');
    } else {
      // Mostrar error general si la validacion falla
      Utils.showSnackBar(
        context: context, 
        title: 'Por favor, corrige los errores en el formulario.',
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Crea tu Cuenta', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              
              CustomTextField(
                controller: _nameController,
                labelText: 'Nombre Completo',
                validator: _validateRequired,
              ),
              const SizedBox(height: 16),
              
              CustomTextField(
                controller: _emailController,
                labelText: 'Correo Institucional',
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              
              CustomTextField(
                controller: _phoneController,
                labelText: 'Teléfono',
                keyboardType: TextInputType.phone,
                validator: _validateRequired,
              ),
              const SizedBox(height: 16),
              
              CustomTextField(
                controller: _passwordController,
                labelText: 'Contraseña',
                isPassword: true, 
                validator: _validatePassword,
              ),
              const SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800], 
                  padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Registrarme', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),

              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go('/login'),
                child: Text('¿Ya tienes cuenta? Inicia Sesión',style: TextStyle(color: Colors.blue[800])
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
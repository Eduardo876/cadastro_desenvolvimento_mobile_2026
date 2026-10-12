
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CadastroApp());
}

class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Usuário',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  bool _mostrarSenha = false;
  bool _mostrarConfirmacao = false;

  bool _emailValido(String email) {
    final regex = RegExp(
      r'^[\w.!#$%&''*+/=?^`{|}~-]+@'
      r'[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?'
      r'(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+$',
    );

    return regex.hasMatch(email);
  }

  void _cadastrar() {
    FocusScope.of(context).unfocus();

    final formularioValido =
    _formKey.currentState!.validate();

    if (formularioValido) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Cadastro realizado com sucesso!',
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );

    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Verifique os campos destacados e tente novamente.',
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    cpfController.dispose();
    telefoneController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_add_alt_1,
                size: 64,
                color: Colors.indigo,
              ),

              const SizedBox(height: 12),

              const Text(
                'Crie sua conta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Preencha os campos abaixo para se cadastrar.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 28),

              TextFormField(
                controller: nomeController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  hintText: 'Digite seu nome',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe seu nome completo.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'exemplo@email.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe seu e-mail.';
                  }

                  if (!_emailValido(value.trim())) {
                    return 'Digite um e-mail válido.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: cpfController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: 'Digite os 11 números do CPF',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu CPF.';
                  }

                  if (value.length != 11) {
                    return 'O CPF deve conter 11 dígitos.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: telefoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: 'DDD + número',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu telefone.';
                  }

                  if (value.length < 10) {
                    return 'Digite um telefone com DDD válido.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: senhaController,
                obscureText: !_mostrarSenha,
                textInputAction: TextInputAction.next,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Mínimo de 6 caracteres',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _mostrarSenha
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    tooltip: _mostrarSenha
                        ? 'Ocultar senha'
                        : 'Mostrar senha',
                    onPressed: () {
                      setState(() {
                        _mostrarSenha = !_mostrarSenha;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua senha.';
                  }

                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: confirmarSenhaController,
                obscureText: !_mostrarConfirmacao,
                textInputAction: TextInputAction.done,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  hintText: 'Digite a senha novamente',
                  prefixIcon: const Icon(Icons.lock_reset),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _mostrarConfirmacao
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    tooltip: _mostrarConfirmacao
                        ? 'Ocultar senha'
                        : 'Mostrar senha',
                    onPressed: () {
                      setState(() {
                        _mostrarConfirmacao = !_mostrarConfirmacao;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirme sua senha.';
                  }

                  if (value != senhaController.text) {
                    return 'As senhas não são iguais.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 28),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'CADASTRAR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
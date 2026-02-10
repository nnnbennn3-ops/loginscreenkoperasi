// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
//import 'home_screen.dart';
import 'register_screen.dart';
import 'main_shell.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int tab = 0; // 0 Masuk, 1 Daftar
  final email = TextEditingController();
  final password = TextEditingController();
  bool remember = false;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00006F),
      body: Column(
        children: [
          _header(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tabs(),
                    const SizedBox(height: 16),
                    _welcome(),
                    const SizedBox(height: 20),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainShell(),
                            ),
                          );
                        }

                        if (state is LoginError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            _form(),
                            const SizedBox(height: 16),
                            _options(),
                            const SizedBox(height: 24),
                            state is LoginLoading
                                ? const CircularProgressIndicator()
                                : _loginButton(context),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== HEADER ===== Bagian Biru Atas yang isinya logo dan nama koperasi
  Widget _header() {
    return Container(
      padding: EdgeInsets.only(top: 60, bottom: 80),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color((0xFF00006F)), Color((0xFF00006F))],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            //Logonya ditaruh disini
            radius: 65,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/logo_koperasi.jpeg'),
          ),
          SizedBox(height: 8),
          Text(
            //Tulisan Koperasi Karyawan
            'Koperasi Karyawan',
            style: GoogleFonts.beVietnamPro(
              //kalau tulisannya masih gatel kurang mirip editnya disini
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),

          Text(
            //Tulisan Indomobil di bawah koperasi karyawan
            'Indomobil MT Haryono',
            style: GoogleFonts.beVietnamPro(
              //kalau tulisannya masih gatel kurang mirip editnya disini
              color: Colors.white70,
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===== TABS ===== Ini tombol masuk dan daftar yang di bawah background biru
  Widget _tabs() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [_tabBtn('Masuk', 0), _tabBtn('Daftar', 1)],
        ),
      ),
    );
  }

  Widget _tabBtn(String t, int i) {
    final active = tab == i;

    return InkWell(
      onTap: () {
        if (i == 1) {
          // MENUJU TAB DAFTAR
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RegisterScreen()),
          );
        }
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          boxShadow:
              active ? [BoxShadow(color: Colors.black12, blurRadius: 6)] : null,
        ),
        child: Text(
          t,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: active ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  // ===== WELCOME ===== Bagian yang ngatur tulisan Hi selamat datang dan silakan masukkan data dst.
  Widget _welcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, Selamat Datang!',
          style: GoogleFonts.manrope(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ), //kalau tulisannya masih gatel kurang mirip editnya disini
        ),
        SizedBox(height: 2),
        Text(
          'Silakan masukkan data untuk melanjutkan penggunaan aplikasi.',
          style: GoogleFonts.manrope(
            //kalau tulisannya masih gatel kurang mirip editnya disini
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // ===== FORM ===== Bubble - bubble buat mengisi email sama password
  Widget _form() {
    return Column(
      children: [
        TextField(
          controller: email,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ), //edit tulisan
          decoration: InputDecoration(
            // ini yang mengatur bagian email
            labelText: 'Nomor Anggota atau Email',
            floatingLabelBehavior:
                FloatingLabelBehavior
                    .always, //bagian yang ngatur tulisan nomor anggota atau email tetep di atas
            hintText: 'Example@gmail.com',
            hintStyle: GoogleFonts.roboto(
              //sama edit tulisan juga
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
            prefixIcon: const Icon(
              Icons.person_outline,
            ), //icon orang, belom nemu yang persis kayak desain figma

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF0B1E8A), width: 2),
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
          ),
        ),

        const SizedBox(height: 14),
        TextField(
          // ini yang mengatur bagian passwordnya
          controller: password,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ), //edit tulisan passwordnya
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: 'Password',
            floatingLabelBehavior:
                FloatingLabelBehavior
                    .always, //sama kayak email, biar tulisan passwordnya tetep di atas
            hintText: '**********',
            prefixIcon: const Icon(Icons.key),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => obscure = !obscure),
            ),

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF0B1E8A), width: 2),
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _input(String label, IconData icon, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      hintText: label.contains('Email') ? 'Example@gmail.com' : '********',
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF0B1E8A), width: 2),
      ),
    );
  }

  // ===== OPTIONS ===== // yang ngatur remember me sama forgor password
  Widget _options() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              // dari sini sampe remember me ngatur sifat checkboxnya
              value: remember,
              onChanged: (v) => setState(() => remember = v ?? false),
              checkColor: Colors.black,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                return const Color.fromARGB(255, 255, 255, 255);
              }),

              side: const BorderSide(color: Colors.black, width: 2),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(
              'Remember Me',
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            //tulisan forgot password
            'Forgot Password',
            style: GoogleFonts.manrope(
              color: Colors.red.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ===== LOGIN ===== Tombol Login
  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color((0xFF00006F)),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          context.read<LoginCubit>().login(email.text, password.text);
        },
        child: Text(
          'Login',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // Future<void> _login() async {
  //   if (email.text.isEmpty || password.text.isEmpty) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Harap isi semua field')));
  //     return;
  //   }

  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (_) => const Center(child: CircularProgressIndicator()),
  //   );

  //   try {
  //     final user = await LoginService.login(email.text, password.text);

  //     Navigator.pop(context); //close loadingnya

  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const MainShell()),
  //     );
  //   } catch (e) {
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }
}

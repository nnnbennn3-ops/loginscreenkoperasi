import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final anggota = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool obscure1 = true;
  bool obscure2 = true;

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
                    const SizedBox(height: 20),
                    _title(),
                    const SizedBox(height: 20),
                    _form(),
                    const SizedBox(height: 24),
                    _registerButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 80),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00006F), Color(0xFF00006F)],
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
            'Koperasi Karyawan',
            style: GoogleFonts.beVietnamPro(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Indomobil MT Haryono',
            style: GoogleFonts.beVietnamPro(
              color: Colors.white70,
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ================= TABS =================
  Widget _tabs() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [_tabBtn('Masuk', false), _tabBtn('Daftar', true)],
        ),
      ),
    );
  }

  Widget _tabBtn(String text, bool active) {
    return InkWell(
      onTap: () {
        if (!active) {
          Navigator.pop(context); // balik ke Login
        }
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          boxShadow:
              active
                  ? [const BoxShadow(color: Colors.black12, blurRadius: 6)]
                  : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: active ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  // ================= TITLE =================
  Widget _title() {
    return Text(
      'Daftar Sekarang',
      style: GoogleFonts.manrope(fontSize: 25, fontWeight: FontWeight.w700),
    );
  }

  // ================= FORM =================
  Widget _form() {
    return Column(
      children: [
        _input(
          controller: anggota,
          label: 'Nomor Anggota',
          icon: Icons.person_outline,
          hint: 'Masukkan nomor anggota',
        ),
        _input(
          controller: email,
          label: 'Email',
          icon: Icons.email_outlined,
          hint: 'Input Email',
        ),
        _input(
          controller: phone,
          label: 'Nomor Ponsel',
          icon: Icons.phone_outlined,
          hint: '+62 xxxxxxxxxx',
        ),
        _input(
          controller: password,
          label: 'Password',
          icon: Icons.key,
          hint: 'Input Password',
          obscure: obscure1,
          suffix: IconButton(
            icon: Icon(obscure1 ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => obscure1 = !obscure1),
          ),
        ),
        _input(
          controller: confirmPassword,
          label: 'Confirm Password',
          icon: Icons.key,
          hint: 'Input Password',
          obscure: obscure2,
          suffix: IconButton(
            icon: Icon(obscure2 ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => obscure2 = !obscure2),
          ),
        ),
      ],
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          hintStyle: GoogleFonts.roboto(color: Colors.grey.shade500),
          prefixIcon: Icon(icon),
          suffixIcon: suffix,
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
    );
  }

  // ================= REGISTER BUTTON =================
  Widget _registerButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00006F),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: _register,
        child: Text(
          'Register',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  void _register() {
    if (anggota.text.isEmpty ||
        email.text.isEmpty ||
        phone.text.isEmpty ||
        password.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Harap isi semua field')));
      return;
    }

    if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Password tidak sama')));
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Registrasi berhasil')));

    Navigator.pop(context); // balik ke login
  }
}

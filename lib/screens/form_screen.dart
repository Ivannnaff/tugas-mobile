import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/validators.dart';
import '../models/registration_data.dart';
import '../widgets/section_card.dart';
import 'result_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _namaC = TextEditingController();
  final _nimC = TextEditingController();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();

  bool _obscure = true;
  String? _gender;
  final Set<String> _hobi = {};
  String? _prodi;
  bool _agree = false;

  final List<String> _prodiOptions = [
    'Pendidikan TI',
    'Bisnis Digital',
    'PGSD',
  ];

  final List<String> _hobiOptions = [
    'Membaca',
    'Olahraga',
    'Musik',
    'Fotografi',
  ];

  @override
  void dispose() {
    _namaC.dispose();
    _nimC.dispose();
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  void _submit() {
    final valid = _formKey.currentState!.validate();
    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali data yang belum sesuai')),
      );
      return;
    }

    final data = RegistrationData(
      nama: _namaC.text.trim(),
      nim: _nimC.text.trim(),
      email: _emailC.text.trim(),
      password: _passC.text,
      jenisKelamin: _gender!,
      hobi: _hobi.toList(),
      programStudi: _prodi!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultScreen(data: data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Gradien
            _buildHeader(),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Section Data Diri
                    SectionCard(
                      title: 'DATA DIRI',
                      children: [
                        _buildTextField(
                          controller: _namaC,
                          label: 'Nama Lengkap',
                          hint: 'Masukkan nama lengkap',
                          icon: Icons.person_outline,
                          validator: Validators.nama,
                          capitalization: TextCapitalization.words,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _nimC,
                          label: 'NIM',
                          hint: 'Minimal 8 digit angka',
                          icon: Icons.badge_outlined,
                          validator: Validators.nim,
                          keyboard: TextInputType.number,
                          formatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _emailC,
                          label: 'Email',
                          hint: 'nama@email.com',
                          icon: Icons.email_outlined,
                          validator: Validators.email,
                          keyboard: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        _buildPasswordField(),
                      ],
                    ),

                    // Section Pilihan
                    SectionCard(
                      title: 'PILIHAN',
                      children: [
                        _buildGenderField(),
                        const SizedBox(height: 24),
                        _buildHobbyField(),
                        const SizedBox(height: 24),
                        _buildProdiField(),
                      ],
                    ),

                    // Syarat & Ketentuan
                    _buildTermsField(),

                    const SizedBox(height: 24),

                    // Tombol Simpan
                    ElevatedButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                      label: const Text(
                        'SIMPAN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C3CE1),
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 2,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 40, left: 24, right: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C3CE1), Color(0xFF4B22B0)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment_outlined, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Text(
                'Pendaftaran Kegiatan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Lengkapi data di bawah ini',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboard = TextInputType.text,
    List<TextInputFormatter>? formatters,
    TextCapitalization capitalization = TextCapitalization.none,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      keyboardType: keyboard,
      textInputAction: TextInputAction.next,
      inputFormatters: formatters,
      textCapitalization: capitalization,
      validator: validator,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passC,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Minimal 8 karakter',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => _obscure = !_obscure),
          tooltip: 'Tampilkan/Sembunyikan password',
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      obscureText: _obscure,
      textInputAction: TextInputAction.done,
      validator: Validators.password,
    );
  }

  Widget _buildGenderField() {
    return FormField<String>(
      initialValue: _gender,
      validator: (v) => Validators.required(v, 'Pilih jenis kelamin'),
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jenis Kelamin',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text(
                    'Laki-laki',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: 'Laki-laki',
                  groupValue: _gender,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (v) {
                    setState(() => _gender = v);
                    state.didChange(v);
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text(
                    'Perempuan',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: 'Perempuan',
                  groupValue: _gender,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (v) {
                    setState(() => _gender = v);
                    state.didChange(v);
                  },
                ),
              ),
            ],
          ),
          if (state.hasError)
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                state.errorText!,
                style: const TextStyle(color: Color(0xFFE5384F), fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHobbyField() {
    return FormField<Set<String>>(
      initialValue: _hobi,
      validator: (v) =>
          (v == null || v.isEmpty) ? 'Pilih minimal satu hobi' : null,
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hobi',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Text(
            'boleh lebih dari satu',
            style: TextStyle(fontSize: 12, color: Color(0xFF6B6590)),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 0,
            runSpacing: 0,
            children: _hobiOptions.map((hobi) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: CheckboxListTile(
                  title: Text(hobi, style: const TextStyle(fontSize: 14)),
                  value: _hobi.contains(hobi),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (v) {
                    setState(() {
                      if (v == true) {
                        _hobi.add(hobi);
                      } else {
                        _hobi.remove(hobi);
                      }
                    });
                    state.didChange(_hobi);
                  },
                ),
              );
            }).toList(),
          ),
          if (state.hasError)
            Text(
              state.errorText!,
              style: const TextStyle(color: Color(0xFFE5384F), fontSize: 12),
            ),
        ],
      ),
    );
  }

  Widget _buildProdiField() {
    return DropdownButtonFormField<String>(
      initialValue: _prodi,
      decoration: InputDecoration(
        labelText: 'Program Studi',
        prefixIcon: const Icon(Icons.school_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      hint: const Text('Pilih program studi'),
      items: _prodiOptions.map((prodi) {
        return DropdownMenuItem(value: prodi, child: Text(prodi));
      }).toList(),
      onChanged: (v) => setState(() => _prodi = v),
      validator: (v) => Validators.required(v, 'Pilih program studi'),
    );
  }

  Widget _buildTermsField() {
    return FormField<bool>(
      initialValue: _agree,
      validator: (v) =>
          v != true ? 'Anda harus menyetujui syarat dan ketentuan' : null,
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckboxListTile(
            title: const Text(
              'Saya menyetujui syarat dan ketentuan',
              style: TextStyle(fontSize: 14),
            ),
            value: _agree,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            onChanged: (v) {
              setState(() => _agree = v ?? false);
              state.didChange(v);
            },
          ),
          if (state.hasError)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                state.errorText!,
                style: const TextStyle(color: Color(0xFFE5384F), fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

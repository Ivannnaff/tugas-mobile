class Validators {
  static String? nama(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Nama lengkap wajib diisi' : null;

  static String? nim(String? v) {
    if (v == null || v.trim().isEmpty) return 'NIM wajib diisi';
    if (!RegExp(r'^\d+$').hasMatch(v.trim()))
      return 'NIM hanya boleh berisi angka';
    if (v.trim().length < 8) return 'NIM minimal 8 digit';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Format email tidak valid';
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password wajib diisi';
    if (v.length < 8) return 'Password minimal 8 karakter';
    return null;
  }

  static String? required(String? v, String message) =>
      (v == null || v.isEmpty) ? message : null;
}

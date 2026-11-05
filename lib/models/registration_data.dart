class RegistrationData {
  final String nama;
  final String nim;
  final String email;
  final String password;
  final String jenisKelamin;
  final List<String> hobi;
  final String programStudi;

  const RegistrationData({
    required this.nama,
    required this.nim,
    required this.email,
    required this.password,
    required this.jenisKelamin,
    required this.hobi,
    required this.programStudi,
  });
}

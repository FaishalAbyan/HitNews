import 'package:equatable/equatable.dart';

// UserEntity adalah representasi pengguna di lapisan Domain.
// Ini adalah objek murni yang tidak bergantung pada detail implementasi database atau API.
class UserEntity extends Equatable {
  final String uid; // ID unik pengguna
  final String? email; // Alamat email pengguna
  final String? displayName; // Nama tampilan pengguna (opsional)
  final String? photoUrl; // URL foto profil pengguna (opsional)
  final bool emailVerified; // Status verifikasi email

  const UserEntity({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.emailVerified = false, // Default false jika tidak ditentukan
  });

  // Metode props dari Equatable digunakan untuk membandingkan dua objek UserEntity.
  // Dua objek dianggap sama jika semua properti dalam daftar ini sama.
  @override
  List<Object?> get props => [uid, email, displayName, photoUrl, emailVerified];
}

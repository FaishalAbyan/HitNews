import 'package:supabase_flutter/supabase_flutter.dart'; // Import User dari Supabase
import 'package:tekmob_hitnews/domain/entities/user_entity.dart'; // Import UserEntity

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    super.email,
    super.displayName,
    super.photoUrl,
    super.emailVerified,
  });

  // Factory constructor untuk membuat UserModel dari objek User Supabase
  factory UserModel.fromSupabaseUser(User user) {
    return UserModel(
      uid: user.id,
      email: user.email,
      displayName:
          user.userMetadata?['full_name']
              as String?, // Ambil dari user_metadata jika ada
      photoUrl:
          user.userMetadata?['avatar_url']
              as String?, // Ambil dari user_metadata jika ada
      emailVerified: user.emailConfirmedAt != null,
    );
  }

  // Factory constructor untuk membuat UserModel dari data Firestore/Database (jika diperlukan)
  // Ini akan berguna saat kita menyimpan data profil tambahan di tabel 'profiles'
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['id'] as String,
      email: map['email'] as String?,
      displayName: map['full_name'] as String?,
      photoUrl: map['avatar_url'] as String?,
      emailVerified: map['email_verified'] as bool? ?? false,
    );
  }

  // Metode untuk mengkonversi UserModel ke Map (untuk disimpan ke database)
  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'email': email,
      'full_name': displayName,
      'avatar_url': photoUrl,
      'email_verified': emailVerified,
    };
  }

  // Metode untuk mengkonversi dari model ke entity
  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      emailVerified: emailVerified,
    );
  }
}

class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String role;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory ProfileModel.fromResponseBody(Map<String, dynamic> json) =>
      ProfileModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
      );
}

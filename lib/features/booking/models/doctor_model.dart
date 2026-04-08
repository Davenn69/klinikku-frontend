class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final String regionId;
  final String licenseNumber;
  final bool isActive;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.regionId,
    required this.licenseNumber,
    required this.isActive,
  });

  factory DoctorModel.fromResponseBody(Map<String, dynamic> json) =>
      DoctorModel(
        id: json['id'],
        name: json['name'],
        specialization: json['specialization'],
        regionId: json['regionId'],
        licenseNumber: json['licenseNumber'],
        isActive: json['isActive'],
      );
}

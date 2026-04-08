class RegionModel {
  final String id;
  final String name;
  final String code;
  final bool isActive;

  const RegionModel({
    required this.id,
    required this.name,
    required this.code,
    required this.isActive,
  });

  factory RegionModel.fromResponseBody(Map<String, dynamic> json) =>
      RegionModel(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        isActive: json['isActive'],
      );
}

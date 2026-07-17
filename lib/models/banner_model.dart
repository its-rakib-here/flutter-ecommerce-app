class BannerModel {
  final String title;
  final String buttonText;
  final String img_url;
  final String targetCategory;
  final int order;
  final bool isActive;

  BannerModel({
    required this.title,
    required this.buttonText,
    required this.img_url,
    required this.targetCategory,
    required this.order,
    required this.isActive,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      title: json["title"] ?? "",
      buttonText: json["buttonText"] ?? "",
      img_url: json["img_url"] ?? "",
      targetCategory: json["targetCategory"] ?? "",
      order: json["order"] ?? 0,
      isActive: json["isActive"] ?? false,
    );
  }
}

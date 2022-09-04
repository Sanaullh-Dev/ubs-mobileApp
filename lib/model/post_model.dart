class PostModel {
  late int id;
  late String image1;
  late String image2;
  late String image3;
  late double amount;
  late String name;
  late String subtitle;
  late String location;
  late String features;
  late String favorite;

  PostModel({
    required this.id,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.amount,
    required this.name,
    required this.subtitle,
    required this.location,
    required this.features,
    required this.favorite,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    amount = double.parse(json['amount']);
    name = json['name'];
    subtitle = json['subtitle'];
    location = json['location'];
    features = json['features'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['image1'] = image1;
    data['image2'] = image2;
    data['image3'] = image3;
    data['amount'] = amount;
    data['name'] = name;
    data['subtitle'] = subtitle;
    data['location'] = location;
    data['features'] = features;
    data['favorite'] = favorite;
    return data;
  }

  void add(PostModel postModel) {}
}

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductModel {
   final int? id;
   final String name;
   final String description;
   final double price;
   final bool enabled;
   final String image;
  
  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.enabled,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'enabled': enabled,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: (map['name'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      price: (map['price'] ?? 0.0) as double,
      enabled: (map['enabled'] ?? 0.0) as bool,
      image: (map['image'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

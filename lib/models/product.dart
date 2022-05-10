import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? title;
  String? type;
  String? description;
  String? filename;
  int? height;
  int? width;
  double? price;
  int? rating;
  DocumentReference? reference;
  DateTime? created;

  ProductModel({
    this.title,
    this.type,
    this.description,
    this.filename,
    this.height,
    this.width,
    this.price,
    this.rating,
    this.reference,
    this.created,
  });

  ProductModel copyWith({
    String? title,
    String? type,
    String? description,
    String? filename,
    int? height,
    int? width,
    double? price,
    int? rating,
    DocumentReference? reference,
    DateTime? created,
  }) {
    return ProductModel(
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      filename: filename ?? this.filename,
      height: height ?? this.height,
      width: width ?? this.width,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reference: reference ?? this.reference,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'description': description,
      'filename': filename,
      'height': height,
      'width': width,
      'price': price,
      'rating': rating,
      'created': Timestamp.fromDate(created!),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'],
      type: map['type'],
      description: map['description'],
      filename: map['filename'],
      height: map['height']?.toInt(),
      width: map['width']?.toInt(),
      price: map['price']?.toDouble(),
      rating: map['rating']?.toInt(),
      created: map['created'] ?? DateTime.now(),
    );
  }

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    return ProductModel(
      title: (doc.data() as dynamic)['title'].toString(),
      type: (doc.data() as dynamic)['type'].toString(),
      description: (doc.data() as dynamic)['description'].toString(),
      filename: (doc.data() as dynamic)['filename'].toString(),
      height: (doc.data() as dynamic)['height']?.toInt(),
      width: (doc.data() as dynamic)['width']?.toInt(),
      price: (doc.data() as dynamic)['price']?.toDouble(),
      rating: (doc.data() as dynamic)['rating']?.toInt(),
      reference: doc.reference,
      created: ((doc.data() as dynamic)['created'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'title: $title, type: $type, description: $description, filename: $filename, height: $height, width: $width, price: $price, rating: $rating, reference: $reference, created: $created';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.title == title &&
        other.type == type &&
        other.description == description &&
        other.filename == filename &&
        other.height == height &&
        other.width == width &&
        other.price == price &&
        other.rating == rating &&
        other.reference == reference &&
        other.created == created;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        type.hashCode ^
        description.hashCode ^
        filename.hashCode ^
        height.hashCode ^
        width.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        reference.hashCode ^
        created.hashCode;
  }
}

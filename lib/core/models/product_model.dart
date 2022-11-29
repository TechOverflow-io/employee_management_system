import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final int price;
  final String url;
  final String img;

  Product(
      {required this.name,
      required this.id,
      required this.price,
      required this.url,
      required this.img});

  factory Product.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Product(
      id: snapshot['id'],
      name: snapshot['name'],
      price: snapshot['price'],
      url: snapshot['url'],
      img: snapshot['img'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "url": url,
        "img": img,
      };
}

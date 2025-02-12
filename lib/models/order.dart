import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  String? id;
  DateTime? createdAt;
  String? description;
  String? customerName;
  bool? finished;

  Order({
    this.id,
    this.createdAt,
    this.description,
    this.customerName,
    this.finished,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        description: json["description"],
        customerName: json["customerName"],
        finished: json["finished"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        // "createdAt": createdAt.toIso8601String(),
        "description": description,
        "customerName": customerName,
        // "finished": finished,
      };
}

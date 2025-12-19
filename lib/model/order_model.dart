class OrderModel {
  final String id;
  final String date;
  final String time;
  final String status;

  OrderModel({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }
}
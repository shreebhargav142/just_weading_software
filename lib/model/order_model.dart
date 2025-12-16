class OrderModel {
  final String id;
  final String date;
  final String time;
  final String status; // 'Delivered', 'In Process', 'Canceled'

  OrderModel({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
  });

  // Factory constructor to easily map JSON data from API later
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }
}
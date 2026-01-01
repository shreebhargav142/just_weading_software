class FeedbackRequest {
  int? rating;
  String? personName;
  int? mobileNo;
  String? cityName;
  String? instagramId;
  String? dateOfBirth;
  String? anniversaryDate;
  String? description;
  int? clientId;
  int? eventId;

  FeedbackRequest({
    this.rating,
    this.personName,
    this.mobileNo,
    this.cityName,
    this.instagramId,
    this.dateOfBirth,
    this.anniversaryDate,
    this.description,
    this.clientId,
    this.eventId,
  });

  Map<String, dynamic> toJson() {
    return {
      "rating": rating,
      "personName": personName,
      "mobileNo": mobileNo,
      "cityName": cityName,
      "instagramId": instagramId,
      "dateOfBirth": dateOfBirth,
      "anniversaryDate": anniversaryDate,
      "description": description,
      "clientId": clientId,
      "eventId": eventId,
    };
  }
}
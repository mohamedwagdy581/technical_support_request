class RequestModel {
  String? uId;
  String? city;
  String? companyName;
  String? technicalName;
  String? school;
  String? technicalPhone;
  String? customerPhone;
  String? machineImage;
  String? machineTypeImage;
  String? damageImage;
  String? consultation;
  double? latitude;
  double? longitude;

  RequestModel({
    this.uId = '',
    required this.city,
    required this.companyName,
    required this.technicalName,
    required this.school,
    required this.technicalPhone,
    required this.customerPhone,
    required this.machineImage,
    required this.machineTypeImage,
    required this.damageImage,
    required this.consultation,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() =>
  {
    'uId' : uId,
    'city' : city,
    'companyName' : companyName,
    'technicalName' : technicalName,
    'school' : school,
    'technicalPhone' : technicalPhone,
    'customerPhone' : customerPhone,
    'machineImage' : machineImage,
    'machineTypeImage' : machineTypeImage,
    'damageImage' : damageImage,
    'consultation' : consultation,
    'latitude' : latitude,
    'longitude' : longitude,
    'dateTime' : DateTime.now(),
  };

  RequestModel.fromJson(Map<String, dynamic> json)
  {
    uId = json['uId'];
    city = json['city'];
    companyName = json['companyName'];
    technicalName = json['technicalName'];
    school = json['school'];
    technicalPhone = json['technicalPhone'];
    customerPhone = json['customerPhone'];
    machineImage = json['machineImage'];
    machineTypeImage = json['machineTypeImage'];
    damageImage = json['damageImage'];
    consultation = json['consultation'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}

import 'package:expunivers/src/feature/models/photos_model.dart';

class MarsModel {
  List<Photos>? photos;

  MarsModel({this.photos});

  MarsModel.fromJson(Map<String, dynamic> json) {
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

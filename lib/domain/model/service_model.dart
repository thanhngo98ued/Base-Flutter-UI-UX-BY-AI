class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.category,
    this.image,
  });

  final String id;
  final String name;
  final String icon;
  final String category;
  final String? image;
}

class BannerModel {
  const BannerModel({
    required this.id,
    required this.title,
    required this.image,
  });

  final String id;
  final String title;
  final String image;
}

class LocationModel {
  const LocationModel({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;
}

class WorkerModel {
  const WorkerModel({
    required this.id,
    required this.name,
    required this.phone,
    this.avatar,
    this.address,
    required this.rating,
    required this.jobsCompleted,
    required this.skills,
    required this.hourlyRate,
    required this.isOnline,
    this.distance,
    this.location,
  });

  final String id;
  final String name;
  final String phone;
  final String? avatar;
  final String? address;
  final double rating;
  final int jobsCompleted;
  final List<String> skills;
  final int hourlyRate;
  final bool isOnline;
  final double? distance;
  final LocationModel? location;
}



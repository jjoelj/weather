class Location {
  final String title;
  final String locationType;
  final int woeid;

  Location({
    required this.title,
    required this.locationType,
    required this.woeid,
  });

  factory Location.fromMap(Map<String, dynamic> map) => Location(
        title: map["title"] as String,
        locationType: map["location_type"] as String,
        woeid: map["woeid"] as int,
      );
}

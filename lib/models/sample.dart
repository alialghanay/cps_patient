class Sample {
  final int id;
  final int sampleSource;
  final String sampleDate;
  final String sampleType;
  final String specimen;
  final dynamic image;

  Sample({
    required this.id,
    required this.sampleSource,
    required this.sampleDate,
    required this.sampleType,
    required this.specimen,
    this.image,
  });

  factory Sample.fromJson(Map<String, dynamic> json) {
    return Sample(
      id: json['id'] ?? 0,
      sampleSource: json['sampleSource'] ?? 0,
      sampleDate: json['sampleDate'] ?? '',
      sampleType: json['sampleType'] ?? '',
      specimen: json['specimen'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sampleSource': sampleSource,
      'sampleDate': sampleDate,
      'sampleType': sampleType,
      'specimen': specimen,
      'image': image,
    };
  }
}

class Recipe {
  String? name;
  String? images;
  double? rating;
  String? totalTime;
  String? url;

  Recipe.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    images = json['images'][0]['hostedLargeUrl'];
    rating = json['rating'];
    totalTime = json['totalTime'];
    url = json['directionsUrl'];
  }
}

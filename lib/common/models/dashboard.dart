import 'package:shortener_app/common/models/url.dart';

class Dashboard {
  final int totalHits;
  final int numberOfUrls;
  final List<Url> recentUrls;

  Dashboard({this.totalHits, this.numberOfUrls, this.recentUrls});

  Dashboard.fromJson(Map<String, dynamic> json)
      : totalHits = json["total_hits"],
        numberOfUrls = json["number_of_urls"],
        recentUrls = Url.fromJsonArray(json["recent_urls"]);
}

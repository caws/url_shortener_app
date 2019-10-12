import 'package:shortener_app/common/models/url.dart';

class Dashboard {
  final int totalHits;
  final List<Url> recentUrls;

  Dashboard({this.totalHits, this.recentUrls});

  Dashboard.fromJson(Map<String, dynamic> json)
      : totalHits = json["total_hits"],
        recentUrls = Url.fromJsonArray(json["recent_urls"]);
}

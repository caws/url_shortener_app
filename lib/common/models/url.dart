class Url {
  final int id;
  final String shortUrl;
  final String fullUrl;
  final String pageTitle;
  final int hitCounter;
  final String status;
  final String createdAt;

  Url(
      {this.id,
      this.shortUrl,
      this.fullUrl,
      this.pageTitle,
      this.hitCounter,
      this.status,
      this.createdAt});
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo(
      {this.albumId = 0,
      this.id = 0,
      this.title = "",
      this.url = "",
      this.thumbnailUrl = ""});
}

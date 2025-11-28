class MovieSuggestionsResponse {
  final String? status;
  final String? statusMessage;
  final MetaData? meta;
  final MovieData? data;

  MovieSuggestionsResponse({
    this.status,
    this.statusMessage,
    this.meta,
    this.data,
  });

  factory MovieSuggestionsResponse.fromJson(Map<String, dynamic> json) {
    return MovieSuggestionsResponse(
      status: json['status'],
      statusMessage: json['status_message'],
      meta: json['@meta'] != null ? MetaData.fromJson(json['@meta']) : null,
      data: json['data'] != null ? MovieData.fromJson(json['data']) : null,
    );
  }
}

class MetaData {
  final int? serverTime;
  final String? serverTimezone;
  final int? apiVersion;
  final String? executionTime;

  MetaData({
    this.serverTime,
    this.serverTimezone,
    this.apiVersion,
    this.executionTime,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      serverTime: json['server_time'],
      serverTimezone: json['server_timezone'],
      apiVersion: json['api_version'],
      executionTime: json['execution_time'],
    );
  }
}
class MovieData {
  final int? movieCount;
  final List<Movie>? movies;

  MovieData({this.movieCount, this.movies});

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      movieCount: json['movie_count'],
      movies: json['movies'] != null
          ? List<Movie>.from(json['movies'].map((x) => Movie.fromJson(x)))
          : [],
    );
  }
}
class Movie {
  final int? id;
  final String? url;
  final String? imdbCode;
  final String? title;
  final String? titleEnglish;
  final String? titleLong;
  final String? slug;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;

  final String? summary;
  final String? descriptionFull;
  final String? synopsis;
  final String? ytTrailerCode;

  final String? language;
  final String? mpaRating;
  final String? backgroundImage;
  final String? backgroundImageOriginal;
  final String? smallCoverImage;
  final String? mediumCoverImage;
  final String? state;

  final List<Torrent>? torrents;
  final String? dateUploaded;
  final int? dateUploadedUnix;

  Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      url: json['url'],
      imdbCode: json['imdb_code'],
      title: json['title'],
      titleEnglish: json['title_english'],
      titleLong: json['title_long'],
      slug: json['slug'],
      year: json['year'],
      rating: (json['rating'] as num?)?.toDouble(),
      runtime: json['runtime'],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      summary: json['summary'],
      descriptionFull: json['description_full'],
      synopsis: json['synopsis'],
      ytTrailerCode: json['yt_trailer_code'],
      language: json['language'],
      mpaRating: json['mpa_rating'],
      backgroundImage: json['background_image'],
      backgroundImageOriginal: json['background_image_original'],
      smallCoverImage: json['small_cover_image'],
      mediumCoverImage: json['medium_cover_image'],
      state: json['state'],
      torrents: json['torrents'] != null
          ? List<Torrent>.from(json['torrents'].map((x) => Torrent.fromJson(x)))
          : [],
      dateUploaded: json['date_uploaded'],
      dateUploadedUnix: json['date_uploaded_unix'],
    );
  }
}
class Torrent {
  final String? url;
  final String? hash;
  final String? quality;
  final String? isRepack;
  final String? videoCodec;
  final String? bitDepth;
  final String? audioChannels;
  final int? seeds;
  final int? peers;
  final String? size;
  final int? sizeBytes;
  final String? dateUploaded;
  final int? dateUploadedUnix;

  Torrent({
    this.url,
    this.hash,
    this.quality,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) {
    return Torrent(
      url: json['url'],
      hash: json['hash'],
      quality: json['quality'],
      isRepack: json['is_repack'],
      videoCodec: json['video_codec'],
      bitDepth: json['bit_depth'],
      audioChannels: json['audio_channels'],
      seeds: json['seeds'],
      peers: json['peers'],
      size: json['size'],
      sizeBytes: json['size_bytes'],
      dateUploaded: json['date_uploaded'],
      dateUploadedUnix: json['date_uploaded_unix'],
    );
  }
}

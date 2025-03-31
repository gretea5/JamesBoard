import 'package:json_annotation/json_annotation.dart';

part 'ArchiveDetailResponse.g.dart';

@JsonSerializable()
class ArchiveDetailResponse {
  final int archiveId;
  final String userNickName;
  final String userProfile;
  final String archiveContent;
  final String gameTitle;
  final int archiveGamePlayTime;
  final List<String> archiveImageList;

  ArchiveDetailResponse({
    required this.archiveId,
    required this.userNickName,
    required this.userProfile,
    required this.archiveContent,
    required this.gameTitle,
    required this.archiveGamePlayTime,
    required this.archiveImageList,
  });

  factory ArchiveDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ArchiveDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArchiveDetailResponseToJson(this);
}

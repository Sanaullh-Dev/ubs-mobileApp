// To parse this JSON data, do
//
//     final postReaction = postReactionFromJson(jsonString);

import 'dart:convert';

PostReaction postReactionFromJson(String str) =>
    PostReaction.fromJson(json.decode(str));

String postReactionToJson(PostReaction data) => json.encode(data.toJson());

class PostReaction {
  PostReaction({
    required this.uid,
    required this.pid,
    required this.pFavorite,
    required this.pView,
  });

  String uid;
  int pid;
  int pFavorite;
  int pView;

  factory PostReaction.fromJson(Map<String, dynamic> json) => PostReaction(
        uid: json["uid"],
        pid: json["pid"],
        pFavorite: json["p_favorite"],
        pView: json["p_view"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "pid": pid,
        "p_favorite": pFavorite,
        "p_view": pView,
      };
}

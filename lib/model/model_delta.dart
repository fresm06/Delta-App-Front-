class Del {
    String title, picture, detail, idea, studyTime;

    Del({required this.title, required this.picture, required this.detail, required this.idea, required this.studyTime});

  Del.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        picture = map['picture'],
        detail = map['detail'],
        idea = map['idea'],
        studyTime = map['studyTime'];
  Del.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        picture = json['picture'],
        detail = json['detail'],
        idea = json['idea'],
        studyTime = json['studyTime'];
}

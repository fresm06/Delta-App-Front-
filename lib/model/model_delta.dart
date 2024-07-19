class Del {
    String title;

    Del({required this.title});


  Del.fromMap(Map<String, dynamic> map)
      : title = map['title'];

  Del.fromJson(Map<String, dynamic> json)
      : title = json['title'];
}

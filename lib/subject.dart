class Subject {
  String? title;
  String? content;
  String? day;
  int? done;
  int? id;

  Subject({this.title, this.content, this.day, this.done, this.id});

  Map<String, dynamic> maps() {
    return {
      'title' : title,
      'content' : content,
      'day' : day,
      'done' : done,
      'id' : id
    };
  }
}
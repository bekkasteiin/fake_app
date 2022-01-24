import 'dart:convert';

class ToDoList {
  int work;
  int testing;
  int appeal;
  int salary;
  int eating;
  int transportation;
  int news;

  ToDoList({
    this.work,
    this.testing,
    this.appeal,
    this.salary,
    this.eating,
    this.transportation,
    this.news,
  });

  static getDefault() => ToDoList(
      work: 0, testing: 0, appeal: 0, salary: 0, eating: 0, transportation: 0);

  fromJson(String str) => ToDoList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ToDoList.fromMap(Map<String, dynamic> json) => ToDoList(
        work: json['work'] ?? 0,
        testing: json['testing'] ?? 0,
        appeal: json['appeal'] ?? 0,
        salary: json['salary'] ?? 0,
        eating: json['eating'] ?? 0,
        news: json['news'] ?? 0,
        transportation: json['transportation'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'work': work,
        'testing': testing,
        'appeal': appeal,
        'salary': salary,
        'eating': eating,
        'news': news,
        'transportation': transportation,
      };
}

/*   
*    LightPlan is an open source app created with the intent of helping users keep track of tasks.
*    Copyright (C) 2020-2021 LightPlan Team
*
*    This program is free software: you can redistribute it and/or modify
*    it under the terms of the GNU General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU General Public License for more details.
*
*    You should have received a copy of the GNU General Public License
*    along with this program. If not, see https://www.gnu.org/licenses/.
*
*    Contact the authors at: contact@lightplanx.com
*/

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

enum Repetition {
  NONE,
  MONTHLY,
  WEEKLY,
  DAILY,
  HOURLY,
}

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  int id;

  @HiveField(1)
  int parentId;

  @HiveField(2)
  String title;

  @HiveField(3)
  int endDate;

  @HiveField(4)
  String shortDesc;

  @HiveField(5)
  String desc;

  @HiveField(6)
  bool isPredefined;

  @HiveField(7)
  bool canHaveChildren;

  @HiveField(8)
  int startDate;

  @HiveField(9)
  int repeatPeriod;

  Task.empty({int parentId}) {
    this.parentId = parentId;
    this.isPredefined = false;
    this.canHaveChildren = true;
    this.repeatPeriod = 0;
  }

  Task copyWith({
    int id,
    int parentId,
    String title,
    int endDate,
    String shortDesc,
    String desc,
    bool isPredefined,
    bool canHaveChildren,
    int startDate,
    Repetition repeatPeriod,
  }) {
    return Task(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      title: title ?? this.title,
      endDate: endDate ?? this.endDate,
      shortDesc: shortDesc ?? this.shortDesc,
      desc: desc ?? this.desc,
      isPredefined: isPredefined ?? this.isPredefined,
      canHaveChildren: canHaveChildren ?? this.canHaveChildren,
      startDate: startDate ?? this.startDate,
      repeatPeriod: repeatPeriod?.index ?? this.repeatPeriod,
    );
  }

  Task({
    this.id,
    this.parentId,
    @required this.title,
    @required this.endDate,
    this.shortDesc,
    this.desc,
    @required this.isPredefined,
    this.canHaveChildren = true,
    this.startDate,
    this.repeatPeriod = 0,
  });

  Task setId(int id) {
    this.id = id;
    return this;
  }

  Repetition get repetition {
    return Repetition.values[this.repeatPeriod];
  }

  set repetition(Repetition repetition) {
    this.repeatPeriod = repetition.index;
  }

  DateTime endDateTime;

  DateTime getEndDateTime() {
    DateTime date = endDateTime;
    if (date == null) {
      date = DateTime.fromMillisecondsSinceEpoch(endDate);
      endDateTime = date;
    }
    return date;
  }

  @override
  String toString() {
    return "Task[id=$id,parentId=$parentId,title=$title,startDate=$startDate,endDate=$endDate,shortDesc=$shortDesc,desc=$desc";
  }
}

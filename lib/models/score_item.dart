class ScoreItem {
  String _userId;
  double _timeUsage;
  DateTime _date;

  ScoreItem(this._userId, this._timeUsage, this._date);

  String get userId => _userId;

  double get timeUsage => _timeUsage;

  DateTime get date => _date;
}

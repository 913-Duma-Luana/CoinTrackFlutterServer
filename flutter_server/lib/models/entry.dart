List<Entry> entriesFromMap(dynamic str) => List<Entry>.from((str).map((x) => Entry.fromMapObject(x)));

class Entry {
  String? _id;
  String _name;
  int _year;
  int _month;
  int _day;
  int _time;
  String _category;
  String _details;
  int _value;

  Entry(this._name, this._year, this._month, this._day, this._time,
      this._category, this._value, this._details);

  Entry.withId(
      this._id,
      this._name,
      this._year,
      this._month,
      this._day,
      this._time,
      this._category,
      this._value,
      this._details);

  String? get id => _id;

  String get name => _name;

  String get details => _details;

  int get value => _value;

  String get category => _category;

  int get year => _year;

  int get month => _month;

  int get day => _day;

  int get time => _time;

  set name(String value) {
    _name = value;
  }

  set value(int value) {
    _value = value;
  }

  set details(String value) {
    _details = value;
  }

  set category(String value) {
    _category = value;
  }

  set time(int value) {
    _time = value;
  }

  set day(int value) {
    _day = value;
  }

  set month(int value) {
    _month = value;
  }

  set year(int value) {
    _year = value;
  }

  // Convert an Entry object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['year'] = _year;
    map['month'] = _month;
    map['day'] = _day;
    map['time'] = _time;
    map['category'] = _category;
    map['details'] = _details;
    map['value'] = _value;

    return map;
  }

  // Extract an Entry object from a Map object
  Entry.fromMapObject(Map<String, dynamic> map)
      : _id = map['id'],
        _name = map["name"],
        _year = map['year'],
        _month = map['month'],
        _day = map['day'],
        _time = map['time'],
        _category = map['category'],
        _details = map['details'],
        _value = map['value'] {}
}

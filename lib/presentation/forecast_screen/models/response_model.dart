class ResponseModel {
  Data? data;
  List<Warnings>? warnings;

  ResponseModel({this.data, this.warnings});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['warnings'] != null) {
      warnings = <Warnings>[];
      json['warnings'].forEach((v) {
        warnings!.add(Warnings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (warnings != null) {
      data['warnings'] = warnings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<Timelines>? timelines;

  Data({this.timelines});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['timelines'] != null) {
      timelines = <Timelines>[];
      json['timelines'].forEach((v) {
        timelines!.add(new Timelines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (timelines != null) {
      data['timelines'] = timelines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timelines {
  String? timestep;
  String? startTime;
  String? endTime;
  List<Intervals>? intervals;

  Timelines({this.timestep, this.startTime, this.endTime, this.intervals});

  Timelines.fromJson(Map<String, dynamic> json) {
    timestep = json['timestep'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    if (json['intervals'] != null) {
      intervals = <Intervals>[];
      json['intervals'].forEach((v) {
        intervals!.add(Intervals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['timestep'] = timestep;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    if (intervals != null) {
      data['intervals'] = intervals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Intervals {
  String? startTime;
  Values? values;

  Intervals({this.startTime, this.values});

  Intervals.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    values = json['values'] != null ? Values.fromJson(json['values']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startTime'] = startTime;
    if (values != null) {
      data['values'] = values!.toJson();
    }
    return data;
  }
}

class Values {
  var precipitationIntensity;
  var precipitationType;
  var windSpeed;
  var windGust;
  var windDirection;
  var temperature;
  var temperatureApparent;
  var cloudCover;
  var cloudBase;
  var cloudCeiling;
  var weatherCode;

  Values(
      {this.precipitationIntensity,
      this.precipitationType,
      this.windSpeed,
      this.windGust,
      this.windDirection,
      this.temperature,
      this.temperatureApparent,
      this.cloudCover,
      this.cloudBase,
      this.cloudCeiling,
      this.weatherCode});

  Values.fromJson(Map<String, dynamic> json) {
    precipitationIntensity = json['precipitationIntensity'];
    precipitationType = json['precipitationType'];
    windSpeed = json['windSpeed'];
    windGust = json['windGust'];
    windDirection = json['windDirection'];
    temperature = json['temperature'];
    temperatureApparent = json['temperatureApparent'];
    cloudCover = json['cloudCover'];
    cloudBase = json['cloudBase'];
    cloudCeiling = json['cloudCeiling'];
    weatherCode = json['weatherCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['precipitationIntensity'] = this.precipitationIntensity;
    data['precipitationType'] = this.precipitationType;
    data['windSpeed'] = this.windSpeed;
    data['windGust'] = this.windGust;
    data['windDirection'] = this.windDirection;
    data['temperature'] = this.temperature;
    data['temperatureApparent'] = this.temperatureApparent;
    data['cloudCover'] = this.cloudCover;
    data['cloudBase'] = this.cloudBase;
    data['cloudCeiling'] = this.cloudCeiling;
    data['weatherCode'] = this.weatherCode;
    return data;
  }
}

class Warnings {
  int? code;
  String? type;
  String? message;
  Meta? meta;

  Warnings({this.code, this.type, this.message, this.meta});

  Warnings.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    type = json['type'];
    message = json['message'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Meta {
  String? timestep;
  String? from;
  String? to;

  Meta({this.timestep, this.from, this.to});

  Meta.fromJson(Map<String, dynamic> json) {
    timestep = json['timestep'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestep'] = this.timestep;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}

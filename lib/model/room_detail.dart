class RoomDetailModel {
  int totalSize;
  bool done;
  List<Records> records;

  RoomDetailModel({this.totalSize, this.done, this.records});

  String get maintainanceLabelString {
    List<String> listName = [];

    for (Records record in this.records) {
      listName.add(record.name);
    }

    if (listName.length == 0) {
      return 'None';
    }
    return listName.join(', ');
  }

  RoomDetailModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['totalSize'];
    done = json['done'];
    if (json['records'] != null) {
      records = [];
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalSize'] = this.totalSize;
    data['done'] = this.done;
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  Attributes attributes;
  String id;
  String typeC;
  String name;
  String statusC;
  String photoC;

  Records(
      {this.attributes,
      this.id,
      this.typeC,
      this.name,
      this.statusC,
      this.photoC});

  Records.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    id = json['Id'];
    typeC = json['Type__c'];
    name = json['Name'];
    statusC = json['Status__c'];
    photoC = json['Photo__c'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    data['Id'] = this.id;
    data['Type__c'] = this.typeC;
    data['Name'] = this.name;
    data['Status__c'] = this.statusC;
    data['Photo__c'] = this.photoC;
    return data;
  }
}

class Attributes {
  String type;
  String url;

  Attributes({this.type, this.url});

  Attributes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

class Request {
  String name;
  String descriptionC;
  String unitC;
  String photoC;
  String typeC;

  Request({this.name, this.descriptionC, this.unitC, this.photoC, this.typeC});

  Request.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    descriptionC = json['Description__c'];
    unitC = json['Unit__c'];
    photoC = json['Photo__c'];
    typeC = json['Type__c'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description__c'] = this.descriptionC;
    data['Unit__c'] = this.unitC;
    data['Photo__c'] = this.photoC;
    data['Type__c'] = this.typeC;
    return data;
  }
}

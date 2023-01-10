import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/entry.dart';

class APIService {
  static var client = http.Client();
  static Future<List<Entry>?> getEntries() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.entryURL);
    var response = await client.get(url, headers: requestHeaders);
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return entriesFromMap(data["data"]);
    }
    else {
      return null;
    }
  }

  static Future<bool> saveEntry(
      Entry model,
      bool isEditMode,
      ) async {
    var entryURL = Config.entryURL;
    if(isEditMode) {
      entryURL = entryURL + "/" + model.id.toString();
    }
    var url = Uri.http(Config.apiURL, entryURL);
    debugPrint("entry url for update: $url");
    var requestMethod = isEditMode? "PUT" : "POST";
    var request = http.MultipartRequest(requestMethod, url);
    request.fields["name"] = model.name;
    request.fields["year"] = model.year.toString();
    request.fields["month"] = model.month.toString();
    request.fields["day"] = model.day.toString();
    request.fields["time"] = model.time.toString();
    request.fields["category"] = model.category;
    request.fields["details"] = model.details;
    request.fields["value"] = model.value.toString();
    var response = await request.send();
    if(response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }
  static Future<bool> deleteEntry(entryId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.entryURL + "/" + entryId);
    var response = await client.delete(url, headers: requestHeaders);
    if(response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }
}
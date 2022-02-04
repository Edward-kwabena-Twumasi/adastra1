import 'package:flutter/material.dart';

class Appointment{

  DateTime _timeOfAppointment;
  int _minDuration;
  String? _barberId;
  String _clientId;
  String _comment;
  DateTime _bookingTime;
  int _rate;
  String _serviceStatus;
  List<String> _services;
  String shopId;


  Appointment(
      this._timeOfAppointment,
      this._minDuration,
      this._barberId,
      this._clientId,
      this._comment,
      this._bookingTime,
      this._rate,
      this._serviceStatus,
      this._services,
      this.shopId);

  List<String> get services => _services;

  set services(List<String> value) {
    _services = value;
  }

  String get serviceStatus => _serviceStatus;

  set serviceStatus(String value) {
    _serviceStatus = value;
  }

  int get rate => _rate;

  set rate(int value) {
    _rate = value;
  }

  DateTime get bookingTime => _bookingTime;

  set bookingTime(DateTime value) {
    _bookingTime = value;
  }

  String get comment => _comment;

  set comment(String value) {
    _comment = value;
  }

  String get clientId => _clientId;

  set clientId(String value) {
    _clientId = value;
  }

  int get minDuration => _minDuration;

  set minDuration(int value) {
    _minDuration = value;
  }

  DateTime get timeOfAppointment => _timeOfAppointment;

  set timeOfAppointment(DateTime value) {
    _timeOfAppointment = value;
  }
}
import 'package:dio/dio.dart';
import 'package:klinikku/cores/bases/base_services.dart';

class DashboardServices extends BaseService {
  getDashboardData() async {
    try {
      final response = await get(url: '/dashboard');
      print(response);
      return response;
    } on DioException catch (e) {
      print('error get dashboard data');
      return e;
    }
  }

  getRegions() async {
    try {
      final response = await get(url: '/regions');
      print(response);
      return response;
    } on DioException catch (e) {
      print('error get regions $e');
      return e;
    }
  }

  getBookingList({String regionId = ""}) async {
    try {
      final response = await get(
        url: '/encounters',
        params: {"region_id": regionId},
      );
      print(response);
      return response;
    } on DioException catch (e) {
      print('error get booking list $e');
      return e;
    }
  }
}

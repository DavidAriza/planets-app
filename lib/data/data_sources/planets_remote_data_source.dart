import 'package:dio/dio.dart';
import 'package:planets_app/core/errors/dio_failure.dart';
import 'package:planets_app/core/errors/error.dart';
import 'package:planets_app/core/errors/exception.dart';
import 'package:planets_app/core/network/dio_http_client.dart';
import 'package:planets_app/data/models/planet_model.dart';

abstract class PlanetsRemoteDataSource {
  Future<List<PlanetModel>> getPlanets();
}

class PlanetsRemoteDataSourceImpl implements PlanetsRemoteDataSource {
  final HttpClient client;

  PlanetsRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PlanetModel>> getPlanets() async {
    try {
      final response = await client.get('/planets');
      if (response.statusCode == 200) {
        return (response.data['data'] as List).map((e) => PlanetModel.fromJson(e)).toList();
      } else {
        throw const FormatException('Data is not a List');
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}

import 'package:dio/dio.dart';

import 'package:pokedex_challenge/data/api/api_constants.dart';
import 'package:pokedex_challenge/data/modules/home/response/pokemon_redirect_resource_response.dart';
import 'package:pokedex_challenge/data/modules/home/response/pokemon_response.dart';
import 'package:pokedex_challenge/data/modules/home/service/pokemon_service_contract.dart';

class PokemonService implements PokemonServiceContract {
  final Dio dio = Dio();

  @override
  Future<List<PokemonRedirectResourceResponse>> getBasicPaginatedPokemons({
    int limit = 10,
    required int offset,
  }) async {
    final response = await dio.get(
      ApiConstants.pokemonUrlEndpoint,
      queryParameters: <String, dynamic>{
        'offset': offset,
        'limit': limit,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = response.data;
      List<PokemonRedirectResourceResponse> result =
          List<PokemonRedirectResourceResponse>.from(
        jsonBody['results']
            .map(
              (value) => PokemonRedirectResourceResponse.fromJson(value),
            )
            .toList(),
      );

      return result;
    }
    throw DioError(
      requestOptions: RequestOptions(
        path: ApiConstants.pokemonUrlEndpoint,
      ),
    );
  }

  @override
  Future<PokemonResponse> getPokemonByUrl({required String url}) async {
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return PokemonResponse.fromJson(json: response.data);
    }
    throw DioError(
      requestOptions: RequestOptions(
        path: url,
      ),
    );
  }
}

import 'package:pokedex_challenge/domain/entity/pokemon_redirect_resource_entity.dart';

class PokemonRedirectResourceResponse extends PokemonRedirectResourceEntity {
  PokemonRedirectResourceResponse({
    super.name,
    super.url,
  });

  factory PokemonRedirectResourceResponse.fromJson(dynamic json) {
    return PokemonRedirectResourceResponse(
      name: json['name'],
      url: json['url']
    );
  }
}

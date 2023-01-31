abstract class PokemonItemEvent{}

class PokemonItemFetchData extends PokemonItemEvent{
  String url;
  PokemonItemFetchData({required this.url});
}
class PokemonItemAddFav extends PokemonItemEvent{}
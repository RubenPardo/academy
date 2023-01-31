abstract class HomepageEvent{}

class HomePageFetchData extends HomepageEvent{
  bool isRefresh;
  HomePageFetchData({required this.isRefresh});
}
class HomePageAddElement extends HomepageEvent{}



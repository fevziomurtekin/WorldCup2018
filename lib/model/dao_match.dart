import 'dao_team.dart';
import 'dao_teamevent.dart';
import 'dao_teamstatistics.dart';
import 'dao_weather.dart';

class daoMatch{
  final String venue;
  final String location;
  final String status;
  final String time;
  final String fifaId;
  final daoWeather weather;
  final String attendance;
  final List<String> officials ;
  final String stageName;
  final String homeTeamCountry;
  final String awayTeamCountry;
  final String datetime;
  final String winner;
  final String winnerCode;
  final daoTeam homeTeam;
  final daoTeam awayTeam;
  final List<daoTeamEvent> homeTeamEvents ;
  final List<daoTeamEvent> awayTeamEvents ;
  final daoTeamStatistics homeTeamStatistics;
  final daoTeamStatistics awayTeamStatistics;
  final String lastEventUpdateAt;
  final String lastScoreUpdateAt;

  daoMatch(this.venue,this.location,this.status,this.time,this.fifaId,this.weather,this.attendance,this.officials,this.stageName
      ,this.homeTeamCountry,this.awayTeamCountry,this.datetime,this.winner,this.winnerCode,this.homeTeam,this.awayTeam,this.homeTeamEvents,
      this.awayTeamEvents,this.homeTeamStatistics,this.awayTeamStatistics,this.lastEventUpdateAt,this.lastScoreUpdateAt);
}
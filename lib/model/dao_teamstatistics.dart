import 'dao_starteleven.dart';
class daoTeamStatistics{
  final String country;
  final int attemptsOnGoal;
  final int onTarget;
  final int offTarget;
  final int blocked;
  final int woodwork;
  final int corners;
  final int offsides;
  final int ballPossession;
  final int passAccuracy;
  final int numPasses;
  final int passesCompleted;
  final int distanceCovered;
  final int ballsRecovered;
  final int tackles;
  final int clearances;
  final int yellowCards;
  final int redCards;
  final int foulsCommitted;
  final String tactics;
  final List<daoStartEleven> startingEleven;
  final List<daoStartEleven> substitutes;

  daoTeamStatistics(this.country,this.attemptsOnGoal,this.onTarget,this.offTarget,this.blocked,this.woodwork,this.corners
      ,this.offsides,this.ballPossession,this.passAccuracy,this.numPasses,this.passesCompleted,this.distanceCovered
      ,this.ballsRecovered,this.tackles,this.clearances,this.yellowCards,this.redCards,this.foulsCommitted,this.tactics,
      this.startingEleven,this.substitutes);
}
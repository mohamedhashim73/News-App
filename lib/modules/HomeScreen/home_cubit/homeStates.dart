import 'package:flutter/material.dart';
abstract class HomeStates {}

class InitialAppState extends HomeStates{}

class GetDataFormApiState extends HomeStates{}

class GetSearchDataSuccessState extends HomeStates{}

class GetSearchDataErrorState extends HomeStates{}

class GetSearchDataLoadingState extends HomeStates{}

class ClearSearchDataSuccessState extends HomeStates{}

class CreateDatabaseState extends HomeStates{}

class LoadingDuringGettingDataFromApi extends HomeStates{}

class InsertToDatabaseState extends HomeStates{}

class GetDataFromDatabaseState extends HomeStates{}

class DeletedItemFromDatabaseState extends HomeStates{}

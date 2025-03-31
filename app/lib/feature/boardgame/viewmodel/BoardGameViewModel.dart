import 'package:flutter/foundation.dart';
import 'package:jamesboard/datasource/model/response/BoardGameRecommendResponse.dart';

import 'package:jamesboard/datasource/model/response/BoardGameResponse.dart';
import 'package:jamesboard/datasource/model/response/BoardGameTopResponse.dart';
import 'package:jamesboard/main.dart';

import '../../../repository/BoardGameRepository.dart';

class BoardGameViewModel extends ChangeNotifier {
  final BoardGameRepository _repository;

  List<BoardGameRecommendResponse> _recommendedGames = [];
  List<BoardGameRecommendResponse> get recommendedGames => _recommendedGames;

  List<BoardGameResponse> _games = [];
  List<BoardGameResponse> get games => _games;

  List<BoardGameTopResponse> _topGames = [];
  List<BoardGameTopResponse> get topGames => _topGames;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  BoardGameViewModel(this._repository);

  Future<void> getRecommendedGames({int limit = 10}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (_recommendedGames.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
    }

    try {
      _recommendedGames = await _repository.getRecommendedGames(limit: limit);
    } catch (e) {
      _errorMessage = 'Failed to load recommended games: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getBoardGamesForCategory(
      Map<String, dynamic> queryParameters) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (_games.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
    }

    try {
      _games = await _repository.getBoardGames(queryParameters);
    } catch (e) {
      _errorMessage = 'Failed to load board games: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTopGames(Map<String, dynamic> queryParameters) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (_topGames.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
    }

    try {
      _topGames = await _repository.getTopGames(queryParameters);

      logger.d("viewModel topGames : ${topGames}");
    } catch (e) {
      _errorMessage = 'Failed to load board games: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

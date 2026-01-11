import 'package:dio/dio.dart';
import '../models/models.dart';
import '../constants/api_constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  // Auth
  Future<UserProfile> register(UserRegister request) async {
    final response = await _dio.post(
      ApiConstants.register,
      data: request.toJson(),
    );
    return UserProfile.fromJson(response.data);
  }

  Future<TokenResponse> login(UserLogin request) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: request.toJson(),
    );
    return TokenResponse.fromJson(response.data);
  }

  Future<void> logout() async {
    await _dio.post(ApiConstants.logout);
  }

  // User
  Future<UserProfile> getProfile() async {
    final response = await _dio.get(ApiConstants.userProfile);
    return UserProfile.fromJson(response.data);
  }

  Future<UserProfile> updateProfile(UserProfileUpdate request) async {
    final response = await _dio.patch(
      ApiConstants.userProfile,
      data: request.toJson(),
    );
    return UserProfile.fromJson(response.data);
  }

  Future<UserStats> getStats() async {
    final response = await _dio.get(ApiConstants.userStats);
    return UserStats.fromJson(response.data);
  }

  // Words
  Future<List<WordListItem>> getWords(Map<String, dynamic> queries) async {
    final response = await _dio.get(
      ApiConstants.words,
      queryParameters: queries,
    );
    return (response.data as List)
        .map((json) => WordListItem.fromJson(json))
        .toList();
  }

  Future<WordDetail> getWord(int id) async {
    final response = await _dio.get(ApiConstants.wordDetail(id));
    return WordDetail.fromJson(response.data);
  }

  Future<ReviewPageData> getReviewPage(int id) async {
    final response = await _dio.get(ApiConstants.wordReviewPage(id));
    return ReviewPageData.fromJson(response.data);
  }

  Future<WordDetail> createWord(WordCreate request) async {
    final response = await _dio.post(
      ApiConstants.words,
      data: request.toJson(),
    );
    return WordDetail.fromJson(response.data);
  }

  Future<List<Category>> getCategories() async {
    final response = await _dio.get(ApiConstants.categories);
    return (response.data as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  // Review
  Future<List<DailyStackItem>> getDailyStack(String? date) async {
    final response = await _dio.get(
      ApiConstants.dailyStack,
      queryParameters: date != null ? {'target_date': date} : null,
    );
    return (response.data as List)
        .map((json) => DailyStackItem.fromJson(json))
        .toList();
  }

  Future<AddWordsResponse> addWords(AddWordsRequest request) async {
    final response = await _dio.post(
      ApiConstants.addWords,
      data: request.toJson(),
    );
    return AddWordsResponse.fromJson(response.data);
  }

  Future<ReviewResponse> submitReview(ReviewSubmit request) async {
    final response = await _dio.post(
      ApiConstants.submitReview,
      data: request.toJson(),
    );
    return ReviewResponse.fromJson(response.data);
  }

  Future<List<UpcomingReview>> getUpcomingReviews(int days) async {
    final response = await _dio.get(
      ApiConstants.upcomingReviews,
      queryParameters: {'days_ahead': days},
    );
    return (response.data as List)
        .map((json) => UpcomingReview.fromJson(json))
        .toList();
  }

  Future<UserStats> getProgressOverview() async {
    final response = await _dio.get(ApiConstants.progressOverview);
    return UserStats.fromJson(response.data);
  }

  Future<WordProgressDetail> getWordProgress(int id) async {
    final response = await _dio.get(ApiConstants.wordProgress(id));
    return WordProgressDetail.fromJson(response.data);
  }

  // AI
  Future<QuizResponse> generateQuiz(QuizGenerateRequest request) async {
    final response = await _dio.post(
      ApiConstants.generateQuiz,
      data: request.toJson(),
    );
    return QuizResponse.fromJson(response.data);
  }

  Future<ExplainResponse> explainWord(ExplainRequest request) async {
    final response = await _dio.post(
      ApiConstants.explainWord,
      data: request.toJson(),
    );
    return ExplainResponse.fromJson(response.data);
  }

  Future<StoryResponse> generateStory(StoryGenerateRequest request) async {
    final response = await _dio.post(
      ApiConstants.generateStory,
      data: request.toJson(),
    );
    return StoryResponse.fromJson(response.data);
  }

  Future<ChatResponse> chat(ChatRequest request) async {
    final response = await _dio.post(
      ApiConstants.chat,
      data: request.toJson(),
    );
    return ChatResponse.fromJson(response.data);
  }

  // Media
  Future<List<MediaItem>> getWordMedia(int id) async {
    final response = await _dio.get(ApiConstants.wordMedia(id));
    return (response.data as List)
        .map((json) => MediaItem.fromJson(json))
        .toList();
  }
}

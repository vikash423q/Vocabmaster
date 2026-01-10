import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/models.dart';
import '../constants/api_constants.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // Auth
  @POST(ApiConstants.register)
  Future<UserProfile> register(@Body() UserRegister request);

  @POST(ApiConstants.login)
  Future<TokenResponse> login(@Body() UserLogin request);

  @POST(ApiConstants.logout)
  Future<void> logout();

  // User
  @GET(ApiConstants.userProfile)
  Future<UserProfile> getProfile();

  @PATCH(ApiConstants.userProfile)
  Future<UserProfile> updateProfile(@Body() UserProfileUpdate request);

  @GET(ApiConstants.userStats)
  Future<UserStats> getStats();

  // Words
  @GET(ApiConstants.words)
  Future<List<WordListItem>> getWords(@Queries() Map<String, dynamic> queries);

  @GET('${ApiConstants.words}/{id}')
  Future<WordDetail> getWord(@Path('id') int id);

  @GET('${ApiConstants.words}/{id}/review-page')
  Future<ReviewPageData> getReviewPage(@Path('id') int id);

  @POST(ApiConstants.words)
  Future<WordDetail> createWord(@Body() WordCreate request);

  @GET(ApiConstants.categories)
  Future<List<Category>> getCategories();

  // Review
  @GET(ApiConstants.dailyStack)
  Future<List<DailyStackItem>> getDailyStack(@Query('target_date') String? date);

  @POST(ApiConstants.addWords)
  Future<AddWordsResponse> addWords(@Body() AddWordsRequest request);

  @POST(ApiConstants.submitReview)
  Future<ReviewResponse> submitReview(@Body() ReviewSubmit request);

  @GET(ApiConstants.upcomingReviews)
  Future<List<UpcomingReview>> getUpcomingReviews(@Query('days_ahead') int days);

  @GET(ApiConstants.progressOverview)
  Future<UserStats> getProgressOverview();

  @GET('${ApiConstants.progressOverview}/word/{id}')
  Future<WordProgressDetail> getWordProgress(@Path('id') int id);

  // AI
  @POST(ApiConstants.generateQuiz)
  Future<QuizResponse> generateQuiz(@Body() QuizGenerateRequest request);

  @POST(ApiConstants.explainWord)
  Future<ExplainResponse> explainWord(@Body() ExplainRequest request);

  @POST(ApiConstants.generateStory)
  Future<StoryResponse> generateStory(@Body() StoryGenerateRequest request);

  @POST(ApiConstants.chat)
  Future<ChatResponse> chat(@Body() ChatRequest request);

  // Media
  @GET('${ApiConstants.words}/{id}/media')
  Future<List<MediaItem>> getWordMedia(@Path('id') int id);
}

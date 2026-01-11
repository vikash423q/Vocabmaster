class ApiConstants {
  static const String baseUrl = 'https://vocabapi.vikashgaurav.com';
  static const String apiPrefix = '/api';
  
  // Auth
  static const String register = '$apiPrefix/auth/register';
  static const String login = '$apiPrefix/auth/login';
  static const String logout = '$apiPrefix/auth/logout';
  
  // User
  static const String userProfile = '$apiPrefix/user/profile';
  static const String userStats = '$apiPrefix/user/stats';
  
  // Words
  static const String words = '$apiPrefix/words';
  static String wordDetail(int id) => '$words/$id';
  static String wordReviewPage(int id) => '$words/$id/review-page';
  static const String categories = '$words/categories/list';
  
  // Review
  static const String dailyStack = '$apiPrefix/daily-stack';
  static const String addWords = '$apiPrefix/daily-stack/add-words';
  static const String submitReview = '$apiPrefix/review/submit';
  static const String upcomingReviews = '$apiPrefix/review/upcoming';
  static const String progressOverview = '$apiPrefix/progress/overview';
  static String wordProgress(int id) => '$apiPrefix/progress/word/$id';
  
  // AI
  static const String generateQuiz = '$apiPrefix/ai/generate-quiz';
  static const String explainWord = '$apiPrefix/ai/explain-word';
  static const String generateStory = '$apiPrefix/ai/generate-story';
  static const String chat = '$apiPrefix/ai/chat';
  
  // Media
  static String wordMedia(int id) => '$words/$id/media';
}

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
  static const String wordsBatch = '$words/batch';
  static const String categories = '$words/categories/list';
  static const String parentCategories = '$words/categories/parents';
  static String subcategories(int parentId) => '$words/categories/subcategories/$parentId';
  
  // Review
  static const String dailyStack = '$apiPrefix/daily-stack';
  static const String addWords = '$apiPrefix/daily-stack/add-words';
  static const String submitReview = '$apiPrefix/review/submit';
  static const String upcomingReviews = '$apiPrefix/review/upcoming';
  static const String reviewHistory = '$apiPrefix/review/history';
  static const String progressOverview = '$apiPrefix/progress/overview';
  static String wordProgress(int id) => '$apiPrefix/progress/word/$id';
  static const String progressWords = '$apiPrefix/progress/words';
  
  // AI
  static const String generateQuiz = '$apiPrefix/ai/generate-quiz';
  static const String explainWord = '$apiPrefix/ai/explain-word';
  static const String generateStory = '$apiPrefix/ai/generate-story';
  static const String chat = '$apiPrefix/ai/chat';
  static const String generateWordContext = '$apiPrefix/ai/generate-word-context';
  
  // Media
  static String wordMedia(int id) => '$words/$id/media';
  
  // Assessment
  static const String assessmentStack = '$apiPrefix/assessment/stack';
  static const String assessmentSubmit = '$apiPrefix/assessment/submit';
  static const String stackRecommendations = '$apiPrefix/assessment/recommendations';
  static String markWordKnown(int id) => '$apiPrefix/assessment/mark-known/$id';
  
  // Games
  static const String games = '$apiPrefix/games';
  static const String iceburstStart = '$games/iceburst/start';
}

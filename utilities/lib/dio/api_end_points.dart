class APIEndPoints {
  static const live = 'https://www.gradding.com/api/mobile-api/v1/';
  static const local = 'http://10.0.20.122:8000/api/mobile-api/v1/';
  static const beta = 'https://beta.gradding.com/api/mobile-api/v1/';
  static const base = beta;

  static const defaultApi = 'default';
  static const menuItems = "menu-items";
  static const updateFcmToken = "fcm_token";

  static const mobileVerification = 'mobile-verification';
  static const otpSent = 'otp-sent';
  static const otpVerification = 'otp-verification';
  static const pinVerification = 'pin-verification';
  static const pinGenerate = 'pin-generate';

  static const getServices = 'get-services';
  static const onBoardingQuestions = 'onboarding-questions';
  static const onBoardingSubmit = 'onboarding-questions-submit';

  static const getStates = 'get-states';
  static const getCities = 'get-cities';
  static const getCountry = 'get-countries';

  static const bookSession = 'booksession';

  // ------------------------------------IELTS PACKAGE APIS ENDPOINTS-----------------------------------------
  static const dashboardData = "dashboard-data";
  static const myTasks = "my-tasks";

  static const assignedMockTest = "assigned-mock-test";
  static const assignedPracticeTest = "assigned-practice-test";
  static const mockTestDetails = "mock-test-details";
  static const classSchedule = "class-schedule";

  static const userAttendance = "user-attendance";

  static const studyMaterial = "study-material";

  static const profile = 'profile';
  static const updateProfileData = "update-profile-data";

  // ------------------------------------GUEST PACKAGE APIS ENDPOINTS-----------------------------------------
  static const demoClassLink = 'demo-class-link';
  static const getReportCard = 'get-report-card';
  static const getPlansData = 'plans-data';
  static const getOrderId = 'get-order-id';
  static const generatePayment = 'generate-payment';

  static const guestDashboard = 'guest-dashboard';

  static const updateExamName = 'update-exam-name';

// ------------------------------------Study Abroad PACKAGE APIS ENDPOINTS-----------------------------------------
  static const studyAbroadDashboard = 'study-abroad-dashboard';

  static const document = 'document';
  static const documentUpload = 'document-upload';
  static const documentDelete = 'document-delete';

  static const applicationManager = 'application-manager';

  static const getCourses = 'courses/by/country';
  static const getUniversity = 'university/by/country';

  static const coursesFilter = 'courseFilterData';
  static const universityFilter = 'universityFilterData';

  static const shortlistCourse = 'shortlist-course';
  static const applyCourse = 'apply-application';

  static const getComments = 'get-comments';
  static const uploadComments = 'upload_comments';
}

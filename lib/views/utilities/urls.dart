// ignore_for_file: constant_identifier_names

class Urls {
  //Base
  static const url = "https://itmates.digital/gasstation/";
  static const baseUrl = "https://itmates.digital/gasstation/api/";
  static const profileImageUrl = "https://itmates.digital/gasstation/public/profileImages/";
  // static const categoryImageUrl = "https://itmates.digital/gasstation_merchant/public/categoryicon";
  static const x_client_token = "e0271afd8a3b8257af70deaceeedsf87rer4";

  //Other Apis
  static const categoriesUrl = "${baseUrl}categories";
  static const submitPhone = "${baseUrl}submitContactNumber";
  static const verifyPhone = "${baseUrl}verifyOtpForMobileno";
  static const submitEmail = "${baseUrl}submitEmail";
  static const verifyEmail = "${baseUrl}verifyOtpForEmail";
  static const register = "${baseUrl}registerUser";
  static const login = "${baseUrl}loginUser";
  static const logout = "${baseUrl}logoutUser";
  static const changePassword = "${baseUrl}changepassword";
  static const submitEmailForgotPassword = "${baseUrl}sendEmailForgotPassword";
  static const verifyOtpForgotPassword = "${baseUrl}verifyotpforchangepass";
  static const resetPassword = "${baseUrl}resetpassword";
  static const submitPhoneForgotPassword = "${baseUrl}sendMobileForgotPassword";
  static const profile = "${baseUrl}profileUser";
  static const updateProfileImage = "${baseUrl}updateprofileImage";
  static const updateProfile = "${baseUrl}updateprofile";
  static const discountList = "${baseUrl}discountList";
  static const addDiscount = "${baseUrl}addDiscount";
  static const editDiscount = "${baseUrl}updateDiscount";
  static const deleteDiscount = "${baseUrl}deleteDiscount";
  static const termsConditions = "${baseUrl}termsCondtions";
  static const privacyPolicy = "${baseUrl}privacypolicy";
  static const helpSupport = "${baseUrl}supportSetting";
  static const myWallet = "${baseUrl}mywallet";
  static const reviews = "${baseUrl}merchantreviews";
  static const withdrawal = "${baseUrl}withdrawalNow";
  static const notification = "${baseUrl}notificationlist";
}
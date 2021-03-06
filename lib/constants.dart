final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String emptyEmailError="Не введён адрес электронной почты";
const String invalidEmailError="Неправильный адрес электронной почты";
const String emptyPasswordError="Не введён пароль";
const String shortPasswordError="Пароль слишком короткий";
const String matchPasswordError="Неверный пароль";
const String notMatchNewPasswordError="Новые пароли не сопадают";
const String matchOldNewPasswordError="Новый пароль сопадает со старым";
//const String serverUrl = "http://85.208.208.156:5000";
const String serverUrl = "https://phototips.xyz";
const String apiUrl = "$serverUrl/api";
const String apiUserRoute = '$apiUrl/user';
const String apiUserUpdatePasswordRoute = '$apiUserRoute/updatePassword';
const String apiUserUpdateInfoRoute = '$apiUserRoute/updateInfo';
const String apiPhotoRoute = '$apiUrl/photo';
const String apiLoginRoute ='$apiUserRoute/token';
const String apiRegisterRoute ='$apiUserRoute/create';
const String apiAddPhotoRoute = '$apiPhotoRoute/create';
const String apiDeletePhotoRoute = '$apiPhotoRoute/delete';
const String apiGetPhotoRoute = '$apiPhotoRoute/listBy';
const String apiModuleRoute = '$apiUrl/module/listAllIn';
const String apiSubmissionRoute = '$apiUrl/submission';
const String apiGetSubmissionRoute = '$apiSubmissionRoute/listBy';
const String apiCreateSubmissionRoute = '$apiSubmissionRoute/create';
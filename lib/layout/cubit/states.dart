import 'package:consultation/models/visa_payment.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

//change bottom bar
class AppchangeBotBarState extends AppStates {}

//app rating
class AppRatingState extends AppStates {}

//send proplem
class AppSendSucssesState extends AppStates {}

class AppSendErrorState extends AppStates {}

//edit profile
class EditImagePickedSuccsessState extends AppStates {}

class EditImagePickedErrorState extends AppStates {}

//update C
class UpdateLodingState extends AppStates {}

class UpdateSuccsessState extends AppStates {}

class UpdateErrorState extends AppStates {}

//rateing consultant
class RatingLodingState extends AppStates {}

class RatingSuccsessState extends AppStates {}

class RatingErrorState extends AppStates {}

//update U
class UpdateULodingState extends AppStates {}

class UpdateUSuccsessState extends AppStates {}

class UpdateUErrorState extends AppStates {}

//get consaltant data
class getCLodingState extends AppStates {}

class getCSuccsessState extends AppStates {}

class getCErrorState extends AppStates {}

//get user data
class getULodingState extends AppStates {}

class getUSuccsessState extends AppStates {}

class getUErrorState extends AppStates {}

//get All consaltant data
class getAllCLodingState extends AppStates {}

class getAllCSuccsessState extends AppStates {}

class getAllCErrorState extends AppStates {}

//chat
class SendMessageSucsesState extends AppStates {}

class SendMessageErrorState extends AppStates {}

//create conversation
class createConversationSucsesState extends AppStates {}

class createConversationErrorState extends AppStates {}

//get all conversation
class getAllConversationSucsesState extends AppStates {}

class getAllConversationErrorState extends AppStates {}

//create message
class createMessageSucsesState extends AppStates {}

class createMessageErrorState extends AppStates {}

//get message
class getMessageLodingState extends AppStates {}

class getMessageSucsesState extends AppStates {}

class getMessageErrorState extends AppStates {}

//sign out
class signoutSucssesState extends AppStates {}

//send notification
class sendNotificationSucssesState extends AppStates {}

class sendNotificationErrorState extends AppStates {}

//visa paymnent
class paymentLoadingState extends AppStates {}

class paymentSucssesState extends AppStates {
  visa_Model? model;

  paymentSucssesState({this.model});
}

class paymentErrorState extends AppStates {}

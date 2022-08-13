abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppchangeBotBarState extends AppStates{}

class AppRatingState extends AppStates{}

class AppSendSucssesState extends AppStates{}
class AppSendErrorState extends AppStates{}

class EditImagePickedSuccsessState extends AppStates{}
class EditImagePickedErrorState extends AppStates{}
//update
class UpdateLodingState extends AppStates{}
class UpdateSuccsessState extends AppStates{}
class UpdateErrorState extends AppStates{}
//get consaltant data
class getCLodingState extends AppStates{}
class getCSuccsessState extends AppStates{}
class getCErrorState extends AppStates{}
//get All consaltant data
class getAllCLodingState extends AppStates{}
class getAllCSuccsessState extends AppStates{}
class getAllCErrorState extends AppStates{}

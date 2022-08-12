abstract class RegesterStates{}

class RegesterInitialeState extends RegesterStates{}
//register U
class RegesterLodingeState extends RegesterStates{}
class RegesterSucssesState extends RegesterStates{}
class RegesterErrorState extends RegesterStates{}
//register C
class RegesterCLodingeState extends RegesterStates{}
class RegesterCSucssesState extends RegesterStates{}
class RegesterCErrorState extends RegesterStates{}
//update
class RegesterCUpdateLodingeState extends RegesterStates{}
class RegesterCUpdateSucssesState extends RegesterStates{}
class RegesterCUpdateErrorState extends RegesterStates{}
//upload Image
class RegesteruploadImageLodingeState extends RegesterStates{}
class RegesterruploadImageSucssesState extends RegesterStates{}
class RegesterruploadImageErrorState extends RegesterStates{}
//cahnge password visabelity
class RegesterChangePasswordState extends RegesterStates{}
class RegesterChangeSelectedState extends RegesterStates{}
class RegesterChangeregisterState extends RegesterStates{}
//profile image picked
class RegesterImagePickedSuccsessState extends RegesterStates{}
class RegesterImagePickedErrorState extends RegesterStates{}
//CV image picked
class RegesterCVImagePickedSuccsessState extends RegesterStates{}
class RegesterCVImagePickedErrorState extends RegesterStates{}


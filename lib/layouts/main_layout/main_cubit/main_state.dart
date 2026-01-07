abstract class MainStates{}

class MainInitialState extends MainStates{}
// Get Data States
class GetDataSuccessState extends MainStates{}
class GetDataLoadingState extends MainStates {}
class GetDataFailureState extends MainStates {
  final String error;
  GetDataFailureState(this.error);
}
// Delete Data States
class DeleteDataSuccessState extends MainStates {}
class DeleteDataLoadingState extends MainStates {}
class DeleteDataFailureState extends MainStates {
    final String error;
    DeleteDataFailureState(this.error);
}
// Insert Data States
class InsertDataSuccessState extends MainStates {}
class InsertDataLoadingState extends MainStates {}
class InsertDataFailureState extends MainStates {
   final String error;
  InsertDataFailureState(this.error);
}
// Update Data States
class UpdateDataSuccessState extends MainStates {}
class UpdateDataLoadingState extends MainStates {}
class UpdateDataFailureState extends MainStates {}



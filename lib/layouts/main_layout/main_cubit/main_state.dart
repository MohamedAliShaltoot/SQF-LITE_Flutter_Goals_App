abstract class MainStates{}

class MainInitialState extends MainStates{}
// Get Data States
class GetDataSuccessState extends MainStates{}
class GetDataLoadingState extends MainStates {}
class GetDataFailureState extends MainStates {
  final String error;
  GetDataFailureState(this.error);
}
// Remove Data States
class RemoveDataSuccessState extends MainStates {}
class RemoveDataLoadingState extends MainStates {}
class RemoveDataFailureState extends MainStates {}
// Insert Data States
class InsertDataSuccessState extends MainStates {}
class InsertDataLoadingState extends MainStates {}
class InsertDataFailureState extends MainStates {}
// Update Data States
class UpdateDataSuccessState extends MainStates {}
class UpdateDataLoadingState extends MainStates {}
class UpdateDataFailureState extends MainStates {}



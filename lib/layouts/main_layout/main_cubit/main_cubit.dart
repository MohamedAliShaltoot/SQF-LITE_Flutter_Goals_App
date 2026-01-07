import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goals_app/layouts/main_layout/main_cubit/main_state.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit():super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);











initDataBase() async{
  // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');

  // open the database
Database database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
  // When creating the db, create the table
  await db.execute(
      '''CREATE TABLE Goals (id INTEGER PRIMARY KEY, name TEXT)''');
});
}

List<Map> list = [];
getDataFormDataBase() async {
  // Get the records
   var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    Database database = await openDatabase(path);
  await database.rawQuery('SELECT * FROM Goals').then((value) {
    list = value;
    emit(GetDataSuccessState());
  }).catchError( (error) {
   
    emit(GetDataFailureState(error.toString()));
  });
}

}
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goals_app/layouts/main_layout/main_cubit/main_state.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  final TextEditingController goalController = TextEditingController();
Map<String, dynamic>? _lastDeletedGoal;
  int? _lastDeletedIndex;
List<Map<String, dynamic>> get activeGoals =>
      goalList.where((e) => e['isCompleted'] == 0).toList();

  List<Map<String, dynamic>> get completedGoals =>
      goalList.where((e) => e['isCompleted'] == 1).toList();

  Future<void> initDataBase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'goals.db');

    await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE Goals (
  id INTEGER PRIMARY KEY,
  name TEXT,
  isCompleted INTEGER
)
''',
        );
      },
    );
  }

 

  List<Map<String, dynamic>> goalList = [];

  /// Get all goals
  Future<void> getDataFormDataBase() async {
    emit(GetDataLoadingState());

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'goals.db');
    final database = await openDatabase(path);

    try {
      final result = await database.rawQuery('SELECT * FROM Goals');
      goalList = List<Map<String, dynamic>>.from(result);
      emit(GetDataSuccessState());
    } catch (error) {
      emit(GetDataFailureState(error.toString()));
    } finally {
      await database.close();
    }
  }

  /// Insert new goal
  Future<void> insertData(String name) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'goals.db');
    final database = await openDatabase(path);

    try {
      await database.rawInsert(
        'INSERT INTO Goals(name, isCompleted) VALUES(?, ?)',
        [name, 0],
      );


      emit(InsertDataSuccessState());

      // Refresh data
      await getDataFormDataBase();
    } catch (error) {
      emit(InsertDataFailureState(error.toString()));
    } finally {
      await database.close();
    }
  }

  /// Delete goal
  Future<void> deleteData(int id) async {
    _lastDeletedIndex = goalList.indexWhere((element) => element['id'] == id);

    _lastDeletedGoal = goalList[_lastDeletedIndex!];

  
    goalList.removeAt(_lastDeletedIndex!);
    emit(GetDataSuccessState());

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'goals.db');
    final database = await openDatabase(path);

    try {
      await database.rawDelete('DELETE FROM Goals WHERE id = ?', [id]);
      emit(DeleteDataSuccessState());
    } catch (error) {
      emit(DeleteDataFailureState(error.toString()));
    } finally {
      await database.close();
    }
  }


  @override
  Future<void> close() {
    goalController.dispose();
    return super.close();
  }
  Future<void> undoDelete() async {
    if (_lastDeletedGoal == null || _lastDeletedIndex == null) return;

    goalList.insert(_lastDeletedIndex!, _lastDeletedGoal!);
    emit(GetDataSuccessState());

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'goals.db');
    final database = await openDatabase(path);

    await database.rawInsert('INSERT INTO Goals(id, name) VALUES(?, ?)', [
      _lastDeletedGoal!['id'],
      _lastDeletedGoal!['name'],
    ]);

    _lastDeletedGoal = null;
    _lastDeletedIndex = null;

    await database.close();
  }
Future<void> toggleGoalStatus({
    required int id,
    required bool isCompleted,
  }) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'goals.db');
    final database = await openDatabase(path);

    await database.rawUpdate('UPDATE Goals SET isCompleted = ? WHERE id = ?', [
      isCompleted ? 1 : 0,
      id,
    ]);

    await getDataFormDataBase();
    await database.close();
  }

}

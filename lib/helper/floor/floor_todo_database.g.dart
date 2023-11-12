// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_todo_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFloorToDoDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorToDoDatabaseBuilder databaseBuilder(String name) =>
      _$FloorToDoDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorToDoDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FloorToDoDatabaseBuilder(null);
}

class _$FloorToDoDatabaseBuilder {
  _$FloorToDoDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FloorToDoDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FloorToDoDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FloorToDoDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FloorToDoDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FloorToDoDatabase extends FloorToDoDatabase {
  _$FloorToDoDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `todo_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _todoEntityInsertionAdapter = InsertionAdapter(
            database,
            'todo_table',
            (TodoEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                }),
        _todoEntityUpdateAdapter = UpdateAdapter(
            database,
            'todo_table',
            ['id'],
            (TodoEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                }),
        _todoEntityDeletionAdapter = DeletionAdapter(
            database,
            'todo_table',
            ['id'],
            (TodoEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TodoEntity> _todoEntityInsertionAdapter;

  final UpdateAdapter<TodoEntity> _todoEntityUpdateAdapter;

  final DeletionAdapter<TodoEntity> _todoEntityDeletionAdapter;

  @override
  Future<List<TodoEntity>> findAllTodos() async {
    return _queryAdapter.queryList('SELECT * FROM todo_table',
        mapper: (Map<String, Object?> row) => TodoEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String));
  }

  @override
  Future<void> insertTodo(TodoEntity todoEntity) async {
    await _todoEntityInsertionAdapter.insert(
        todoEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTodo(TodoEntity todoEntity) async {
    await _todoEntityUpdateAdapter.update(todoEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTodo(TodoEntity todoEntity) async {
    await _todoEntityDeletionAdapter.delete(todoEntity);
  }
}

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// await getDatabasesPath()
//
void dbHelper() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  print(await getDatabasesPath());
  final database = await openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    //print(await getDatabasesPath());
    join(await getDatabasesPath(), 'taskly_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        '''
          CREATE TABLE `Task` (
            `id` text PRIMARY KEY,
            `title` text,
            `rich_description` text COMMENT 'JSON/MD format',
            `createdAt` datetime,
            `beginAt` datetime,
            `endAt` datetime,
            `repeat` boolean DEFAULT false,
            `priority` int DEFAULT 4,
            `isCompleted` boolean DEFAULT false,
            `projectId` text,
            `isVisible` boolean DEFAULT true
          );

          CREATE TABLE `Project` (
            `id` text PRIMARY KEY,
            `title` text,
            `description` text,
            `createdAt` datetime,
            `isVisible` boolean DEFAULT true
          );

          CREATE TABLE `Tag` (
            `id` text PRIMARY KEY,
            `title` text,
            `color` text COMMENT 'Hexadecimal format',
            `isVisible` boolean DEFAULT true
          );

          CREATE TABLE `TaggedTask` (
            `taskId` text,
            `tagId` text
          );

          CREATE TABLE `RepeatedTask` (
            `id` text PRIMARY KEY,
            `taskId` text,
            `interval` int,
            `weekDay` text COMMENT 'An array, weekdays separated by comma',
            `nextDueDate` datetime COMMENT 'When the task is completed, update this field'
          );

          CREATE TABLE `Reminder` (
            `id` text PRIMARY KEY,
            `taskId` text,
            `time` datetime
          );

          ALTER TABLE `Task` ADD FOREIGN KEY (`projectId`) REFERENCES `Project` (`id`);

          ALTER TABLE `TaggedTask` ADD FOREIGN KEY (`taskId`) REFERENCES `Task` (`id`);

          ALTER TABLE `TaggedTask` ADD FOREIGN KEY (`tagId`) REFERENCES `Tag` (`id`);

          ALTER TABLE `RepeatedTask` ADD FOREIGN KEY (`taskId`) REFERENCES `Task` (`id`);

          ALTER TABLE `Reminder` ADD FOREIGN KEY (`taskId`) REFERENCES `Task` (`id`);
        ''',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insertTask(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Dog>> dogs() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table
  var fido = const Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  await insertTask(fido);

  // Now, use the method above to retrieve all the dogs.
  print(await dogs()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );
  await updateDog(fido);

  // Print the updated results.
  print(await dogs()); // Prints Fido with age 42.

  // Delete Fido from the database.
  await deleteDog(fido.id);

  // Print the list of dogs (empty).
  print(await dogs());
}

class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

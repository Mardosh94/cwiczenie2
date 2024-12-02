import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp()); // Uruchamia aplikację Fluttera i przekazuje do niej widget ToDoApp jako główny komponent.
}

class ToDoApp extends StatelessWidget { // Klasa ToDoApp dziedziczy po StatelessWidget, ponieważ jej stan się nie zmienia.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // MaterialApp to główny kontener aplikacji, który dostarcza podstawowe funkcje Flutter Material Design.
      debugShowCheckedModeBanner: false, // Usuwa etykietę "debug" z rogu ekranu podczas uruchamiania aplikacji w trybie debugowania.
      title: 'To-Do List', // Tytuł aplikacji, który można wykorzystać w systemie operacyjnym.
      theme: ThemeData(
        primarySwatch: Colors.green, // Ustawia główny kolor aplikacji
      ),
      home: ToDoListPage(), // Określa pierwszą stronę aplikacji, którą jest widget ToDoListPage.
    );
  }
}

class ToDoListPage extends StatefulWidget { // StatefulWidget, ponieważ aplikacja zarządza dynamicznym stanem (listą zadań).
  @override
  _ToDoListPageState createState() => _ToDoListPageState(); // Tworzy obiekt stanu dla tego widgetu.
}

class _ToDoListPageState extends State<ToDoListPage> {
  final List<Map<String, dynamic>> _tasks = []; // Lista zadań, każde zadanie jest mapą z kluczami 'title' i 'isCompleted'.
  final TextEditingController _taskController = TextEditingController(); // Kontroler tekstowy do zarządzania tekstem wpisanym w TextField.

  void _addTask(String title) { // Funkcja do dodawania nowego zadania.
    if (title.isNotEmpty) { // Sprawdza, czy tytuł nie jest pusty.
      setState(() { // Aktualizuje stan aplikacji.
        _tasks.add({
          'title': title, // Dodaje tytuł zadania.
          'isCompleted': false, // Ustawia zadanie jako nieukończone.
        });
      });
      _taskController.clear(); // Czyści pole tekstowe po dodaniu zadania.
    }
  }

  void _removeTask(int index) { // Funkcja do usuwania zadania na podstawie jego indeksu.
    setState(() { // Aktualizuje stan aplikacji.
      _tasks.removeAt(index); // Usuwa zadanie z listy.
    });
  }

  void _toggleTaskCompletion(int index) { // Funkcja do przełączania statusu ukończenia zadania.
    setState(() { // Aktualizuje stan aplikacji.
      _tasks[index]['isCompleted'] = !_tasks[index]['isCompleted']; // Przełącza wartość klucza 'isCompleted'.
    });
  }

  @override
  Widget build(BuildContext context) { // Buduje interfejs użytkownika dla tej strony.
    return Scaffold( // Scaffold to podstawowy layout dla strony aplikacji z paskiem aplikacji i ciałem strony.
      appBar: AppBar(
        title: Text('Aplikacja To-Do'), // Tytuł paska aplikacji.
      ),
      body: Padding( // Padding dodaje odstępy wokół zawartości strony.
        padding: const EdgeInsets.all(16.0),
        child: Column( // Układ pionowy dla elementów strony.
          children: [
            Row( // Układ poziomy dla pola tekstowego i przycisku.
              children: [
                Expanded(
                  child: TextField( // Pole tekstowe do wpisywania nowych zadań.
                    controller: _taskController, // Kontroler tekstowy do zarządzania wprowadzanym tekstem.
                    decoration: InputDecoration(
                      labelText: 'Nowe zadanie', // Etykieta dla pola tekstowego.
                      border: OutlineInputBorder(), // Obrys wokół pola tekstowego.
                    ),
                  ),
                ),
                SizedBox(width: 8.0), // Odstęp między polem tekstowym a przyciskiem.
                ElevatedButton(
                  onPressed: () => _addTask(_taskController.text), // Dodaje zadanie po kliknięciu przycisku.
                  child: Text('Dodaj'), // Tekst na przycisku.
                ),
              ],
            ),
            SizedBox(height: 16.0), // Odstęp między wierszem a listą zadań.
            Expanded( // Rozciąga listę zadań, aby zajęła dostępną przestrzeń.
              child: ListView.builder( // Tworzy listę przewijalnych elementów.
                itemCount: _tasks.length, // Liczba elementów na liście.
                itemBuilder: (context, index) { // Buduje każdy element listy.
                  final task = _tasks[index]; // Pobiera dane zadania na danym indeksie.
                  return ListTile( // Reprezentuje jeden element listy.
                    leading: IconButton( // Ikona przed tytułem zadania.
                      icon: Icon(
                        task['isCompleted']
                            ? Icons.check_box // Checkbox zaznaczony, jeśli zadanie ukończone.
                            : Icons.check_box_outline_blank, // Checkbox niezaznaczony, jeśli zadanie nieukończone.
                      ),
                      onPressed: () => _toggleTaskCompletion(index), // Przełącza status ukończenia zadania.
                    ),
                    title: Text(
                      task['title'], // Wyświetla tytuł zadania.
                      style: TextStyle(
                        decoration: task['isCompleted']
                            ? TextDecoration.lineThrough // Przekreśla tekst, jeśli zadanie ukończone.
                            : TextDecoration.none, // Brak przekreślenia, jeśli zadanie nieukończone.
                      ),
                    ),
                    trailing: IconButton( // Ikona do usuwania zadania.
                      icon: Icon(Icons.delete, color: Colors.red), // Ikona kosza na śmieci w kolorze czerwonym.
                      onPressed: () => _removeTask(index), // Usuwa zadanie po kliknięciu.
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

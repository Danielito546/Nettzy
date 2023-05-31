import 'package:flutter/material.dart';
import 'package:nettzy/models/note.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas y Lista de Verificación'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Dismissible(
                  key: Key(note.title),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      notes.removeAt(index);
                    });
                  },
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: Card(
                    elevation: 2.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: ListTile(
                      title: Text(
                        note.title,
                        style: TextStyle(
                          decoration: note.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: note.completed ? Colors.grey : Colors.black,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.content,
                            style: TextStyle(
                              decoration: note.completed
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color:
                                  note.completed ? Colors.grey : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Fecha de inicio: ${note.startDate}',
                            style: TextStyle(
                              decoration: note.completed
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color:
                                  note.completed ? Colors.grey : Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Fecha de fin: ${note.endDate}',
                            style: TextStyle(
                              decoration: note.completed
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color:
                                  note.completed ? Colors.grey : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      trailing: Checkbox(
                        value: note.completed,
                        onChanged: (value) {
                          setState(() {
                            note.completed = value ?? false;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                _showAddNoteDialog();
              },
              icon: Icon(Icons.add),
              label: Text('Agregar nota o elemento'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String content = '';
        DateTime startDate = DateTime.now();
        DateTime endDate = DateTime.now().add(Duration(days: 1));

        return AlertDialog(
          title: Text('Agregar nota o elemento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Contenido'),
                onChanged: (value) {
                  content = value;
                },
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  //Text('Fecha de inicio: ${DateFormat('dd/MM/yyyy').format(startDate)}'),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2025),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          startDate = selectedDate;
                        });
                      }
                    },
                    child: Text('Seleccionar fecha de inicio'),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  //Text('Fecha de fin: ${DateFormat('dd/MM/yyyy').format(endDate)}'),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: endDate,
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2025),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          endDate = selectedDate;
                        });
                      }
                    },
                    child: Text('Seleccionar fecha de fin'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && content.isNotEmpty) {
                  setState(() {
                    notes.add(Note(
                      title: title,
                      content: content,
                      completed: false,
                      startDate: startDate,
                      endDate: endDate,
                    ));
                  });
                }

                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}

String _formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}


import 'package:a02_todo_app/a04_todo_function.dart';
import 'package:flutter/material.dart';
import 'a02_colors.dart';

class A03_ToDo_Item extends StatelessWidget {

  final A04_ToDo_Function todo;
  final onToDoChanged;
  final onDeleteItem;

  const A03_ToDo_Item({Key? key, required this.todo, required this.onToDoChanged, required this.onDeleteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: (){
          debugPrint('Clicked..');
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank, color: blueColor,),
        title: Text(
          todo.todoText!,
          style: TextStyle(fontSize: 18, color: blackColor, decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.delete),
            iconSize: 18,
            onPressed: (){
              onDeleteItem(todo.id);
              debugPrint('deleted..');
            },
          ),
        ),
      ),
    );
  }
}


import 'package:a02_todo_app/a02_colors.dart';
import 'package:a02_todo_app/a03_todo_item.dart';
import 'package:a02_todo_app/a04_todo_function.dart';
import 'package:flutter/material.dart';

class A01_ToDo extends StatefulWidget {
  const A01_ToDo({Key? key}) : super(key: key);

  @override
  State<A01_ToDo> createState() => _A01_ToDoState();
}

class _A01_ToDoState extends State<A01_ToDo> {

  final todoList = A04_ToDo_Function.todoList();
  List<A04_ToDo_Function> _foundToDo = [];
  final _todoController = TextEditingController();
  
  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,),
            color: whiteColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 35, bottom: 20),
                          child: const Text('All Lists', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
                        ),
                        for(A04_ToDo_Function todoo in _foundToDo)
                          A03_ToDo_Item(todo: todoo, onToDoChanged: _handleToDoChange, onDeleteItem: _deleteToDoItem,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [BoxShadow(
                        color: Colors.grey, 
                        offset: Offset(0.0, 0.0),
                      )],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: 'Add a new Item',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: (){
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      minimumSize: const Size(60, 60),
                      elevation: 10
                    ),
                    child: const Text('+', style: TextStyle(fontSize: 40),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  AppBar _appbar(){
    return AppBar(
      backgroundColor: whiteColor,
      elevation: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.menu, color: blackColor, size: 35,),
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: SizedBox(
              height: 35,
              width: 35,
              child: Icon(Icons.person, color: blackColor, size: 35,),
            ),
          )
        ],
      ),
    );
  }


  Widget searchBox(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: blackColor, size: 30,),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(fontSize: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 25, minWidth: 40),
        ),
      ),
    );
  }
  
  void _runFilter(String enteredKeyword) {
    List<A04_ToDo_Function> results = [];
    if(enteredKeyword.isEmpty) {
      results = todoList;
    }
    else{
      results = todoList.where((element) => element.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }


  void _addToDoItem(String toDo){
    setState(() {
      todoList.add(A04_ToDo_Function(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
    });
    _todoController.clear();
  }

  void _handleToDoChange(A04_ToDo_Function todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id){
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

}

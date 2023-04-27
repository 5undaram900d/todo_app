
class A04_ToDo_Function {
  String? id;
  String? todoText;
  bool isDone;

  A04_ToDo_Function({required this.id, required this.todoText, this.isDone=false});

  static List<A04_ToDo_Function> todoList(){
    return [
      A04_ToDo_Function(id: '01', todoText: 'How are you'),
    ];
  }

}
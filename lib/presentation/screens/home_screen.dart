import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/presentation/provider/providers.dart';

import '../widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(todosProvider.notifier).loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    final titleTodoFilter = ref.watch(titleTodosStatusProvider);
    // final todos = ref.watch(todosProvider);
    final todos = ref.watch(filteredTodosProvider);

    final completedCounter = ref.watch(completedcounterProvider);
    final pendingCounter = ref.watch(pendingcounterProvider);
    final remindersCounter = ref.watch(reminderscounterProvider);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // WELCOME CARD
            WelcomeCard(
              pendingCounter: pendingCounter,
              completedCounter: completedCounter,
              remindersCounter: remindersCounter,
            ),

            // TODOS TITLE FILTER
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
              child: Text(
                '$titleTodoFilter tasks',
                style: GoogleFonts.roboto(
                  color: const Color(0xff8C8C8C),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //  TODOS LISTVIEW
            Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  physics: const BouncingScrollPhysics(),
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final todo = todos[index];
                    return TodoWidget(
                      id: todo.id,
                      description: todo.description,
                      completed: todo.completed,
                      onTapCheckBox: () {
                        ref.read(todosProvider.notifier).toggleTodo(todo.id);
                      },
                      onTapDelete: () {
                        ref.read(todosProvider.notifier).deleteTodo(todo.id);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // newTodoAlert(context);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return CustomdialogNewTodo(
                onPressedCreate: () {
                  final dscrNewTodo = ref.read(dscNewTodoProvider);
                  if (dscrNewTodo.isNotEmpty) {
                    ref.read(todosProvider.notifier).addTodo(description: dscrNewTodo);
                    ref.read(dscNewTodoProvider.notifier).update((state) => '');
                    ref.read(todoStatusFilterProvider.notifier).update((state) => 0);
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/tasks/presentation/provider/tasks_counter_providers.dart';
import 'package:todo_app/features/tasks/presentation/provider/todos_provider.dart';
import 'package:todo_app/features/tasks/presentation/widgets/custom_botton_navbar.dart';
import 'package:todo_app/features/tasks/presentation/widgets/custom_dialog_newtodo.dart';
import 'package:todo_app/features/tasks/presentation/widgets/todo_widget.dart';
import 'package:todo_app/features/tasks/presentation/widgets/welcome_card.dart';

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
    final todos = ref.watch(filteredTodosProvider);

    final completedCounter = ref.watch(completedCounterProvider);
    final pendingCounter = ref.watch(pendingCounterProvider);
    final remindersCounter = ref.watch(remindersCounterProvider);
    final currentFilter = ref.watch(selectedFilterTodoProvider);

    final tasksTitleGroup = switch (currentFilter) {
      TodoFilter.all => 'All tasks',
      TodoFilter.completed => 'Completed tasks',
      TodoFilter.pending => 'Pending tasks',
      TodoFilter.reminders => 'Reminders tasks',
    };

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
                tasksTitleGroup,
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
              return CustomDialogNewTodo(
                onPressedCreate: () {
                  final newTodo = ref.read(newTodoProvider);
                  if (newTodo.isNotEmpty) {
                    ref
                        .read(todosProvider.notifier)
                        .addTodo(description: newTodo);
                    ref.read(newTodoProvider.notifier).update((state) => '');
                    ref
                        .read(selectedFilterTodoProvider.notifier)
                        .update((state) => TodoFilter.all);
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

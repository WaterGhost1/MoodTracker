import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/dependency_injection.dart';
import 'package:mood_tracker/features/mood_entry/presentation/bloc/mood_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<MoodBloc>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    context.read<MoodBloc>().add(MoodChanged(date: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoodBloc, MoodState>(
      listener: (context, state) {
        if (state is MoodSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.currentMoodsInADay!.moodsList.length.toString(),
              ),
            ),
          );
        }
        if (state is MoodFailed) {
          print(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(label: Text("Emotion")),
              ),
              TextFormField(
                controller: descController,
                decoration: InputDecoration(label: Text("Journal")),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<MoodBloc>().add(
                    MoodAdded(
                      name: nameController.text,
                      date: DateTime.now(),
                      time: DateTime.now(),
                      description: descController.text,
                    ),
                  );
                },
                child: Text("Add"),
              ),

              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: state.currentMoodsInADay?.moodsList.length,
                  itemBuilder: (context, index) {
                    Mood? mood = state.currentMoodsInADay?.moodsList[index];

                    if (state.currentMoodsInADay!.moodsList.isEmpty) {
                      return (Text("No data"));
                    } else {
                      return ListTile(title: Text(mood!.name));
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

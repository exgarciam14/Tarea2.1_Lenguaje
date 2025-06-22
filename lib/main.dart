import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



void main() async {
WidgetsFlutterBinding.ensureInitialized();

  // Codigo para bloquear orientación en dispositivos moviles, ya que no veo conveniente tener esta pantalla en modo horizontal.
  // tomado de este foto de stack over flow https://stackoverflow.com/questions/49418332/flutter-how-to-prevent-device-orientation-changes-and-force-portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(TareaFlutter());
}

class TareaFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatelessWidget {
  final List<variables> options = [
    variables(
      icon: Icons.flash_on,
      color: Colors.green,
      title: 'Quick Creation',
      description:'Simply type in your list, ask Siri, or add a reminder from your Calendar app.',
    ),
    variables(
      icon: Icons.add_shopping_cart,
      color: Colors.orange,
      title: 'Grocery Shopping',
      description:'Create a Grocery List that automatically sorts items you add by category.',
    ),
    variables(
      icon: Icons.group,
      color: Colors.amber,
      title: 'Easy Sharing',
      description:'Collaborate on a list, and even assign individual tasks.',
    ),
    variables(
      icon: Icons.assignment_turned_in,
      color: Colors.blue,
      title: 'Powerful Organization',
      description:'Create new lists to match your needs, categorize reminders with tags, and manage reminders around your workflow with Smart Lists.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                'Welcome to\nReminders',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 32),
            //Con la lista de las opciones creadas se las pasamos por medio de listViewBuilder al DrawerOptions
            // Uso del expanded para encapsular el ListView por la excepción de Flutter: RenderBox was not laid out
            // Fix encontrado en el sigeuiente Link https://stackoverflow.com/questions/52801201/flutter-renderbox-was-not-laid-out#:~:text=You%20can%20Always%20resolve%20this%20error%20in,your%20listView%20this%20line:%20shrinkWrap:%20true%20%2C
            Expanded(
              child:  ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return DrawerOptions(option: option);
                },
              ),
            ),
            SizedBox(height: 32),
            //Boton de Continue 
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Continue",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Clase para crear cada fila con su icono.
class DrawerOptions extends StatelessWidget {
  final variables option;

  const DrawerOptions({required this.option});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(option.icon, color: option.color, size: 45),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  option.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  option.description,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//creando variables
class variables {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  variables({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });
}

# Sustainify

Developed in Flutter by Amy Stell, Owen Saunders and Kornel Bartha

## To run

To install the dependancies, first run
```bash
flutter pub get
```

Then to run the application run
```bash
flutter run
```
## Things to bear in mind when developing

### Theming

ALL TextStyles, InputStyles, Colors etc. must be stored in ThemeData, so that we can easily change the theme in the future.

Here's an example with a Text widget:

```dart
Text("Hello", style: Theme.of(context).textTheme.bodyText1)
```

And a color:

```dart
Container(width: 100.0, height: 100.0, color: Theme.of(context).colors.green)
```


### State management (Provider)

This is a tough one for beginners, and I apologise. Unfortunately, this is actually one of the easiest ways to handle state in Flutter. Here are the steps to getting your page UI able to handle state changes:

Firstly, create your state class. This must extend the ChangeNotifier class:

```dart
class ExampleState extends ChangeNotifier {
  String example = "example";
  int exampleNumber = 1;

  void increment() {
    exampleNumber += 1;
    notifyListeners(); //This tells the UI to update!
  }
}
```

These are the Strings and methods which will be accessible from your UI.

Next, create your Provider widget (inside the /providers folder) using this template. You'll have to change the name of the Provider ("ExampleProvider") and the state object ("ExampleState"). Note that this widget takes a child and passes it below itself in the widget tree:

```dart
class ExampleProvider extends StatelessWidget {
  final Widget child;

  ExampleProvider({Key key, this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExampleState>(
      create: (_) => ExampleState(),
      child: child,
    );
  }
}
```

Next, you must wrap your page in your Provider widget. This should be in a separate file. This "provides" the state to your page. Wherever you create "ExamplePage()", it must become:

```dart
ExampleProvider(child: ExamplePage())
```

Finally, you must wrap the inside of your page with a BaseWidget. This is a custom widget which you can find in /widgets, and it's basically a glorified Consumer(). This consumes the state in a nice way which your UI can use.

```dart
@override
  Widget build(BuildContext context) {
    return BaseWidget<ExampleState>(
          state: Provider.of<ExampleState>(context),
          builder: (context, state, child) {
            return Center(
              child: . . . 
```

You should now be able to, using your new "state" variable, access your state like so:

```dart
Text(state.exampleString)
```

Remember! If you want your state to update your UI with new data, simply call:

```dart
notifyListeners();
```

## Folder Structure

* /models - Object constructors, serialisation
* /pages - Full pages of the app
* /providers - Provider classes
* /services - Classes which contain HTTP methods
* /state - State classes
* /theme - Theme stuff
* /widgets - Small components

## Dependencies

You can find the project's dependencies in the pubspec.yaml file, under "dependencies"

## State Management

This project uses Provider (https://pub.dev/packages/provider) for state management




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_budget/utils/theme_bloc.dart';

enum AuthState {
  EXISTING,
  NEW,
}

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  AuthState _state = AuthState.EXISTING;
  AnimationController _authStateAnimationController;
  Animation _existingTextColorTween;
  Animation _newTextColorTween;
  Animation _sliderAnimation;

  @override
  void initState() {
    _authStateAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 150,
      ),
    );

    _existingTextColorTween = ColorTween(
      begin: Colors.black,
      end: Colors.white,
    ).animate(_authStateAnimationController);

    _newTextColorTween = ColorTween(
      begin: Colors.white,
      end: Colors.black,
    ).animate(_authStateAnimationController);

    _sliderAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(_authStateAnimationController);
    super.initState();
  }

  Widget _buildBackground(List<Color> gradientColors) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.topRight,
          begin: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: double.infinity,
        height: this._state == AuthState.EXISTING ? 195 : 255,
        constraints: BoxConstraints(
            minHeight: this._state == AuthState.EXISTING ? 195 : 255),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20.0,
            0.0,
            20.0,
            60.0,
          ),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffix: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  if (this._state == AuthState.NEW)
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(Color color) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3)],
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Center(
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(double width) {
    return AnimatedBuilder(
      animation: _sliderAnimation,
      builder: (context, _) => Stack(
        alignment: _sliderAnimation.value,
        children: <Widget>[
          Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black87.withOpacity(0.3),
                  Colors.black87.withOpacity(0.4)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: width / 2,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    this._state = AuthState.EXISTING;
                    _authStateAnimationController.reverse();
                  });
                },
                child: SizedBox(
                  width: width / 2,
                  height: 50,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _existingTextColorTween,
                      builder: (context, _) => Text(
                        'Existing',
                        style: TextStyle(
                          color: _existingTextColorTween.value,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    this._state = AuthState.NEW;
                    _authStateAnimationController.forward();
                  });
                },
                child: SizedBox(
                  width: width / 2,
                  height: 50,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _newTextColorTween,
                      builder: (context, _) => Text(
                        'New',
                        style: TextStyle(
                          color: _newTextColorTween.value,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);

    return Scaffold(
      body: BlocBuilder<ThemeBloc, ThemeData>(
        bloc: themeBloc,
        builder: (context, theme) => Stack(
          children: <Widget>[
            _buildBackground([theme.primaryColor, theme.primaryColorLight]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildSlider(MediaQuery.of(context).size.width - 80.0),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          child: _buildForm(),
                        ),
                        Positioned(
                          bottom: -25,
                          child: _buildButton(theme.accentColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

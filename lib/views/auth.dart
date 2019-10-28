import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_budget/strings.dart';
import 'package:time_budget/utils/auth_mode.dart';
import 'package:time_budget/utils/theme_bloc.dart';
import 'package:time_budget/viewmodels/bloc.dart';
import 'package:time_budget/views/main.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  AuthBloc _authBloc;
  ThemeBloc _themeBloc;

  AnimationController _authStateAnimationController;
  Animation _existingTextColorTween;
  Animation _newTextColorTween;
  Animation _sliderAnimation;

  AnimationController _buttonAnimationController;
  Animation _buttonSizeAnimation;
  DecorationTween _buttonDecorationAnimation;

  final FocusNode _passwordTextFieldFocusNode = FocusNode();
  final FocusNode _emailTextFieldFocusNode = FocusNode();

  AuthMode _authMode = AuthMode.LOGIN;

  bool _passwordVisible = false;
  bool _formHasErrors = false;
  bool _showLoadingIndicator = false;

  Map<String, String> _formData = {
    'username': null,
    'password': null,
    'email': null,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);

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

    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 250,
      ),
    );

    _buttonSizeAnimation = SizeTween(
      begin: Size(250, 50),
      end: Size(50, 50),
    ).animate(_buttonAnimationController)
      ..addListener(() {
        if (_buttonAnimationController.isCompleted) {
          setState(() {
            this._showLoadingIndicator = true;
          });
        }
      });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _buttonDecorationAnimation = DecorationTween(
      begin: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3)],
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).accentColor,
        border: Border.fromBorderSide(
          BorderSide(
            color: Theme.of(context).accentColor,
            width: 3,
          ),
        ),
      ),
      end: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 3)],
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).primaryColorLight,
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.white.withOpacity(0.4),
            width: 3,
          ),
        ),
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _authBloc.close();
    _themeBloc.close();
    _authStateAnimationController.dispose();
    _buttonAnimationController.dispose();
    _passwordTextFieldFocusNode.dispose();
    _emailTextFieldFocusNode.dispose();
    super.dispose();
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

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Time',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        Text(
          'Budget',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
      ],
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
                  Colors.grey[700].withOpacity(0.2),
                  Colors.grey[600].withOpacity(0.4)
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
                    this._authMode = AuthMode.LOGIN;
                  });
                  _authStateAnimationController.reverse();
                },
                child: SizedBox(
                  width: width / 2,
                  height: 50,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _existingTextColorTween,
                      builder: (context, _) => Text(
                        Strings.login,
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
                    this._authMode = AuthMode.SIGNUP;
                  });
                  _authStateAnimationController.forward();
                },
                child: SizedBox(
                  width: width / 2,
                  height: 50,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _newTextColorTween,
                      builder: (context, _) => Text(
                        Strings.signUp,
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

  Widget _buildForm(AuthState state) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: double.infinity,
        height: this._authMode == AuthMode.LOGIN
            ? (this._formHasErrors ? 250 : 195)
            : (this._formHasErrors ? 310 : 255),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20.0,
            0.0,
            20.0,
            60.0,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(_passwordTextFieldFocusNode),
                    validator: (value) {
                      return value.isEmpty
                          ? 'Username must not be empty'
                          : null;
                    },
                    onSaved: (value) {
                      _formData['username'] = value;
                    },
                  ),
                  TextFormField(
                    focusNode: _passwordTextFieldFocusNode,
                    obscureText: !this._passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            this._passwordVisible = !this._passwordVisible;
                          });
                        },
                        child: Icon(
                          this._passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    textInputAction: this._authMode == AuthMode.LOGIN
                        ? TextInputAction.done
                        : TextInputAction.next,
                    onFieldSubmitted: (_) => this._authMode == AuthMode.SIGNUP
                        ? FocusScope.of(context)
                            .requestFocus(_emailTextFieldFocusNode)
                        : {},
                    validator: (value) {
                      return value.isEmpty
                          ? 'Password must not be empty'
                          : null;
                    },
                    onSaved: (value) {
                      _formData['password'] = value;
                    },
                  ),
                  if (this._authMode == AuthMode.SIGNUP)
                    TextFormField(
                      focusNode: _emailTextFieldFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        return value.isEmpty ? 'Email must not be empty' : null;
                      },
                      onSaved: (value) {
                        _formData['email'] = value;
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(Color color, Color splashColor, AuthState state) {
    String buttonText;
    if (this._authMode == AuthMode.LOGIN) {
      buttonText = Strings.login;
    } else {
      buttonText = Strings.signUp;
    }
    return Stack(
      children: <Widget>[
        AnimatedBuilder(
          animation: _buttonSizeAnimation,
          builder: (context, _) => Container(
            height: _buttonSizeAnimation.value.height,
            width: _buttonSizeAnimation.value.width,
            decoration: _buttonDecorationAnimation.lerp(
              _buttonAnimationController.value,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: splashColor,
                onTap: () {
                  this._formHasErrors = !_formKey.currentState.validate();
                  if (this._formHasErrors) {
                    setState(() {});
                  }

                  if (!this._formHasErrors) {
                    _buttonAnimationController.forward();
                    _formKey.currentState.save();
                    _authBloc.add(
                      AuthenticateAuthEvent(
                        authMode: this._authMode,
                        data: _formData,
                      ),
                    );
                  }
                },
                child: Center(
                  child: Text(
                    _buttonSizeAnimation.value.width > 180 ? buttonText : '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (this._showLoadingIndicator)
          SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColorDark,
              ),
              strokeWidth: 5,
            ),
          ),
      ],
    );
  }

  Widget _buildPageContent(ThemeData theme, AuthState state) {
    return Stack(
      children: <Widget>[
        _buildBackground([theme.primaryColorLight, theme.primaryColor]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                _buildTitle(),
                SizedBox(
                  height: 40,
                ),
                _buildSlider(MediaQuery.of(context).size.width - 80.0),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.center,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      child: _buildForm(state),
                    ),
                    Positioned(
                      bottom: -25,
                      child: _buildButton(
                        theme.accentColor,
                        theme.primaryColor,
                        state,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: BlocListener<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is AuthenticatedAuthState) {
              _buttonAnimationController.reverse();
              this._showLoadingIndicator = false;
              // TODO TEMPORARY
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MainView(),
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            bloc: _authBloc,
            builder: (context, state) =>
                _buildPageContent(Theme.of(context), state),
          ),
        ),
      ),
    );
  }
}

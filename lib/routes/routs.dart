import 'package:go_router/go_router.dart';
import 'package:spotify/routes/routs_name.dart';
import '../presentation/screens/music/home.dart';
import '../presentation/screens/user/Register.dart';
import '../presentation/screens/user/RegisterOrSingUp.dart';
import '../presentation/screens/user/SingIn.dart';




final GoRouter router = GoRouter(
  initialLocation: "/RegisterOrSingUp",
  routes: [
    GoRoute(
      name: RouteName.RegisterOrSingUp,
      path: "/RegisterOrSingUp",
      builder: (context, state) => RegisterOrSingUp(),
    ),
    GoRoute(
      name: RouteName.SingIn,
      path: "/SingIn",
      builder: (context, state) => SingIn(onTap: () {  },),
    ),
    GoRoute(
      name: RouteName.Register,
      path: "/Register",
      builder: (context, state) => Register(onTap: () {  },),
    ),
    GoRoute(
      name: RouteName.Home,
      path: "/Home",
      builder: (context, state) => Home(),
    ),
  ],
);
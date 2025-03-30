import 'package:go_router/go_router.dart';
import 'package:spotify/routes/routs_name.dart';
import '../presentation/screens/splash/getStarter.dart';
import '../presentation/screens/splash/loading.dart';
import '../presentation/screens/user/Register.dart';
import '../presentation/screens/user/RegisterOrSingUp.dart';
import '../presentation/screens/user/SingIn.dart';
import '../presentation/screens/splash/chooseMode.dart';
import '../presentation/widgets/nav.dart';




final GoRouter router = GoRouter(
  initialLocation: "/Loading",
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
      name: RouteName.mainHome,
      path: "/MainScreen",
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      name: RouteName.Loading,
      path: "/Loading",
      builder: (context, state) => Loading(),
    ),
    GoRoute(
      name: RouteName.GetStarter,
      path: "/GetStarter",
      builder: (context, state) => GetStarter(),
    ),
    GoRoute(
      name: RouteName.Choosemode,
      path: "/${RouteName.Choosemode}",
      builder: (context, state) => Choosemode(),
    ),
  ],
);
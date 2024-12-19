import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/widgets/main_page.dart';
// import 'package:get/get.dart';

import '../modules/auth/auth_module.dart';
import '../modules/home/home_module.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        initialLocation: '/login',
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) {
              LoginBinding().dependencies();
              return const Login();
            },
          ),
          //使用shellroute 保持父级布局
          ShellRoute(
              builder: (context, state, child) {
                return MainPage(child: child);
              },
              routes: [
                GoRoute(
                  path: '/home',
                  builder: (context, state) {
                    HomeBinding().dependencies();
                    return const Home();
                  },
                ),
              ]),
        ],
        //全局路由守卫
        redirect: (context, state) {
          const isLoggedIn = false;
          if (!isLoggedIn && state.path != '/login') {
            return '/login';
          }
          return null;
        },
      );
}

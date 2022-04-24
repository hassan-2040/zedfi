part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class EmailAuth extends AuthState {}

class PhoneAuth extends AuthState {}

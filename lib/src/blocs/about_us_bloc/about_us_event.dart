part of 'about_us_bloc.dart';

abstract class AboutUsEvent extends Equatable {
  const AboutUsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class FetchAboutItemEvent extends AboutUsEvent {

}

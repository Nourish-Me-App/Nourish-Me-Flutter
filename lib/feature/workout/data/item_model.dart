class ItemModel {
  String? name;
  String? image;
  String? time;
  ItemModel({this.name, this.image, this.time});
}

List<ItemModel> item = [
  ItemModel(
      name: 'Mountain Climbers',
      image: 'assets/images/mountainclimbers.png',
      time: '60:30 sec'),
  ItemModel(
      name: 'Jumping Jacks',
      image: 'assets/images/High Knees.png',
      time: '60:30 sec'),
  ItemModel(
      name: 'Burpees', image: 'assets/images/Burpees.png', time: '60:30 sec'),
  ItemModel(
      name: 'Squat jumps',
      image: 'assets/images/Butt kicks.png',
      time: '60:30 sec'),
  ItemModel(
      name: 'High Knees',
      image: 'assets/images/High Knees.png',
      time: '60:30 sec'),
  ItemModel(
      name: 'Butt kicks',
      image: 'assets/images/Jumping jacks.png',
      time: '60:30 sec'),
  ItemModel(
      name: 'Trunk rotation',
      image: 'assets/images/Squat jumps.png',
      time: '60:30 sec'),
  ItemModel(
      name: 'Jumping jacks',
      image: 'assets/images/Trunk rotation.png',
      time: '60:30 sec'),
];

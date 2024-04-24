extension ImageAsset on String {
  String get getSvgAsset => 'assets/svgs/$this.svg';
  String get getPngAsset => 'assets/images/$this.png';
}

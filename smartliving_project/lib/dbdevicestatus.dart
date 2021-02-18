class DatabaseDeviceStatus {
  final String email;
  final bool isAirConditionerOn;
  final bool isLightOn;
  final bool isDoorOn;
  final bool isTvOn;

  DatabaseDeviceStatus(
      {this.email,
      this.isAirConditionerOn,
      this.isLightOn,
      this.isDoorOn,
      this.isTvOn});
}

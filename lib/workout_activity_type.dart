/// Equivalent enum to HKWorkoutActivityType in iOS
enum WorkoutActivityType implements Comparable<WorkoutActivityType> {
  unknown(0, 'Unknown'),
  americanFootball(1, 'American Football'),
  archery(2, 'Archery'),
  australianFootball(3, 'Australian Football'),
  badminton(4, 'Badminton'),
  baseball(5, 'Baseball'),
  basketball(6, 'Basketball'),
  bowling(7, 'Bowling'),
  boxing(8, 'Boxing'),
  climbing(9, 'Climbing'),
  cricket(10, 'Cricket'),
  crossTraining(11, 'Cross Training'),
  curling(12, 'Curling'),
  cycling(13, 'Cycling'),
  dance(14, 'Dance'),
  danceInspiredTraining(15, 'Dance Inspired Training'),
  elliptical(16, 'Elliptical'),
  equestrianSports(17, 'Equestrian Sports'),
  fencing(18, 'Fencing'),
  fishing(19, 'Fishing'),
  functionalStrengthTraining(20, 'Functional Strength Training'),
  golf(21, 'Golf'),
  gymnastics(22, 'Gymnastics'),
  handball(23, 'Handball'),
  hiking(24, 'Hiking'),
  hockey(25, 'Hockey'),
  hunting(26, 'Hunting'),
  lacrosse(27, 'Lacrosse'),
  martialArts(28, 'Martial Arts'),
  mindAndBody(29, 'Mind and Body'),
  mixedMetabolicCardioTraining(30, 'Mixed Metabolic Cardio Training'),
  paddleSports(31, 'Paddle Sports'),
  play(32, 'Play'),
  preparationAndRecovery(33, 'Preparation and Recovery'),
  racquetball(34, 'Racquetball'),
  rowing(35, 'Rowing'),
  rugby(36, 'Rugby'),
  running(37, 'Running'),
  sailing(38, 'Sailing'),
  skatingSports(39, 'Skating Sports'),
  snowSports(40, 'Snow Sports'),
  soccer(41, 'Soccer'),
  softball(42, 'Softball'),
  squash(43, 'Squash'),
  stairClimbing(44, 'Stair Climbing'),
  surfingSports(45, 'Surfing Sports'),
  swimming(46, 'Swimming'),
  tableTennis(47, 'Table Tennis'),
  tennis(48, 'Tennis'),
  trackAndField(49, 'Track and Field'),
  traditionalStrengthTraining(50, 'Traditional Strength Training'),
  volleyball(51, 'Volleyball'),
  walking(52, 'Walking'),
  waterFitness(53, 'Water Fitness'),
  waterPolo(54, 'Water Polo'),
  waterSports(55, 'Water Sports'),
  wrestling(56, 'Wrestling'),
  yoga(57, 'Yoga'),
  barre(58, 'Barre'),
  coreTraining(59, 'Core Training'),
  crossCountrySkiing(60, 'Cross Country Skiing'),
  downhillSkiing(61, 'Downhill Skiing'),
  flexibility(62, 'Flexibility'),
  highIntensityIntervalTraining(63, 'High Intensity Interval Training'),
  jumpRope(64, 'Jump Rope'),
  kickboxing(65, 'Kickboxing'),
  pilates(66, 'Pilates'),
  snowboarding(67, 'Snowboarding'),
  stairs(68, 'Stairs'),
  stepTraining(69, 'Step Training'),
  weelchairWalkPace(70, 'Wheelchair Walk Pace'),
  weelchairRunPace(71, 'Wheelchair Run Pace'),
  taiChi(72, 'Tai Chi'),
  mixedCardio(73, 'Mixed Cardio'),
  handCycling(74, 'Hand Cycling'),
  discSports(75, 'Disc Sports'),
  fitnessGaming(76, 'Fitness Gaming'),
  cardioDance(77, 'Cardio Dance'),
  socialDance(78, 'Social Dance'),
  pickleball(79, 'Pickleball'),
  cooldown(80, 'Cooldown'),
  swimBikeRun(82, 'Swim Bike Run'),
  transition(83, 'Transition'),
  underwaterDiving(84, 'Underwater Diving'),
  other(3000, 'Other');

  const WorkoutActivityType(this.value, this.name);

  final int value;
  final String name;

  /// Creats a new instance of [WorkoutActivityType] from a given value.
  factory WorkoutActivityType.fromValue(int value) {
    return WorkoutActivityType.values.firstWhere(
      (activityType) => activityType.value == value,
      orElse: () => WorkoutActivityType.other,
    );
  }

  @override
  String toString() {
    return name;
  }

  @override
  int compareTo(WorkoutActivityType other) {
    return value.compareTo(other.value);
  }
}
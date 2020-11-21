class Event {
  String name;
  String description;
  DateTime eventDate;
  String image;
  String location;
  String organizer;
  num price;

  Event(
      {this.eventDate,
      this.image,
      this.location,
      this.name,
      this.organizer,
      this.price,
      this.description});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      description: json['about'],
      location: json['location'],
      image: json['photo'],
      organizer: json['user']['name'],
      eventDate: DateTime.now().add(const Duration(days: 1)),
      price: 30,
    );
  }
}

final List<Event> upcomingEvents = [
  Event(
    name: "The Pretty Reckless",
    eventDate: DateTime.now().add(const Duration(days: 24)),
    image:
        'https://source.unsplash.com/800x600/?concert', //https://img.freepik.com/free-vector/businessman-profile-cartoon_18591-58479.jpg?size=338&ext=jpg
    description:
        "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "Fairview Gospel Church",
    organizer: "Westfield Centre",
    price: 30,
  ),
  Event(
    name: "Live Orchestra",
    eventDate: DateTime.now().add(const Duration(days: 33)),
    image: 'https://source.unsplash.com/800x600/?band',
    description:
        "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "David Geffen Hall",
    organizer: "Westfield Centre",
    price: 30,
  ),
  Event(
    name: "Local Concert",
    eventDate: DateTime.now().add(const Duration(days: 12)),
    image: 'https://source.unsplash.com/800x600/?music',
    description:
        "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "The Cutting room",
    organizer: "Westfield Centre",
    price: 30,
  ),
];

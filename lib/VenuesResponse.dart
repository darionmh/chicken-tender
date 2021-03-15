class VenuesResponse {
  List<Venue> venues;

  VenuesResponse({this.venues});

  VenuesResponse.fromJson(Map<String, dynamic> json) {
    venues = [];
    if (json['venues'] != null) {
        json['venues'].forEach((v) => {venues.add(new Venue.fromJson(v))});
    }
  }
}

class Venue {
  String id;
  String name;
  Location location;
  List<Category> categories;
  Delivery delivery;
  String referralId;
  bool hasPerk;

  Venue({this.id,
    this.name,
    this.location,
    this.categories,
    this.delivery,
    this.referralId,
    this.hasPerk});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
    if (json['categories'] != null) {
      categories = [];
      json['categories']
          .forEach((c) => {categories.add(new Category.fromJson(c))});
    }
    delivery = json['delivery'] != null ? new Delivery.fromJson(json['delivery']) : null;
    referralId = json['referralId'];
    hasPerk = json['hasPerk'];
  }
}

class Location {
  String address;
  String postalCode;
  String city;
  String state;
  String cc;
  String country;
  int distance;
  double lat;
  double lng;
  List<String> formattedAddress;

  Location({this.address,
    this.postalCode,
    this.city,
    this.state,
    this.cc,
    this.country,
    this.distance,
    this.lat,
    this.lng,
    this.formattedAddress});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    postalCode = json['postalCode'];
    city = json['city'];
    state = json['state'];
    cc = json['cc'];
    country = json['country'];
    distance = json['distance'];
    lat = json['lat'];
    lng = json['lng'];
    if (json['formattedAddress'] != null) {
      formattedAddress = [];
      json['formattedAddress'].forEach((a) => formattedAddress.add(a));
    }
  }
}

class Category {
  String id;
  String name;
  String pluralName;
  String shortName;
  IconData icon;
  bool primary;

  Category({this.id,
    this.name,
    this.pluralName,
    this.shortName,
    this.icon,
    this.primary});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pluralName = json['pluralName'];
    shortName = json['shortName'];
    icon = json['icon'] != null ? new IconData.fromJson(json['icon']) : null;
    primary = json['primary'];
  }
}

class IconData {
  String prefix;
  String suffix;

  IconData({this.prefix, this.suffix});

  IconData.fromJson(Map<String, dynamic> json) {
    prefix = json['prefix'];
    suffix = json['suffix'];
  }
}

class Delivery {
  String id;
  String url;
  DeliveryProvider provider;

  Delivery({this.id, this.url, this.provider});

  Delivery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    provider = json['provider'] != null ? new DeliveryProvider.fromJson(json['provider']) : null;
  }
}

class DeliveryProvider {
  String name;
  DeliveryProviderIconData icon;

  DeliveryProvider({this.name, this.icon});

  DeliveryProvider.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'] != null ? new DeliveryProviderIconData.fromJson(json['icon']) : null;
  }
}

class DeliveryProviderIconData {
  String prefix;
  List<int> sizes;
  String name;

  DeliveryProviderIconData({this.prefix, this.sizes, this.name});

  DeliveryProviderIconData.fromJson(Map<String, dynamic> json) {
    prefix = json['prefix'];
    if (json['sizes'] != null) {
      sizes = [];
      json['sizes'].forEach((s) => sizes.add(s));
    }
    name = json['name'];
  }
}

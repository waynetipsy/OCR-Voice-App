class Note {
  final int? id;
  final String title;
 final String description;
 //final DateTime time;
 
  Note({
   required this.id,
    required  this.title,
   required  this.description,
    //required this.time
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
     // time :json['time']
    );
  }

  Map<String, dynamic> toJson() => {
      'id' : id,
      'title' : title,
      'description' : description,
      //'time' : time,
    };
    
  }


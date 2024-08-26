class UniversityDetailsModel {
  UniversityDetailsModel({
    this.status,
    this.message,
    this.result,
  });

  UniversityDetailsModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  num? status;
  String? message;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    this.id,
    this.name,
    this.universityIcon,
    this.recommended,
    this.description,
    this.images,
    this.videos,
    this.overview,
    this.faq,
    this.ranking,
    this.accommodation,
    this.admission,
  });

  Result.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    universityIcon = json['university_icon'];
    recommended = json['recommended'];
    description = json['description'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    videos = json['videos'] != null ? json['videos'].cast<String>() : [];
    overview = json['overview'] != null ? Overview.fromJson(json['overview']) : null;
    if (json['faq'] != null) {
      faq = [];
      json['faq'].forEach((v) {
        faq?.add(Faq.fromJson(v));
      });
    }
    ranking = json['ranking'] != null ? Ranking.fromJson(json['ranking']) : null;
    accommodation =
        json['accommodation'] != null ? Accommodation.fromJson(json['accommodation']) : null;
    admission = json['admission'] != null ? Admission.fromJson(json['admission']) : null;
  }
  num? id;
  String? name;
  String? universityIcon;
  num? recommended;
  String? description;
  List<String>? images;
  List<String>? videos;
  Overview? overview;
  List<Faq>? faq;
  Ranking? ranking;
  Accommodation? accommodation;
  Admission? admission;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['university_icon'] = universityIcon;
    map['recommended'] = recommended;
    map['description'] = description;
    map['images'] = images;
    map['videos'] = videos;
    if (overview != null) {
      map['overview'] = overview?.toJson();
    }
    if (faq != null) {
      map['faq'] = faq?.map((v) => v.toJson()).toList();
    }
    if (ranking != null) {
      map['ranking'] = ranking?.toJson();
    }
    if (accommodation != null) {
      map['accommodation'] = accommodation?.toJson();
    }
    if (admission != null) {
      map['admission'] = admission?.toJson();
    }
    return map;
  }
}

class Admission {
  Admission({
    this.overview,
    this.eligibility,
    this.prepTest,
  });

  Admission.fromJson(dynamic json) {
    overview = json['overview'];
    if (json['eligibility'] != null) {
      eligibility = [];
      json['eligibility'].forEach((v) {
        eligibility?.add(Eligibility.fromJson(v));
      });
    }
    if (json['prep_test'] != null) {
      prepTest = [];
      json['prep_test'].forEach((v) {
        prepTest?.add(PrepTest.fromJson(v));
      });
    }
  }
  String? overview;
  List<Eligibility>? eligibility;
  List<PrepTest>? prepTest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['overview'] = overview;
    if (eligibility != null) {
      map['eligibility'] = eligibility?.map((v) => v.toJson()).toList();
    }
    if (prepTest != null) {
      map['prep_test'] = prepTest?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PrepTest {
  PrepTest({
    this.examName,
    this.ugScore,
    this.pgScore,
    this.phdScore,
  });

  PrepTest.fromJson(dynamic json) {
    examName = json['examName'];
    ugScore = json['ugScore'];
    pgScore = json['pgScore'];
    phdScore = json['phdScore'];
  }
  String? examName;
  String? ugScore;
  String? pgScore;
  String? phdScore;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['examName'] = examName;
    map['ugScore'] = ugScore;
    map['pgScore'] = pgScore;
    map['phdScore'] = phdScore;
    return map;
  }
}

class Eligibility {
  Eligibility({
    this.name,
    this.standard,
    this.percentage,
    this.boards,
  });

  Eligibility.fromJson(dynamic json) {
    name = json['name'];
    standard = json['STANDARD'];
    percentage = json['PERCENTAGE'];
    boards = json['BOARDS'];
  }
  String? name;
  String? standard;
  String? percentage;
  String? boards;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['STANDARD'] = standard;
    map['PERCENTAGE'] = percentage;
    map['BOARDS'] = boards;
    return map;
  }
}

class Accommodation {
  Accommodation({
    this.onCampus,
    this.offCampus,
  });

  Accommodation.fromJson(dynamic json) {
    onCampus = json['on_campus'] != null ? json['on_campus'].cast<String>() : [];
    offCampus = json['off_campus'] != null ? json['off_campus'].cast<String>() : [];
  }
  List<String>? onCampus;
  List<String>? offCampus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['on_campus'] = onCampus;
    map['off_campus'] = offCampus;
    return map;
  }
}

class Ranking {
  Ranking({
    this.overview,
    this.ranks,
  });

  Ranking.fromJson(dynamic json) {
    overview = json['overview'];
    if (json['ranks'] != null) {
      ranks = [];
      json['ranks'].forEach((v) {
        ranks?.add(Ranks.fromJson(v));
      });
    }
  }
  String? overview;
  List<Ranks>? ranks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['overview'] = overview;
    if (ranks != null) {
      map['ranks'] = ranks?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Ranks {
  Ranks({
    this.publisher,
    this.publishername,
    this.rankings,
  });

  Ranks.fromJson(dynamic json) {
    publisher = json['publisher'];
    publishername = json['publishername'];
    rankings = json['rankings'] != null ? Rankings.fromJson(json['rankings']) : null;
  }
  String? publisher;
  String? publishername;
  Rankings? rankings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['publisher'] = publisher;
    map['publishername'] = publishername;
    if (rankings != null) {
      map['rankings'] = rankings?.toJson();
    }
    return map;
  }
}

class Rankings {
  Rankings({
    this.y19,
    this.y20,
    this.y21,
    this.y22,
    this.y23,
    this.y24,
  });

  Rankings.fromJson(dynamic json) {
    y19 = json['2019'];
    y20 = json['2020'];
    y21 = json['2021'];
    y22 = json['2022'];
    y23 = json['2023'];
    y24 = json['2024'];
  }
  String? y19;
  String? y20;
  String? y21;
  String? y22;
  String? y23;
  String? y24;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['2019'] = y19;
    map['2020'] = y20;
    map['2021'] = y21;
    map['2022'] = y22;
    map['2023'] = y23;
    map['2024'] = y24;
    return map;
  }
}

class Faq {
  Faq({
    this.question,
    this.answer,
  });

  Faq.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
  }
  String? question;
  String? answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }
}

class Overview {
  Overview({
    this.studentLife,
    this.establishment,
    this.qsRanking,
    this.totalStudents,
    this.intStudents,
    this.whyChoose,
    this.services,
  });

  Overview.fromJson(dynamic json) {
    studentLife = json['student_life'];
    establishment = json['establishment'];
    qsRanking = json['qs_ranking'];
    totalStudents = json['total_students'];
    intStudents = json['int_students'];
    if (json['why_choose'] != null) {
      whyChoose = [];
      json['why_choose'].forEach((v) {
        whyChoose?.add(WhyChoose.fromJson(v));
      });
    }
    services = json['services'] != null ? json['services'].cast<String>() : [];
  }
  String? studentLife;
  String? establishment;
  num? qsRanking;
  num? totalStudents;
  String? intStudents;
  List<WhyChoose>? whyChoose;
  List<String>? services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['student_life'] = studentLife;
    map['establishment'] = establishment;
    map['qs_ranking'] = qsRanking;
    map['total_students'] = totalStudents;
    map['int_students'] = intStudents;
    if (whyChoose != null) {
      map['why_choose'] = whyChoose?.map((v) => v.toJson()).toList();
    }
    map['services'] = services;
    return map;
  }
}

class WhyChoose {
  WhyChoose({
    this.header,
    this.content,
  });

  WhyChoose.fromJson(dynamic json) {
    header = json['header'];
    content = json['content'];
  }
  String? header;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['header'] = header;
    map['content'] = content;
    return map;
  }
}

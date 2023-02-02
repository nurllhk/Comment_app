// To parse this JSON data, do
//
//     final kullaniciCommentModel = kullaniciCommentModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KullaniciCommentModel kullaniciCommentModelFromMap(String str) => KullaniciCommentModel.fromMap(json.decode(str));

String kullaniciCommentModelToMap(KullaniciCommentModel data) => json.encode(data.toMap());

class KullaniciCommentModel {
  KullaniciCommentModel({
    required this.user,
    required this.comments,
    required this.products,
    required this.reviews,
    required this.categories,
  });

  final User user;
  final List<Comment> comments;
  final List<Product> products;
  final List<Review> reviews;
  final List<Category> categories;

  factory KullaniciCommentModel.fromMap(Map<String, dynamic> json) => KullaniciCommentModel(
    user: User.fromMap(json["user"]),
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromMap(x))),
    products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromMap(x))),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "user": user.toMap(),
    "comments": List<dynamic>.from(comments.map((x) => x.toMap())),
    "products": List<dynamic>.from(products.map((x) => x.toMap())),
    "reviews": List<dynamic>.from(reviews.map((x) => x.toMap())),
    "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
  };
}

class Category {
  Category({
    required this.id,
    required this.cId,
    required this.title,
    required this.image,
    required this.seoContent,
    required this.sef,
    required this.rank,
    required this.status,
  });

  final String? id;
  final String? cId;
  final String? title;
  final dynamic image;
  final dynamic seoContent;
  final String? sef;
  final String? rank;
  final String? status;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    cId: json["c_id"],
    title: json["title"],
    image: json["image"],
    seoContent: json["seo_content"],
    sef: json["sef"],
    rank: json["rank"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "c_id": cId,
    "title": title,
    "image": image,
    "seo_content": seoContent,
    "sef": sef,
    "rank": rank,
    "status": status,
  };
}

class Comment {
  Comment({
    required this.id,
    required this.rId,
    required this.uId,
    required this.answeredUId,
    required this.content,
    required this.liked,
    required this.unliked,
    required this.status,
    required this.date,
  });

  final String? id;
  final String? rId;
  final String? uId;
  final String? answeredUId;
  final String? content;
  final String? liked;
  final String? unliked;
  final String? status;
  final DateTime date;

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
    id: json["id"],
    rId: json["r_id"],
    uId: json["u_id"],
    answeredUId: json["answered_u_id"],
    content: json["content"],
    liked: json["liked"],
    unliked: json["unliked"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "r_id": rId,
    "u_id": uId,
    "answered_u_id": answeredUId,
    "content": content,
    "liked": liked,
    "unliked": unliked,
    "status": status,
    "date": date.toIso8601String(),
  };
}

class Product {
  Product({
    required this.id,
    required this.addUser,
    required this.cId,
    required this.bId,
    required this.title,
    required this.image,
    required this.price,
    required this.gtinNo,
    required this.sef,
    required this.views,
    required this.status,
  });

  final String? id;
  final String? addUser;
  final String? cId;
  final String? bId;
  final String? title;
  final String? image;
  final String? price;
  final dynamic gtinNo;
  final String? sef;
  final String? views;
  final String? status;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    addUser: json["add_user"],
    cId: json["c_id"],
    bId: json["b_id"],
    title: json["title"],
    image: json["image"],
    price: json["price"],
    gtinNo: json["gtin_no"],
    sef: json["sef"],
    views: json["views"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "add_user": addUser,
    "c_id": cId,
    "b_id": bId,
    "title": title,
    "image": image,
    "price": price,
    "gtin_no": gtinNo,
    "sef": sef,
    "views": views,
    "status": status,
  };
}

class Review {
  Review({
    required this.id,
    required this.cId,
    required this.bId,
    required this.uId,
    required this.pId,
    required this.homeView,
    required this.payReview,
    required this.weekCategory,
    required this.title,
    required this.content,
    required this.sef,
    required this.rate,
    required this.priceRate,
    required this.recommend,
    required this.liked,
    required this.unliked,
    required this.views,
    required this.approvedPoint,
    required this.firstPoint,
    required this.wordPoint,
    required this.spellingPoint,
    required this.imagePoint,
    required this.originalImagePoint,
    required this.paragraphPoint,
    required this.plagiarism,
    required this.plagiarismResult,
    required this.originalContent,
    required this.copyContent,
    required this.rejectedType,
    required this.revised,
    required this.date,
    required this.waitPublishDate,
    required this.payAndPointCompleted,
    required this.status,
  });

  final String? id;
  final String? cId;
  final String? bId;
  final String? uId;
  final String? pId;
  final String? homeView;
  final String? payReview;
  final String? weekCategory;
  final String? title;
  final String? content;
  final String? sef;
  final String? rate;
  final String? priceRate;
  final String? recommend;
  final String? liked;
  final String? unliked;
  final String? views;
  final String? approvedPoint;
  final String? firstPoint;
  final String? wordPoint;
  final String? spellingPoint;
  final String? imagePoint;
  final String? originalImagePoint;
  final String? paragraphPoint;
  final String? plagiarism;
  final String? plagiarismResult;
  final String? originalContent;
  final String? copyContent;
  final String? rejectedType;
  final String? revised;
  final DateTime date;
  final DateTime waitPublishDate;
  final String? payAndPointCompleted;
  final String? status;

  factory Review.fromMap(Map<String, dynamic> json) => Review(
    id: json["id"],
    cId: json["c_id"],
    bId: json["b_id"],
    uId: json["u_id"],
    pId: json["p_id"],
    homeView: json["home_view"],
    payReview: json["pay_review"],
    weekCategory: json["week_category"],
    title: json["title"],
    content: json["content"],
    sef: json["sef"],
    rate: json["rate"],
    priceRate: json["price_rate"],
    recommend: json["recommend"],
    liked: json["liked"],
    unliked: json["unliked"],
    views: json["views"],
    approvedPoint: json["approved_point"],
    firstPoint: json["first_point"],
    wordPoint: json["word_point"],
    spellingPoint: json["spelling_point"],
    imagePoint: json["image_point"],
    originalImagePoint: json["original_image_point"],
    paragraphPoint: json["paragraph_point"],
    plagiarism: json["plagiarism"],
    plagiarismResult: json["plagiarism_result"],
    originalContent: json["original_content"],
    copyContent: json["copy_content"],
    rejectedType: json["rejected_type"],
    revised: json["revised"],
    date: DateTime.parse(json["date"]),
    waitPublishDate: DateTime.parse(json["wait_publish_date"]),
    payAndPointCompleted: json["pay_and_point_completed"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "c_id": cId,
    "b_id": bId,
    "u_id": uId,
    "p_id": pId,
    "home_view": homeView,
    "pay_review": payReview,
    "week_category": weekCategory,
    "title": title,
    "content": content,
    "sef": sef,
    "rate": rate,
    "price_rate": priceRate,
    "recommend": recommend,
    "liked": liked,
    "unliked": unliked,
    "views": views,
    "approved_point": approvedPoint,
    "first_point": firstPoint,
    "word_point": wordPoint,
    "spelling_point": spellingPoint,
    "image_point": imagePoint,
    "original_image_point": originalImagePoint,
    "paragraph_point": paragraphPoint,
    "plagiarism": plagiarism,
    "plagiarism_result": plagiarismResult,
    "original_content": originalContent,
    "copy_content": copyContent,
    "rejected_type": rejectedType,
    "revised": revised,
    "date": date.toIso8601String(),
    "wait_publish_date": waitPublishDate.toIso8601String(),
    "pay_and_point_completed": payAndPointCompleted,
    "status": status,
  };
}

class User {
  User({
    required this.id,
    required this.activationKey,
    required this.referer,
    required this.refererKey,
    required this.username,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.gender,
    required this.balance,
    required this.userLevel,
    required this.password,
    required this.passwordHash,
    required this.bannedMsg,
    required this.banFinishTime,
    required this.sef,
    required this.lastLogin,
    required this.lastIp,
    required this.registerIp,
    required this.registerDate,
    required this.firstReviewStep,
    required this.timepayTime,
    required this.editor,
    required this.copyReviews,
    required this.rejectedReviews,
    required this.status,
  });

  final String? id;
  final String? activationKey;
  final String? referer;
  final String? refererKey;
  final String? username;
  final String? phone;
  final String? email;
  final dynamic avatar;
  final String? gender;
  final String? balance;
  final String? userLevel;
  final String? password;
  final dynamic passwordHash;
  final dynamic bannedMsg;
  final dynamic banFinishTime;
  final String? sef;
  final DateTime lastLogin;
  final String? lastIp;
  final String? registerIp;
  final DateTime registerDate;
  final String? firstReviewStep;
  final String? timepayTime;
  final String? editor;
  final String? copyReviews;
  final String? rejectedReviews;
  final String? status;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    activationKey: json["activation_key"],
    referer: json["referer"],
    refererKey: json["referer_key"],
    username: json["username"],
    phone: json["phone"],
    email: json["email"],
    avatar: json["avatar"],
    gender: json["gender"],
    balance: json["balance"],
    userLevel: json["user_level"],
    password: json["password"],
    passwordHash: json["password_hash"],
    bannedMsg: json["banned_msg"],
    banFinishTime: json["ban_finish_time"],
    sef: json["sef"],
    lastLogin: DateTime.parse(json["last_login"]),
    lastIp: json["last_ip"],
    registerIp: json["register_ip"],
    registerDate: DateTime.parse(json["register_date"]),
    firstReviewStep: json["first_review_step"],
    timepayTime: json["timepay_time"],
    editor: json["editor"],
    copyReviews: json["copy_reviews"],
    rejectedReviews: json["rejected_reviews"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "activation_key": activationKey,
    "referer": referer,
    "referer_key": refererKey,
    "username": username,
    "phone": phone,
    "email": email,
    "avatar": avatar,
    "gender": gender,
    "balance": balance,
    "user_level": userLevel,
    "password": password,
    "password_hash": passwordHash,
    "banned_msg": bannedMsg,
    "ban_finish_time": banFinishTime,
    "sef": sef,
    "last_login": lastLogin.toIso8601String(),
    "last_ip": lastIp,
    "register_ip": registerIp,
    "register_date": registerDate.toIso8601String(),
    "first_review_step": firstReviewStep,
    "timepay_time": timepayTime,
    "editor": editor,
    "copy_reviews": copyReviews,
    "rejected_reviews": rejectedReviews,
    "status": status,
  };
}

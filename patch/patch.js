const path = require("path");
const fs = require("fs");

const localAppData = process.env.LOCALAPPDATA;
console.log("Patching vrchat_dart_generated...");
console.log(localAppData);
const avatar = path.join(
  localAppData,
  "Pub",
  "Cache",
  "hosted",
  "pub.dev",
  "vrchat_dart_generated-1.20.9",
  "lib",
  "src",
  "model",
  "avatar.dart"
);
const avatar_g = path.join(
  localAppData,
  "Pub",
  "Cache",
  "hosted",
  "pub.dev",
  "vrchat_dart_generated-1.20.9",
  "lib",
  "src",
  "model",
  "avatar.g.dart"
);
console.log("Patching " + avatar);
fs.readFileSync(avatar, "utf8");
let content = fs.readFileSync(avatar, "utf8");
content = content.replace(
  /required this\.imageUrl/,
  "this.imageUrl"
);
content = content.replace(
  /@JsonKey\(name: r'imageUrl', required: true, includeIfNull: false\)/,
  "@JsonKey(name: r'imageUrl', required: false, includeIfNull: false)"
);
content = content.replace(
  /final String imageUrl;/,
  "final String? imageUrl;"
);
content = content.replace(
  /required this\.thumbnailImageUrl/,
  "this.thumbnailImageUrl"
);
content = content.replace(
  /@JsonKey\(name: r'thumbnailImageUrl', required: true, includeIfNull: false\)/,
  "@JsonKey(name: r'thumbnailImageUrl', required: false, includeIfNull: false)"
);
content = content.replace(
  /final String thumbnailImageUrl;/,
  "final String? thumbnailImageUrl;"
);
console.log(content.search(/final String\? imageUrl;/));
console.log(content.search(/final String\? thumbnailImageUrl;/));
fs.writeFileSync(avatar, content, "utf8");

console.log("Patching " + avatar_g);
fs.readFileSync(avatar_g, "utf8");
content = fs.readFileSync(avatar_g, "utf8");
content = content.replace(
  /('(?:imageUrl|thumbnailImageUrl)',\s+)\(v\) => v as String([\),])/g,
  "$1(v) => v as String?$2"
);
content = content.replace(
    /(requiredKeys[^\]]*)'imageUrl',/,
    "$1",
);
content = content.replace(
    /(requiredKeys[^\]]*)'thumbnailImageUrl',/,
    "$1",
);
fs.writeFileSync(avatar_g, content, "utf8");

const current_user = path.join(
  localAppData,
  "Pub",
  "Cache",
  "hosted",
  "pub.dev",
  "vrchat_dart_generated-1.20.9",
  "lib",
  "src",
  "model",
  "current_user.dart"
);
const current_user_g = path.join(
  localAppData,
  "Pub",
  "Cache",
  "hosted",
  "pub.dev",
  "vrchat_dart_generated-1.20.9",
  "lib",
  "src",
  "model",
  "current_user.g.dart"
);
const current_user_presence_g = path.join(
  localAppData,
  "Pub",
  "Cache",
  "hosted",
  "pub.dev",
  "vrchat_dart_generated-1.20.9",
  "lib",
  "src",
  "model",
  "current_user_presence.g.dart"
);
console.log("Patching " + current_user);
content = fs.readFileSync(current_user, "utf8");
content = content.replace(
  /required this\.bio,/,
  "this.bio,"
);
content = content.replace(
  /@JsonKey\(name: r'bio', required: true, includeIfNull: false\)/,
  "@JsonKey(name: r'bio', required: false, includeIfNull: false)"
);
content = content.replace(
  /final String bio;/,
  "final String? bio;"
);
content = content.replace(
  /required this\.bioLinks,/,
  "this.bioLinks,"
);
content = content.replace(
  /@JsonKey\(name: r'bioLinks', required: true, includeIfNull: false\)/,
  "@JsonKey(name: r'bioLinks', required: false, includeIfNull: false)"
);
content = content.replace(
  /final List<String> bioLinks;/,
  "final List<String>? bioLinks;"
);
content = content.replace(
  /required this\.profilePicOverride,/,
  "this.profilePicOverride,"
);
content = content.replace(
  /@JsonKey\(name: r'profilePicOverride', required: true, includeIfNull: false\)/,
  "@JsonKey(name: r'profilePicOverride', required: false, includeIfNull: false)"
);
content = content.replace(
  /final String profilePicOverride;/,
  "final String? profilePicOverride;"
);
content = content.replace(
  /required this\.profilePicOverrideThumbnail,/,
  "this.profilePicOverrideThumbnail,"
);
content = content.replace(
  /name: r'profilePicOverrideThumbnail',\s+required: true,/,
  "name: r'profilePicOverrideThumbnail', required: false,"
);
content = content.replace(
  /final String profilePicOverrideThumbnail;/,
  "final String? profilePicOverrideThumbnail;"
);
content = content.replace(
  /required this\.userIcon,/,
  "this.userIcon,"
);
content = content.replace(
  /@JsonKey\(name: r'userIcon', required: true, includeIfNull: false\)/,
  "@JsonKey(name: r'userIcon', required: false, includeIfNull: false)"
);
content = content.replace(
  /final String userIcon;/,
  "final String? userIcon;"
);
console.log(content.search(/final String\? bio;/));
console.log(content.search(/final List<String>\? bioLinks;/));
console.log(content.search(/final String\? profilePicOverride;/));
console.log(content.search(/final String\? profilePicOverrideThumbnail;/));
console.log(content.search(/final String\? userIcon;/));
fs.writeFileSync(current_user, content, "utf8");

console.log("Patching " + current_user_g);
content = fs.readFileSync(current_user_g, "utf8");
content = content.replace(
  /('(?:bio|profilePicOverride|profilePicOverrideThumbnail|userIcon)',\s+)\(v\) => v as String([\),])/g,
  "$1(v) => v as String?$2"
);
content = content.replace(
  /('bioLinks',\s+)\(v\) => \(v as List<dynamic>\)\.map/,
  "$1(v) => (v as List<dynamic>?)?.map"
);
content = content.replace(
    /(requiredKeys[^\]]*)'bio',/,
    "$1",
);
content = content.replace(
    /(requiredKeys[^\]]*)'bioLinks',/,
    "$1",
);
content = content.replace(
    /(requiredKeys[^\]]*)'profilePicOverride',/,
    "$1",
);
content = content.replace(
    /(requiredKeys[^\]]*)'profilePicOverrideThumbnail',/,
    "$1",
);
content = content.replace(
    /(requiredKeys[^\]]*)'userIcon',/,
    "$1",
);
fs.writeFileSync(current_user_g, content, "utf8");

console.log("Patching " + current_user_presence_g);
content = fs.readFileSync(current_user_presence_g, "utf8");
content = content.replace(
  /('currentAvatarTags',\s+)\(v\) => \(v as List<dynamic>\?\)/,
  "$1(v) => (v is String ? null : v as List<dynamic>?)"
);
fs.writeFileSync(current_user_presence_g, content, "utf8");

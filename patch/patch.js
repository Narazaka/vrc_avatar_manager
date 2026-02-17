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
  "vrchat_dart_generated-1.20.7",
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
  "vrchat_dart_generated-1.20.7",
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

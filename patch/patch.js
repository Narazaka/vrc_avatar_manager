const path = require("path");
const fs = require("fs");

const localAppData = process.env.LOCALAPPDATA;
console.log("Patching vrchat_dart_generated...");
console.log(localAppData);
const current_user_presence = path.join(
  localAppData,
  "Pub",
  "Cache",
  "hosted",
  "pub.dev",
  "vrchat_dart_generated-1.20.4",
  "lib",
  "src",
  "model",
  "current_user_presence.dart"
);
const current_user_presence_g = path.join(
  localAppData,
  "Pub",
  "Cache",
  "hosted",
  "pub.dev",
  "vrchat_dart_generated-1.20.4",
  "lib",
  "src",
  "model",
  "current_user_presence.g.dart"
);
console.log("Patching " + current_user_presence);
fs.readFileSync(current_user_presence, "utf8");
let content = fs.readFileSync(current_user_presence, "utf8");
content = content.replace(
  /final String\? currentAvatarTags;/,
  "final List<String>? currentAvatarTags;"
);
console.log(content.search(/final List<String>\? currentAvatarTags;/));
fs.writeFileSync(current_user_presence, content, "utf8");

console.log("Patching " + current_user_presence_g);
fs.readFileSync(current_user_presence_g, "utf8");
content = fs.readFileSync(current_user_presence_g, "utf8");
content = content.replace(
  /(\'currentAvatarTags\',\s+)(\(v\) => )v as String\?,/,
  "$1(v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),"
);
console.log(content.search(/'currentAvatarTags',[\n\s]*\(v\) => \(v as List<dynamic>\?\)\?.map\(\(e\) => e as String\)\.toList\(\),/));
fs.writeFileSync(current_user_presence_g, content, "utf8");

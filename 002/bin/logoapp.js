#!/usr/bin/env node

var fs = require("fs");
var parser = require("../lib/logo_language.js");
var Logo = require("../lib/logo.js");
var args = process.argv.slice(2);

if (args.length != 1) {
  abort("Usage: run file");
}

var inputFile = args[0];

var inputStream = fs.createReadStream(inputFile);

inputStream.on("error", function () {
  abort("Can't read from file \"" + inputFile + "\".");
});

readStream(inputStream, function(input) {
  var logo = new Logo();
  logo.run(parser.parse(input));
});

function readStream(inputStream, callback) {
  var input = "";
  inputStream.on("data", function (data) { input += data; });
  inputStream.on("end", function () { callback(input); });
}

function abort(message) {
  console.log(message);
  process.exit(1);
}
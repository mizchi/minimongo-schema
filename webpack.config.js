var webpack = require("webpack");
var path = require('path');

module.exports = {
  entry: './src/index.coffee',
  output: {
    filename: 'demo/minimongo-schema.js'
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" }
    ]
  },
  resolve: {
    root: [
      path.join(__dirname, "bower_components"),
    ],
    extensions: ["", ".coffee", ".js"]
  }
};

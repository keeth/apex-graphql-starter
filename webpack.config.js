// NOTE: paths are relative to each functions folder
const Webpack = require('webpack');

module.exports = {
  entry: './src/index.js',
  target: 'node',
  output: {
    path: './lib',
    filename: 'index.js',
    libraryTarget: 'commonjs2'
  },
  externals: {
    'aws-sdk': 'aws-sdk'
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        loader: 'babel',
        query: {
          presets: [
            'stage-0',
            'latest'
          ]
        },
        exclude: [/node_modules/]
      },
      {
        test: /\.json$/,
        loader: 'json-loader'
      }
    ],
  }
};

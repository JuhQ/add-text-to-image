var writeText = require('../index.js');
var fs = require('fs');

var file = './example/F5lPa5p.jpg';
var text = 'Wish you were here';

writeText({path: file, text: text})
  .then(function(result) {
    console.log('result', result);
    fs.writeFile('./tmp/F5lPa5p.jpg', result);
  })
  .fail(function(err) {
    console.log('error', err);
  });
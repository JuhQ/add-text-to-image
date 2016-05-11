(function() {
  var Jimp, ninvoke, splitText;

  ninvoke = require('q').ninvoke;

  Jimp = require('jimp');

  splitText = require('split-text-middle');

  module.exports = function(arg) {
    var blackFont, color, font, fontSize, path, quality, text, whiteFont;
    path = arg.path, text = arg.text, color = arg.color, quality = arg.quality, fontSize = arg.fontSize;
    if (quality == null) {
      quality = 60;
    }
    if (color == null) {
      color = 'white';
    }
    if (fontSize == null) {
      fontSize = 64;
    }
    blackFont = Jimp["FONT_SANS_" + fontSize + "_BLACK"];
    whiteFont = Jimp["FONT_SANS_" + fontSize + "_WHITE"];
    font = color === 'white' ? whiteFont : blackFont;
    return ninvoke(Jimp, 'loadFont', font).then(function(font) {
      return Jimp.read(path).then(function(image) {
        return {
          image: image,
          font: font
        };
      });
    }).then(function(arg1) {
      var chain, first, font, image, last, ref, x, y;
      image = arg1.image, font = arg1.font;
      y = image.bitmap.height - 200;
      x = 30;
      ref = splitText(text), first = ref.first, last = ref.last;
      chain = image.print(font, x, y, first).print(font, x, y + fontSize, last).quality(60);
      return ninvoke(chain, 'getBuffer', Jimp.MIME_JPEG);
    });
  };

}).call(this);

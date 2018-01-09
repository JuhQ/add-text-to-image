{ninvoke} = require('q')
Jimp = require('jimp')
splitText = require('split-text-middle')

module.exports = ({path, text, color, quality, fontSize, blackFont, whiteFont}) ->
  quality ?= 60
  color ?= 'white'
  fontSize ?= 64

  blackFont ?= Jimp["FONT_SANS_#{fontSize}_BLACK"]
  whiteFont ?= Jimp["FONT_SANS_#{fontSize}_WHITE"]

  font =
    if color is 'white'
      whiteFont
    else
      blackFont

  ninvoke(Jimp, 'loadFont', font)
    .then (font) ->
      Jimp.read(path).then (image) -> {image, font}
    .then ({image, font}) ->
      y = image.bitmap.height - 200
      x = 30

      {first, last} = splitText(text)

      chain = image
        .print(font, x, y, first)
        .print(font, x, (y + fontSize), last)
        .quality(60)

      ninvoke(chain, 'getBuffer', Jimp.MIME_JPEG)

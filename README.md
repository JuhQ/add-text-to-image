### Write text to image

Because why not


`npm install add-text-to-image --save`


Returns an promise which has the file buffer

[example/example.js](Example)

```
writeText({path: file, text: text})
  .then(function(result) {
    console.log('result', result);
    fs.writeFile('./tmp/F5lPa5p.jpg', result);
  })
  .fail(function(err) {
    console.log('error', err);
  });
```
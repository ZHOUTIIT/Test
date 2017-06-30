var x = [3, 4, 5, 7, 3, 21, 12, 5, 56, 43, 2, 3]
x.push(5)
x = x.sort(function(a, b) {
  return a - b
})
console.log(Math.max.apply(null, x));

var add = (function() {
  var counter = 0;
  return function() {
    return counter += 1;
  }
})();

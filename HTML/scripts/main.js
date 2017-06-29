var myHeading = document.querySelector('h1')
myHeading.innerHTML = 'Hello World!'
if (myHeading.innerHTML == 'Hello World!') {
  myHeading.innerHTML = 'Hello!'
}
document.querySelector('h1').onclick = function() {
  alert("don't touch me!")
}
img = document.querySelector('img');
img.onclick = function() {
  var src = img.getAttribute('src');
  if (src === 'images/map.jpg') {
    img.setAttribute('src', 'images/doctor_strange.jpg');
  } else {
    img.setAttribute('src', 'images/map.jpg');
  }
}
var cu = document.getElementById('cu');
var lo = document.getElementById('lo');

function setUserName() {
  var myName = prompt('Please enter your name.');
  localStorage.setItem('name', myName);
  myHeading.innerHTML = 'Shanghai is cool, ' + myName;
}

if (!localStorage.getItem('name')) {
  setUserName();
} else {
  var storedName = localStorage.getItem('name');
  myHeading.innerHTML = 'Shanghai is cool, ' + storedName;
}

function logOut() {
  localStorage.removeItem('name');

  myHeading.innerHTML = 'Shanghai is cool';
}

document.getElementById('sm').onclick = function() {
  var text = document.getElementById('name');
  document.getElementById('welcome').innerHTML = 'Welcome ' + text.value;
}

cu.onclick = function() {
  setUserName()
}
lo.onclick = function() {
  logOut()
}

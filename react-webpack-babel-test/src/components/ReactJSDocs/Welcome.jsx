import React from 'react';
export default function Welcome(props) {
  const speak = (word) => {
    alert(word);
  };
  return <button onClick={() => {
    var hello = "Hello";
    if (props.lang === "chinese") {
      hello = "你好";
    }
    speak(hello + " " + props.name);
  }}>Hello, {props.name}</button>;
}

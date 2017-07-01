import React from "react";
import Clock from './Clock.jsx';
import LoginControl from './Login.jsx';
import Toogle from './Toggle.jsx';
import Calculator from './Calculator.jsx';

function All(props) {
  return (
    <div>
      <Clock/>
      <Toogle/>
      <LoginControl/>
      <Calculator/>
    </div>
  );
}
export default class Docs extends React.Component {
  render() {
    return (
      <div>
        <All/>
      </div>
    );
  }
}

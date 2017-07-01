import React from 'react';
const scaleNames = {
  c: 'Celsius',
  f: 'Fahrenheit'
};
function toCelsius(fahrenheit) {
  return (fahrenheit - 32) * 5 / 9;
}

function toFahrenheit(celsius) {
  return (celsius * 9 / 5) + 32;
}
function tryConvert(temperature, convert) {
  const input = parseFloat(temperature);
  if (Number.isNaN(input)) {
    return '';
  }
  const output = convert(input);
  const rounded = Math.round(output * 1000) / 1000;
  return rounded.toString();
}

function BoilingVerdict(props) {
  if (props.celsius >= 100) {
    return <p>The water would boil.</p>;
  }
  return <p>The water would not boil.</p>;
}

class Temperature extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }
  handleChange(e) {
    this.props.onTemperatureChange(e.target.value);
  }
  render() {
    const temperature = this.props.temperature;
    const scale = this.props.scale;
    return (
      <fieldset>
        <legend>Enter temperature in {scaleNames[scale]}:
        </legend>
        <input value={temperature} onChange={this.handleChange}></input>
      </fieldset>
    );
  }
}

export default class Calculator extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      temperature: '',
      scale: 'c'
    };
    this.handleCChange = this.handleCChange.bind(this);
    this.handleFChange = this.handleFChange.bind(this);
  }
  handleCChange(t) {
    this.setState({scale: 'c', temperature: t});
  }
  handleFChange(t) {
    this.setState({scale: 'f', temperature: t});
  }
  render() {
    const scale = this.state.scale;
    const temperature = this.state.temperature;
    const ct = scale === 'c'
      ? temperature
      : tryConvert(temperature, toCelsius);
    const ft = scale === 'f'
      ? temperature
      : tryConvert(temperature, toFahrenheit);
    return (
      <div>
        <Temperature scale="c" onTemperatureChange={this.handleCChange} temperature={ct}/>
        <Temperature scale="f" onTemperatureChange={this.handleFChange} temperature={ft}/>
        <BoilingVerdict celsius={ct}/>
      </div>
    );
  }
}

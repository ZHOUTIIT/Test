import React from 'react';
export default class Toogle extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isToogleOn: true
    };
    // this.handleClick = this.handleClick.bind(this)
  }
  handleClick() {
    this.setState(prevState => ({
      isToogleOn: !prevState.isToogleOn
    }));
  }
  render() {
    return (
      <button onClick={(e) => this.handleClick(e)}>{this.state.isToogleOn
          ? "ON"
          : "OFF"}</button>
    );
  }
}

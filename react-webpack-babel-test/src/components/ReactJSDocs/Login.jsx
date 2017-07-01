import React from 'react';
function GestLogin() {
  return <h1>Please sign up!</h1>;
}
function CustomerLogin() {
  return <h1>Welcome back!</h1>;
}
function Greeting(props) {
  if (props.isLogin) {
    return <CustomerLogin/>;
  }
  return <GestLogin/>;
}
function LoginButton(props) {
  return <button onClick={props.onClick}>Login</button>;
}

function LogoutButton(props) {
  return <button onClick={props.onClick}>Logout</button>;
}

export default class LoginControl extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isLogin: false
    };
  }
  handleLoginClick() {
    this.setState({isLogin: true});
  }
  handleLogoutClick() {
    this.setState({isLogin: false});
  }
  render() {
    return (
      <div>
        <Greeting isLogin={this.state.isLogin}></Greeting>
        {this.state.isLogin
          ? (<LogoutButton onClick={(e) => this.handleLogoutClick(e)}/>)
          : (<LoginButton onClick={(e) => this.handleLoginClick(e)}/>)}
      </div>
    );
  }
}

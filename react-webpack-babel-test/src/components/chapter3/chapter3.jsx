import React from 'react';
// import ReactDOM from 'react-dom';

function formdate(date) {
	// ReactDOM.render(
	// 	<p>{date.toLocaleDateString()}</p>, document.getElementById('root'));
	return date.toLocaleDateString();
}

function Welcome(props) {
	const speak = (word) => {
		// word.preventDefault();
		alert(word)
	}
	return <button onClick={() => {
		var hello = "Hello";
		if (props.lang === "chinese") {
			hello = "你好";
		}
		speak(hello + " " + props.name)
	}}>Hello, {props.name}</button>
}

function GestLogin() {
	return <h1>Please sign up!</h1>
}
function CustomerLogin() {
	return <h1>Welcome back!</h1>
}
function Greeting(props) {
	if (props.isLogin) {
		return <CustomerLogin/>
	}
	return <GestLogin/>
}
function LoginButton(props) {
	return <button onClick={props.onClick}>Login</button>
}

function LogoutButton(props) {
	return <button onClick={props.onClick}>Logout</button>
}

class LoginControl extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			isLogin: false
		};
	}
	handleLoginClick() {
		this.setState({isLogin: true})
	}
	handleLogoutClick() {
		this.setState({isLogin: false})
	}
	render() {
		return (
			<div>
				<Greeting isLogin={this.state.isLogin}></Greeting>
				{this.state.isLogin
					? (<LogoutButton onClick={(e) => this.handleLogoutClick(e)}/>)
					: (<LoginButton onClick={(e) => this.handleLoginClick(e)}/>)}
			</div>
		)
	}
}
class Toogle extends React.Component {
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
		}))
	}
	render() {
		return (
			<button onClick={(e) => this.handleClick(e)}>{this.state.isToogleOn
					? 'ON'
					: 'OFF'}</button>
		);
	}
}

class Clock extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			date: new Date()
		};
	}

	componentDidMount() {
		this.timerID = setInterval(() => {
			this.tick(),
			1000
		})
	}
	componentWillUnmount() {
		clearInterval(this.timerID)
	}
	tick() {
		this.setState({date: new Date()});
	}
	render() {
		return (
			<div>
				<h1>Hellow World</h1>
				<h2>{this.state.date.toLocaleTimeString()}</h2>
			</div>
		);
	}

}

function All(props) {
	return (
		<div>
			<div>
				{formdate(props.date)}
			</div>
			<Welcome name={props.people.name} speak={props.people.speak} lang={props.people.lang}/>
			<Clock/>
			<Toogle/>
			<LoginControl/>
		</div>
	)
}
const sara = {
	date: new Date(),
	people: {
		name: "sara",
		lang: "chinese",
		// speak: (word) => {
		// 	alert(word + " hahaha")
		// }
	}
}
export default class Chapter3 extends React.Component {
	render() {
		return (
			<div>
				<All people={sara.people} date={sara.date}/>
			</div>
		)
	}
}

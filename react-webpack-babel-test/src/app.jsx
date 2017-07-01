import React from "react";
import "../styles/index.scss";
import Docs from "./components/ReactJSDocs/Docs.jsx";

export default class App extends React.Component {
  render() {
    return (
      <div>
        <Docs/>
      </div>
    );
  }
}

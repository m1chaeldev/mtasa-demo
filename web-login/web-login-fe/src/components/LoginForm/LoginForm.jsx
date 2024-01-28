import { useState } from "react";
import "./LoginForm.css";
import { tabs } from "../../common/constants";

// eslint-disable-next-line react/prop-types
const LoginForm = ({ onSubmitLogin, onSubmitSignUp }) => {
  const [tab, setTab] = useState(tabs.login);
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  const changeTab = () => {
    setTab(tab === tabs.login ? tabs.signUp : tabs.login);
  };

  const onSubmit = () => {
    if (tab === tabs.login) return onSubmitLogin({ username, password }, tab);

    return onSubmitSignUp({ username, password }, tab);
  };

  return (
    <div className="login-form-container">
      <h1 className="form-title">{tab === tabs.login ? "Login" : "Sign Up"}</h1>
      <div className="input-container">
        <div>Username</div>
        <input
          type="text"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
      </div>
      <div className="input-container">
        <div>Password</div>
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </div>
      <div className="action-btns-wrapper">
        <button className="login-btn" onClick={onSubmit}>
          Play!
        </button>
        <button className="login-btn" onClick={changeTab}>
          or {tab === tabs.login ? "Sign Up" : "Login"}
        </button>
      </div>
    </div>
  );
};

export default LoginForm;

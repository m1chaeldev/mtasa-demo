import LoginForm from "./components/LoginForm";
import { tabs } from "./common/constants";

function App() {
  const onSubmitLogin = (formValue, tab) => {
    const { username, password } = formValue;

    if (window?.mta) {
      const { mta } = window;

      mta.triggerEvent(
        "loginPlayer",
        tab === tabs.login ? "Login" : "Sign Up",
        username,
        password
      );
    }
  };

  return (
    <div>
      <LoginForm onSubmitLogin={onSubmitLogin} onSubmitSignUp={onSubmitLogin} />
    </div>
  );
}

export default App;

import { useState } from 'react'
import './App.css'

const tabs = {
  login: 'login',
  signUp: 'signUp'
}

function App() {
  const [tab, setTab] = useState(tabs.login)

  const changeTab = () => {
    setTab(tab === tabs.login ? tabs.signUp : tabs.login)
  }

  return (
    <div className='login-form-container'>
      <h1 className='form-title' id='form-title'>{tab === tabs.login ? 'Login' : 'Sign Up'}</h1>
      <div className='input-container'>
        <div>Username</div>
        <input type='text' id="username" />
      </div>
      <div className='input-container'>
        <div>Password</div>
        <input type='password' id="password" />
      </div>
      <div className='action-btns-wrapper'>
        <button id="submit-btn" className='login-btn'>
          Submit
        </button>
        <button className='login-btn' onClick={changeTab}>
          Change to {tab === tabs.login ? 'Sign Up' : 'Login'}
        </button>
      </div>
    </div>
  )
}

export default App

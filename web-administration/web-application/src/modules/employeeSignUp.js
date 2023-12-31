import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import {sha512} from 'crypto-hash';
import { useNavigate } from 'react-router-dom';

const EmployeeSignUp = () => {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [passwordMatchError, setPasswordMatchError] = useState(false);
  const [successMessage, setSuccessMessage] = useState('');
  const [errorMessage, setErrorMessage] = useState('');

  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
  
    if (password !== confirmPassword) {
      setPasswordMatchError(true);
      setErrorMessage('');
      return;
    }

    setLoading(true);

    const config = {
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
    };

    const hashedValue = await sha512(password)
    let admin_id = 1
    let is_admin = false
    const body = JSON.stringify({ name, email, hashedValue, admin_id, is_admin });

    try {
      const res = await axios.post('http://51.20.117.162:8000/web_register', body, config);

      if (res.data.message === "Success") {
        setSuccessMessage("Account successfully created!");
        navigate('/signInPage');
      } else {
        setErrorMessage(`Error creating account: ${res.data.message}`);
        setSuccessMessage('');
      }
      setLoading(false);
    } catch (err) {
      console.error(err);
      setErrorMessage("Failed to create account. Please try again.");
      setSuccessMessage('');
      setLoading(false);
    }
  };

  return (
    <div className="container">
      <div className="signin-image"></div>
      <div className="signup-form">
        <form onSubmit={handleSubmit}>
          <input
            type="text"
            name="name"
            placeholder="Name"
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
          />
          <input
            type="email"
            name="email"
            placeholder="Email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
          <input
            type="password"
            name="password"
            placeholder="Password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
          <input
            type="password"
            name="confirmPassword"
            placeholder="Confirm Password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            required
          />

          {passwordMatchError && (
            <p className="error-message">Password and Confirm Password do not match.</p>
          )}

          {successMessage && (
            <p className="success-message">{successMessage}</p>
          )}

          {errorMessage && (
            <p className="error-message">{errorMessage}</p>
          )}

          <button type="submit" disabled={loading}>
            Create Account
          </button>
        </form>

        <div className="signin-link">
          <Link to="/signInPage">Already have an account? Sign In</Link>
        </div>
      </div>
    </div>
  );
};

export default EmployeeSignUp;

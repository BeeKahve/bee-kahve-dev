import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

const EmployeeSignUp = () => {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [passwordMatchError, setPasswordMatchError] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Check if password and confirm password match
    if (password !== confirmPassword) {
      setPasswordMatchError(true);
      return;
    }

    setLoading(true);

    // Add validation logic if needed

    const config = {
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
    };

    const body = JSON.stringify({ name, email, password, confirmPassword });
    console.log(body);

    try {
      const res = await axios.post('http://51.20.117.162:8000/signup', body, config);
      console.log(res);
      setLoading(false);
    } catch (err) {
      console.log(err);
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

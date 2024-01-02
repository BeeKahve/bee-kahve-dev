// Novruz Amirov: 150200903
// Software Engineerin - BLG 411E - 2023/2024 - Semester Project
// employeeSignUp.js -> to register an employee

import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import { sha512 } from 'crypto-hash';
import { useNavigate } from 'react-router-dom';
import { css } from '@emotion/react';
import { BarLoader } from 'react-spinners';

const override = css`
  display: block;
  margin: 0 auto;
  border-color: red;
`;

const EmployeeSignUp = () => {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [passwordMatchError, setPasswordMatchError] = useState(false);
  const [passwordComplexityError, setPasswordComplexityError] = useState(false);
  const [successMessage, setSuccessMessage] = useState('');
  const [errorMessage, setErrorMessage] = useState('');
  const [registerPass, setRegisterPass] = useState('');
  const navigate = useNavigate();

  const checkPasswordComplexity = (pwd) => {
    // password complexity regex for at least 8 chars, 1 lower 1 upper and 1 digit
    const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;
    return regex.test(pwd);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (password !== confirmPassword) {
      setPasswordMatchError(true);
      setPasswordComplexityError(false);
      setErrorMessage('');
      return;
    }

    if (!checkPasswordComplexity(password)) {
      setPasswordMatchError(false);
      setPasswordComplexityError(true);
      setErrorMessage('Password must be at least 8 characters, include at least one lowercase letter, one uppercase letter, and one digit.');
      return;
    }
    
    const config = {
      headers: {
        accept: 'application/json',
        'Content-Type': 'application/json',
      },
    };

    const hashedValue = await sha512(password);
    let admin_id = 1;
    let is_admin = false;
    const body = JSON.stringify({ name, email, hashedValue, admin_id, is_admin });

    try {
      const hashedRegister = await sha512(registerPass);
      if(hashedRegister !== '1cbc282b219ce3a9f2e5b9ee9cc25648cfcc078e39b8ac43dc0041e56389a64ddb0ec51ad6c5920e565aec27403a1b27b7fd93b9c298c4b54ab98475e4209d67'){
        setErrorMessage('Register password is incorrect. Registration without it is not possible');
        return;
      }

      setLoading(true);
      const res = await axios.post('http://51.20.117.162:8000/web_register', body, config);

      if (res.data.message === 'Success') {
        setSuccessMessage('Account successfully created!');
        navigate('/signInPage');
      } else {
        setErrorMessage(`Error creating account: ${res.data.message}`);
        setSuccessMessage('');
      }
    } catch (err) {
      console.error(err);
      setErrorMessage('Failed to create an account. Please try again.');
      setSuccessMessage('');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container">
      <div className="signin-image"></div>
      <div className="signup-form">
        {loading && (
          <div className="loading-spinner">
            <BarLoader css={override} loading={loading} size={150} color={'#36D7B7'} />
          </div>
        )}
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
          <input
            type="password"
            name="registerPass"
            placeholder="Please enter a register password to create account"
            value={registerPass}
            onChange={(e) => setRegisterPass(e.target.value)}
            required
          />
          {passwordMatchError && (
            <p className="error-message">Password and Confirm Password do not match.</p>
          )}
          {passwordComplexityError && (
            <p className="error-message">Password must be at least 8 characters, include at least one lowercase letter, one uppercase letter, and one digit.</p>
          )}
          {successMessage && (
            <p className="success-message">{successMessage}</p>
          )}
          {errorMessage && (
            <p className="error-message">{errorMessage}</p>
          )}
          <button type="submit" disabled={loading}>
            {loading ? 'Creating Account...' : 'Create Account'}
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
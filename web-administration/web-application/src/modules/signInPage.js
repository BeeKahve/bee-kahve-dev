// SignIn.js
import React, { useState } from 'react';
import { Link } from 'react-router-dom'; // Import Link from react-router-dom
import axios from 'axios';

const SignIn = () => {
  const [employeeAdmin, setEmployeeAdmin] = useState('employee');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    const config = {
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
    };

    const body = JSON.stringify({ email, password });
    console.log(body);

    try {
      const res = await axios.post('http://51.20.117.162:8000/login', body, config);
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
      <div className="signin-form">
        <div className="radio-btn">
          <input
            type="radio"
            id="employee"
            name="employeeAdmin"
            value="employee"
            checked={employeeAdmin === 'employee'}
            onChange={(e) => setEmployeeAdmin(e.target.value)}
          />
          <label className="Employee" htmlFor="employee">Employee</label>
          <input
            type="radio"
            id="admin"
            name="employeeAdmin"
            value="admin"
            checked={employeeAdmin === 'admin'}
            onChange={(e) => setEmployeeAdmin(e.target.value)}
          />
          <label className="Admin" htmlFor="admin">Admin</label>
        </div>
        <form onSubmit={handleSubmit}>
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
          <button type="submit" disabled={loading}>
            Sign In
          </button>
        </form>
       
      </div>
      <div className="employee-signup-link">
          <Link to="/employeeSignUp">Employee SignUp</Link>
        </div>
    </div>
  );
};

export default SignIn;

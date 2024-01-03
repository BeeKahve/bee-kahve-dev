// Novruz Amirov: 150200903
// Software Engineerin - BLG 411E - 2023/2024 - Semester Project
// signInPage.js -> First page welcomes the user of the web page asks his credentials if exist

import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import axios from 'axios';
import { sha512 } from 'crypto-hash';
import { css } from '@emotion/react';
import { BarLoader } from 'react-spinners';

const override = css`
  display: block;
  margin: 0 auto;
  border-color: red;
`;

const SignIn = () => {
  const navigate = useNavigate();
  const [employeeAdmin, setEmployeeAdmin] = useState('employee');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // Check if the user has a valid token or role for employee
    const token = localStorage.getItem('token');
    const name = localStorage.getItem('name');

    try{
      if(!token){
        navigate('/signInPage'); // Redirect to sign-in if not authenticated as employee
      }

      // admin token
      else if(token === 'b1d632f26e83babf1c80709208e1b6ed01312cc94860c327d82107ff3f073e65e81f902169d4ddfe3f837f8297ea8d80085f0ed1f6fc6ee7a84e0383abadf5ba'){
        navigate('/adminPage')
      }

      // any different token but name means employee
      else if (token && name) {
        navigate(`/employeePage`, { state: { employeeName: name } });
      } 
      
      // else then wrong credentials
      else {
        navigate('/signInPage'); // Redirect to sign-in if not authenticated as employee
      }
    }
    catch{
      navigate('/signInPage'); // Redirect to sign-in if not authenticated as employee
    }
  }, [navigate]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    const config = {
      headers: {
        accept: 'application/json',
        'Content-Type': 'application/json',
      },
    };

    let is_admin = false;
    const hashedValue = await sha512(password);

    if (employeeAdmin === 'admin') {
      is_admin = true;
    }

    const body = JSON.stringify({ is_admin, email, hashedValue });

    try {
      setLoading(true)
      // const res = await axios.post('http://51.20.117.162:8000/web_login', body, config);
      const res = await axios.post('www.bee-kahve-dev.vercel.app/web_login', body, config);
      console.log(res)

      if (res.data.email !== null) {
        localStorage.setItem('token', hashedValue);
      }

      if (is_admin && localStorage.getItem('token') === 'b1d632f26e83babf1c80709208e1b6ed01312cc94860c327d82107ff3f073e65e81f902169d4ddfe3f837f8297ea8d80085f0ed1f6fc6ee7a84e0383abadf5ba') {
        navigate(`/adminPage`);
      } else if (!is_admin && res.data.email !== null) {
        localStorage.setItem('token', hashedValue);
        localStorage.setItem('name', res.data.name)
        navigate(`/employeePage`, { state: { employeeName: res.data.name } });
      } else {
        navigate(`/signInPage`);
      }

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
            {loading ? (
              <BarLoader css={override} loading={loading} size={150} color={'#36D7B7'} />
            ) : (
              'Sign In'
            )}
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
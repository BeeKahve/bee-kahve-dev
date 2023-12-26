import React, { useState } from 'react';
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
        'Content-Type': 'application/json',
      },
    };

    const body = JSON.stringify({ employeeAdmin, email, password });

    try {
      const res = await axios.post('/api/auth/signin', body, config);
      console.log(res.data);
      setLoading(false);
    } catch (err) {
      console.log(err.response.data);
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
    </div>
 );
};

export default SignIn;
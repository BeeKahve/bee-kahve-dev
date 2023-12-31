// Novruz Amirov: 150200903
// Software Engineerin - BLG 411E - 2023/2024 - Semester Project
// App.js where all pages combines and routings are handled properly

import './App.css';
import EmployeePage from './modules/employeePage';
import SignIn from './modules/signInPage';
import EmployeeSignUp from './modules/employeeSignUp'; // Adjust the path accordingly
import AdminPage from './modules/adminPage'
import AddCoffee from './modules/addCoffee';
import ModifyStock from './modules/modifyStock';
import UpdateStatus from './modules/updateStatus';
import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';


function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Navigate to="/signInPage" />} />
        <Route path="/signInPage" element={<SignIn />} />
        <Route path="/employeeSignUp" element={<EmployeeSignUp />} />
        <Route path="/adminPage" element={<AdminPage />} />
        <Route path="/addCoffee" element={<AddCoffee />} />
        <Route path="/modifyStock" element={<ModifyStock />} />
        <Route path="/employeePage" element={<EmployeePage />} />
        <Route path="/updateStatus" element={<UpdateStatus />} />
      </Routes>
    </Router>
  );
}

export default App;

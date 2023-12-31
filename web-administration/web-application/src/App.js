import './App.css';
import SignIn from './modules/signInPage';
import EmployeeSignUp from './modules/employeeSignUp'; // Adjust the path accordingly
import AdminPage from './modules/adminPage'
import AddCoffee from './modules/addCoffee';
import ModifyStock from './modules/modifyStock';
import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
// import { Link } from 'react-router-dom';

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
      </Routes>
    </Router>
  );
}

export default App;

import React, { useState } from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import UsersManagement from './components/UsersManagement';
import CoachesManagement from './components/CoachesManagement';
import ContractsManagement from './components/ContractsManagement';
import './App.css';

function App() {
  return (
    <Router>
      <div className="admin-panel">
        <div className="sidebar">
          <div className="sidebar-header">
            <h2>FitFusion Admin</h2>
          </div>
          <nav className="sidebar-nav">
            <ul>
              <li>
                <Link to="/">
                  <i className="fas fa-user"></i> Quản lý Người dùng
                </Link>
              </li>
              <li>
                <Link to="/coaches">
                  <i className="fas fa-dumbbell"></i> Quản lý Huấn luyện viên
                </Link>
              </li>
              <li>
                <Link to="/contracts">
                  <i className="fas fa-file-contract"></i> Quản lý Hợp đồng
                </Link>
              </li>
            </ul>
          </nav>
        </div>
        <div className="content">
          <Routes>
            <Route path="/" element={<UsersManagement />} />
            <Route path="/coaches" element={<CoachesManagement />} />
            <Route path="/contracts" element={<ContractsManagement />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
}

export default App;
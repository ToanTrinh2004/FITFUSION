import React from "react";
import { Link } from "react-router-dom";

const Sidebar = () => (
  <div className="sidebar">
    <h2>Admin Panel</h2>
    <ul>
      <li><Link to="/dashboard">Dashboard</Link></li>
      <li><Link to="/users">Người dùng</Link></li>
      <li><Link to="/exercises">Bài tập</Link></li>
      <li><Link to="/trainers">Huấn luyện viên</Link></li>
    </ul>
  </div>
);

export default Sidebar;

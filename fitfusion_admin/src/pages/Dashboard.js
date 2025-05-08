import React, { useEffect, useState } from "react";

const Dashboard = () => {
  const [stats, setStats] = useState({ users: 0, exercises: 0, trainers: 0 });

  useEffect(() => {
    // Giả lập API call
    fetch("/api/admin/stats")
      .then(res => res.json())
      .then(data => setStats(data));
  }, []);

  return (
    <div className="dashboard">
      <h2>Dashboard</h2>
      <div className="cards">
        <div className="card">👥 Người dùng: {stats.users}</div>
        <div className="card">🏋️‍♀️ Bài tập: {stats.exercises}</div>
        <div className="card">🧑‍🏫 Huấn luyện viên: {stats.trainers}</div>
      </div>
    </div>
  );
};

export default Dashboard;

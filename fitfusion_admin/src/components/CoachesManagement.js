import React, { useState, useEffect } from 'react';
import { mockCoaches } from '../data/mockData';
import CoachForm from './CoachForm';

function CoachesManagement() {
  const [coaches, setCoaches] = useState([]);
  const [editingCoach, setEditingCoach] = useState(null);
  const [isFormOpen, setIsFormOpen] = useState(false);

  useEffect(() => {
    // Tải dữ liệu huấn luyện viên mẫu
    setCoaches(mockCoaches);
  }, []);

  const handleDelete = (coachId) => {
    if (window.confirm('Bạn có chắc chắn muốn xóa huấn luyện viên này?')) {
      setCoaches(coaches.filter(coach => coach.id !== coachId));
    }
  };

  const handleEdit = (coach) => {
    setEditingCoach(coach);
    setIsFormOpen(true);
  };

  const handleFormSubmit = (coachData) => {
    if (editingCoach) {
      // Cập nhật huấn luyện viên
      setCoaches(coaches.map(coach => 
        coach.id === coachData.id ? coachData : coach
      ));
    } else {
      // Thêm huấn luyện viên mới
      setCoaches([...coaches, { ...coachData, id: Date.now().toString() }]);
    }
    setIsFormOpen(false);
    setEditingCoach(null);
  };

  const handleFormCancel = () => {
    setIsFormOpen(false);
    setEditingCoach(null);
  };

  return (
    <div className="coaches-management">
      <div className="page-header">
        <h1>Quản lý Huấn luyện viên</h1>
        <button 
          className="btn btn-primary" 
          onClick={() => setIsFormOpen(true)}
        >
          Thêm huấn luyện viên
        </button>
      </div>

      {isFormOpen && (
        <CoachForm 
          coach={editingCoach} 
          onSubmit={handleFormSubmit} 
          onCancel={handleFormCancel}
        />
      )}

      <div className="table-container">
        <table className="data-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Tài khoản</th>
              <th>Họ tên</th>
              <th>Học viên</th>
              <th>Thao tác</th>
            </tr>
          </thead>
          <tbody>
            {coaches.map(coach => (
              <tr key={coach.id}>
                <td>{coach.id}</td>
                <td>{coach.username}</td>
                <td>{coach.fullname}</td>
                <td>{coach.mystudents ? coach.mystudents.join(', ') : 'Chưa có học viên'}</td>
                <td>
                  <button 
                    className="btn btn-sm btn-edit"
                    onClick={() => handleEdit(coach)}
                  >
                    Sửa
                  </button>
                  <button 
                    className="btn btn-sm btn-delete"
                    onClick={() => handleDelete(coach.id)}
                  >
                    Xóa
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default CoachesManagement;
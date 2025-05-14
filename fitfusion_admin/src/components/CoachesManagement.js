import React, { useState, useEffect } from 'react';
import axios from 'axios';
import CoachForm from './CoachForm';

function CoachesManagement() {
  const [coaches, setCoaches] = useState([]);
  const [editingCoach, setEditingCoach] = useState(null);
  const [isFormOpen, setIsFormOpen] = useState(false);

  useEffect(() => {
    // Fetch coaches from the API
    const fetchCoaches = async () => {
      try {
        const response = await axios.get('http://localhost:3000/api/user/users');
        if (response.data.status) {
          // Filter users with role 2 (coaches)
          const filteredCoaches = response.data.data.filter(user => user.role === 2);
          setCoaches(filteredCoaches);
        } else {
          console.error('Failed to fetch coaches:', response.data);
        }
      } catch (error) {
        console.error('Error fetching coaches:', error);
      }
    };

    fetchCoaches();
  }, []);

  const handleDelete = async (coachId) => {
    if (window.confirm('Bạn có chắc chắn muốn xóa huấn luyện viên này?')) {
      try {
        await axios.delete(`http://localhost:3000/api/user/delete`, {
          data: { userId: coachId }, // Send userId in the request body
        });
        setCoaches(coaches.filter(coach => coach.userId !== coachId));
        alert('Huấn luyện viên đã được xóa thành công.');
      } catch (error) {
        console.error('Error deleting coach:', error);
        alert('Không thể xóa huấn luyện viên. Vui lòng thử lại sau.');
      }
    }
  };

  const handleEdit = (coach) => {
    setEditingCoach(coach);
    setIsFormOpen(true);
  };

  const handleFormSubmit = (coachData) => {
    if (editingCoach) {
      // Update coach logic
      setCoaches(coaches.map(coach => (coach.userId === coachData.userId ? coachData : coach)));
    } else {
      // Add new coach logic
      setCoaches([...coaches, { ...coachData, userId: Date.now().toString() }]);
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
              <th>Thao tác</th>
            </tr>
          </thead>
          <tbody>
            {coaches.map(coach => (
              <tr key={coach.userId}>
                <td>{coach.userId}</td>
                <td>{coach.username}</td>
                <td>
                  <button 
                    className="btn btn-sm btn-edit"
                    onClick={() => handleEdit(coach)}
                  >
                    Sửa
                  </button>
                  <button 
                    className="btn btn-sm btn-delete"
                    onClick={() => handleDelete(coach.userId)}
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
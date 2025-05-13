import React, { useState, useEffect } from 'react';
import { mockUsers } from '../data/mockData';

function CoachForm({ coach = null, onSubmit, onCancel }) {
  const [formData, setFormData] = useState({
    id: '',
    username: '',
    fullname: '',
    mystudents: []
  });
  const [users, setUsers] = useState([]);
  const [selectedStudents, setSelectedStudents] = useState([]);

  useEffect(() => {
    // Tải danh sách người dùng để lựa chọn học viên
    setUsers(mockUsers);
    
    // Nếu đang chỉnh sửa, điền thông tin huấn luyện viên
    if (coach) {
      setFormData(coach);
      setSelectedStudents(coach.mystudents || []);
    }
  }, [coach]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleStudentChange = (e) => {
    const selectedOptions = Array.from(
      e.target.selectedOptions,
      option => option.value
    );
    setSelectedStudents(selectedOptions);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit({ 
      ...formData, 
      mystudents: selectedStudents 
    });
  };

  return (
    <div className="form-overlay">
      <div className="coach-form">
        <h2>{coach ? 'Chỉnh sửa Huấn luyện viên' : 'Thêm Huấn luyện viên'}</h2>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="username">Tài khoản:</label>
            <input 
              type="text" 
              id="username"
              name="username"
              value={formData.username}
              onChange={handleChange}
              required
            />
          </div>
          
          <div className="form-group">
            <label htmlFor="fullname">Họ tên:</label>
            <input 
              type="text" 
              id="fullname"
              name="fullname"
              value={formData.fullname}
              onChange={handleChange}
              required
            />
          </div>
          
          <div className="form-group">
            <label htmlFor="mystudents">Học viên:</label>
            <select
              id="mystudents"
              name="mystudents"
              multiple
              value={selectedStudents}
              onChange={handleStudentChange}
              className="multi-select"
            >
              {users.map(user => (
                <option key={user.id} value={user.fullname}>
                  {user.fullname}
                </option>
              ))}
            </select>
            <small>Giữ Ctrl để chọn nhiều học viên</small>
          </div>
          
          <div className="form-actions">
            <button type="submit" className="btn btn-primary">
              {coach ? 'Cập nhật' : 'Thêm mới'}
            </button>
            <button 
              type="button" 
              className="btn btn-secondary"
              onClick={onCancel}
            >
              Hủy
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default CoachForm;
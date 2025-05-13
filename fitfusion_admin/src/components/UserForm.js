import React, { useState, useEffect } from 'react';
import { mockCoaches } from '../data/mockData';

function UserForm({ user = null, onSubmit, onCancel }) {
  const [formData, setFormData] = useState({
    id: '',
    username: '',
    fullname: '',
    mycoach: ''
  });
  const [coaches, setCoaches] = useState([]);

  useEffect(() => {
    // Tải danh sách huấn luyện viên để lựa chọn
    setCoaches(mockCoaches);
    
    // Nếu đang chỉnh sửa, điền thông tin người dùng
    if (user) {
      setFormData(user);
    }
  }, [user]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(formData);
  };

  return (
    <div className="form-overlay">
      <div className="user-form">
        <h2>{user ? 'Chỉnh sửa Người dùng' : 'Thêm Người dùng'}</h2>
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
            <label htmlFor="mycoach">Huấn luyện viên:</label>
            <select
              id="mycoach"
              name="mycoach"
              value={formData.mycoach || ''}
              onChange={handleChange}
            >
              <option value="">Không có huấn luyện viên</option>
              {coaches.map(coach => (
                <option key={coach.id} value={coach.fullname}>
                  {coach.fullname}
                </option>
              ))}
            </select>
          </div>
          
          <div className="form-actions">
            <button type="submit" className="btn btn-primary">
              {user ? 'Cập nhật' : 'Thêm mới'}
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

export default UserForm;
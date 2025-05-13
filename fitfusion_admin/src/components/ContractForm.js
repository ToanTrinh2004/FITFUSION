import React, { useState, useEffect } from 'react';
import { mockCoaches, mockUsers } from '../data/mockData';

function ContractForm({ contract = null, onSubmit, onCancel }) {
  const [formData, setFormData] = useState({
    id: '',
    coachName: '',
    userName: '',
    trainingType: '',
    trainingDuration: '',
    contractEndDate: '',
    contractValue: ''
  });
  
  const [coaches, setCoaches] = useState([]);
  const [users, setUsers] = useState([]);
  const [trainingTypes] = useState([
    'Yoga', 'Pilates', 'Gym cá nhân', 'Boxing', 'Cardio', 
    'Zumba', 'Bơi lội', 'CrossFit', 'Thiền', 'Kickboxing'
  ]);
  const [durations] = useState([
    '1 tháng', '2 tháng', '3 tháng', '4 tháng', '6 tháng', '12 tháng'
  ]);

  useEffect(() => {
    // Tải danh sách huấn luyện viên và học viên
    setCoaches(mockCoaches);
    setUsers(mockUsers);
    
    // Nếu đang chỉnh sửa, điền thông tin hợp đồng
    if (contract) {
      setFormData(contract);
    }
  }, [contract]);

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

  // Tạo giá trị mặc định cho hợp đồng dựa trên thời gian đào tạo
  const generateContractValue = (duration) => {
    const baseRate = 2000000; // 2,000,000 VND cho 1 tháng
    let months = 1;
    
    if (duration.includes('tháng')) {
      months = parseInt(duration.split(' ')[0], 10);
    }
    
    const value = baseRate * months;
    return value.toLocaleString('vi-VN') + ' VND';
  };

  const handleDurationChange = (e) => {
    const duration = e.target.value;
    setFormData(prev => ({
      ...prev,
      trainingDuration: duration,
      contractValue: generateContractValue(duration)
    }));
  };

  return (
    <div className="form-overlay">
      <div className="contract-form">
        <h2>{contract ? 'Chỉnh sửa Hợp đồng' : 'Thêm Hợp đồng mới'}</h2>
        <form onSubmit={handleSubmit}>
          <div className="form-row">
            <div className="form-group">
              <label htmlFor="coachName">Huấn luyện viên:</label>
              <select
                id="coachName"
                name="coachName"
                value={formData.coachName}
                onChange={handleChange}
                required
              >
                <option value="">-- Chọn Huấn luyện viên --</option>
                {coaches.map(coach => (
                  <option key={coach.id} value={coach.fullname}>
                    {coach.fullname}
                  </option>
                ))}
              </select>
            </div>
            
            <div className="form-group">
              <label htmlFor="userName">Học viên:</label>
              <select
                id="userName"
                name="userName"
                value={formData.userName}
                onChange={handleChange}
                required
              >
                <option value="">-- Chọn Học viên --</option>
                {users.map(user => (
                  <option key={user.id} value={user.fullname}>
                    {user.fullname}
                  </option>
                ))}
              </select>
            </div>
          </div>
          
          <div className="form-row">
            <div className="form-group">
              <label htmlFor="trainingType">Bộ môn đào tạo:</label>
              <select
                id="trainingType"
                name="trainingType"
                value={formData.trainingType}
                onChange={handleChange}
                required
              >
                <option value="">-- Chọn Bộ môn --</option>
                {trainingTypes.map((type, index) => (
                  <option key={index} value={type}>
                    {type}
                  </option>
                ))}
              </select>
            </div>
            
            <div className="form-group">
              <label htmlFor="trainingDuration">Thời gian đào tạo:</label>
              <select
                id="trainingDuration"
                name="trainingDuration"
                value={formData.trainingDuration}
                onChange={handleDurationChange}
                required
              >
                <option value="">-- Chọn Thời gian --</option>
                {durations.map((duration, index) => (
                  <option key={index} value={duration}>
                    {duration}
                  </option>
                ))}
              </select>
            </div>
          </div>
          
          <div className="form-row">
            <div className="form-group">
              <label htmlFor="contractEndDate">Thời hạn hợp đồng:</label>
              <input 
                type="date" 
                id="contractEndDate"
                name="contractEndDate"
                value={formData.contractEndDate}
                onChange={handleChange}
                required
              />
            </div>
            
            <div className="form-group">
              <label htmlFor="contractValue">Giá trị hợp đồng:</label>
              <input 
                type="text" 
                id="contractValue"
                name="contractValue"
                value={formData.contractValue}
                onChange={handleChange}
                required
              />
            </div>
          </div>
          
          <div className="form-actions">
            <button type="submit" className="btn btn-primary">
              {contract ? 'Cập nhật' : 'Thêm mới'}
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

export default ContractForm;
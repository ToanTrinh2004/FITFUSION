import React, { useState, useEffect } from 'react';
import { mockUsers } from '../data/mockData';
import UserForm from './UserForm';

function UsersManagement() {
  const [users, setUsers] = useState([]);
  const [editingUser, setEditingUser] = useState(null);
  const [isFormOpen, setIsFormOpen] = useState(false);

  useEffect(() => {
    // Tải dữ liệu người dùng mẫu
    setUsers(mockUsers);
  }, []);

  const handleDelete = (userId) => {
    if (window.confirm('Bạn có chắc chắn muốn xóa người dùng này?')) {
      setUsers(users.filter(user => user.id !== userId));
    }
  };

  const handleEdit = (user) => {
    setEditingUser(user);
    setIsFormOpen(true);
  };

  const handleFormSubmit = (userData) => {
    if (editingUser) {
      // Cập nhật người dùng
      setUsers(users.map(user => 
        user.id === userData.id ? userData : user
      ));
    } else {
      // Thêm người dùng mới
      setUsers([...users, { ...userData, id: Date.now().toString() }]);
    }
    setIsFormOpen(false);
    setEditingUser(null);
  };

  const handleFormCancel = () => {
    setIsFormOpen(false);
    setEditingUser(null);
  };

  return (
    <div className="users-management">
      <div className="page-header">
        <h1>Quản lý Người dùng</h1>
        <button 
          className="btn btn-primary" 
          onClick={() => setIsFormOpen(true)}
        >
          Thêm người dùng
        </button>
      </div>

      {isFormOpen && (
        <UserForm 
          user={editingUser} 
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
              <th>Huấn luyện viên</th>
              <th>Thao tác</th>
            </tr>
          </thead>
          <tbody>
            {users.map(user => (
              <tr key={user.id}>
                <td>{user.id}</td>
                <td>{user.username}</td>
                <td>{user.fullname}</td>
                <td>{user.mycoach || 'Chưa có'}</td>
                <td>
                  <button 
                    className="btn btn-sm btn-edit"
                    onClick={() => handleEdit(user)}
                  >
                    Sửa
                  </button>
                  <button 
                    className="btn btn-sm btn-delete"
                    onClick={() => handleDelete(user.id)}
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

export default UsersManagement;

import React, { useState, useEffect } from 'react';
import axios from 'axios';
import UserForm from './UserForm';

function UsersManagement() {
  const [users, setUsers] = useState([]);
  const [editingUser, setEditingUser] = useState(null);
  const [isFormOpen, setIsFormOpen] = useState(false);

  useEffect(() => {
    // Fetch users from the API
    const fetchUsers = async () => {
      try {
        const response = await axios.get('http://localhost:3000/api/user/users');
        if (response.data.status) {
          // Filter users with role 1
          const filteredUsers = response.data.data.filter(user => user.role === 1);
          setUsers(filteredUsers);
          console.log('Fetched users:', filteredUsers);
        } else {
          console.error('Failed to fetch users:', response.data);
        }
      } catch (error) {
        console.error('Error fetching users:', error);
      }
    };

    fetchUsers();
  }, []);

  const handleDelete = async (userId) => {
    if (window.confirm('Bạn có chắc chắn muốn xóa người dùng này?')) {
      try {
        await axios.delete(`http://localhost:3000/api/user/delete`, {
          data: { userId }, // Send userId in the request body
        });
        setUsers(users.filter(user => user.userId !== userId));
        alert('Người dùng đã được xóa thành công.');
      } catch (error) {
        console.error('Error deleting user:', error);
        alert('Không thể xóa người dùng. Vui lòng thử lại sau.');
      }
    }
  };

  const handleEdit = (user) => {
    setEditingUser(user);
    setIsFormOpen(true);
  };

  const handleFormSubmit = (userData) => {
    if (editingUser) {
      // Update user logic
      setUsers(users.map(user => (user.userId === userData.userId ? userData : user)));
    } else {
      // Add new user logic
      setUsers([...users, { ...userData, userId: Date.now().toString() }]);
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
              <th>Thao tác</th>
            </tr>
          </thead>
          <tbody>
            {users.map(user => (
              <tr key={user.userId}>
                <td>{user.userId}</td>
                <td>{user.username}</td>
                <td>
                  <button 
                    className="btn btn-sm btn-edit"
                    onClick={() => handleEdit(user)}
                  >
                    Sửa
                  </button>
                  <button 
                    className="btn btn-sm btn-delete"
                    onClick={() => handleDelete(user.userId)}
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
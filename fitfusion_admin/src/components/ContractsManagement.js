import React, { useState, useEffect } from 'react';
import axios from 'axios';
import ContractForm from './ContractForm';

function ContractsManagement() {
  const [contracts, setContracts] = useState([]);
  const [editingContract, setEditingContract] = useState(null);
  const [isFormOpen, setIsFormOpen] = useState(false);

  useEffect(() => {
    // Fetch contracts from the API
    const fetchContracts = async () => {
      try {
        const response = await axios.get('http://localhost:3000/api/contract/contracts');
        if (response.data.success) {
          setContracts(response.data.contracts);
        } else {
          console.error('Failed to fetch contracts:', response.data);
        }
      } catch (error) {
        console.error('Error fetching contracts:', error);
      }
    };

    fetchContracts();
  }, []);

  const handleDelete = async (contractId) => {
    if (window.confirm('Bạn có chắc chắn muốn xóa hợp đồng này?')) {
      try {
        // Pass the contractId as a URL parameter
        await axios.delete(`http://localhost:3000/api/contract/contracts/${contractId}`);
        
        // Update state to remove the deleted contract
        setContracts(contracts.filter(contract => contract._id !== contractId));
        alert('Hợp đồng đã được xóa thành công.');
      } catch (error) {
        console.error('Error deleting contract:', error);
        alert('Không thể xóa hợp đồng. Vui lòng thử lại sau.');
      }
    }
  };
  const handleEdit = (contract) => {
    setEditingContract(contract);
    setIsFormOpen(true);
  };

  const handleFormSubmit = (contractData) => {
    if (editingContract) {
      // Update contract logic
      setContracts(contracts.map(contract => (contract._id === contractData._id ? contractData : contract)));
    } else {
      // Add new contract logic
      setContracts([...contracts, { ...contractData, _id: Date.now().toString() }]);
    }
    setIsFormOpen(false);
    setEditingContract(null);
  };

  const handleFormCancel = () => {
    setIsFormOpen(false);
    setEditingContract(null);
  };

  return (
    <div className="contracts-management">
      <div className="page-header">
        <h1>Quản lý Hợp đồng</h1>
        <button 
          className="btn btn-primary" 
          onClick={() => setIsFormOpen(true)}
        >
          Thêm hợp đồng mới
        </button>
      </div>

      {isFormOpen && (
        <ContractForm 
          contract={editingContract} 
          onSubmit={handleFormSubmit} 
          onCancel={handleFormCancel}
        />
      )}

      <div className="table-container">
        <table className="data-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Huấn luyện viên</th>
              <th>Học viên</th>
              <th>Thời gian đào tạo</th>
              <th>Giá trị</th>
              <th>Lịch trình</th>
              <th>Thao tác</th>
            </tr>
          </thead>
          <tbody>
            {contracts.map(contract => (
              <tr key={contract._id}>
                <td>{contract._id}</td>
                <td>{contract.coachName}</td>
                <td>{contract.customerName}</td>
                <td>{contract.duration}</td>
                <td>{contract.fee.toLocaleString('vi-VN')} đ</td>
                <td>
                  {contract.schedule.map(scheduleItem => (
                    <div key={scheduleItem._id}>
                      {scheduleItem.day} - {scheduleItem.time}
                    </div>
                  ))}
                </td>
                <td>
                  <button 
                    className="btn btn-sm btn-edit"
                    onClick={() => handleEdit(contract)}
                  >
                    Sửa
                  </button>
                  <button 
                    className="btn btn-sm btn-delete"
                    onClick={() => handleDelete(contract._id)}
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

export default ContractsManagement;
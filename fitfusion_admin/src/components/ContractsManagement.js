import React, { useState, useEffect } from 'react';
import { mockContracts, mockCoaches, mockUsers } from '../data/mockData';
import ContractForm from './ContractForm';

function ContractsManagement() {
  const [contracts, setContracts] = useState([]);
  const [editingContract, setEditingContract] = useState(null);
  const [isFormOpen, setIsFormOpen] = useState(false);

  useEffect(() => {
    // Tải dữ liệu hợp đồng mẫu
    setContracts(mockContracts);
  }, []);

  const handleDelete = (contractId) => {
    if (window.confirm('Bạn có chắc chắn muốn xóa hợp đồng này?')) {
      setContracts(contracts.filter(contract => contract.id !== contractId));
    }
  };

  const handleEdit = (contract) => {
    setEditingContract(contract);
    setIsFormOpen(true);
  };

  const handleFormSubmit = (contractData) => {
    if (editingContract) {
      // Cập nhật hợp đồng
      setContracts(contracts.map(contract => 
        contract.id === contractData.id ? contractData : contract
      ));
    } else {
      // Thêm hợp đồng mới
      setContracts([...contracts, { ...contractData, id: Date.now().toString() }]);
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
              <th>Bộ môn</th>
              <th>Thời gian đào tạo</th>
              <th>Thời hạn hợp đồng</th>
              <th>Giá trị</th>
              <th>Thao tác</th>
            </tr>
          </thead>
          <tbody>
            {contracts.map(contract => (
              <tr key={contract.id}>
                <td>{contract.id}</td>
                <td>{contract.coachName}</td>
                <td>{contract.userName}</td>
                <td>{contract.trainingType}</td>
                <td>{contract.trainingDuration}</td>
                <td>{contract.contractEndDate}</td>
                <td>{contract.contractValue}</td>
                <td>
                  <button 
                    className="btn btn-sm btn-edit"
                    onClick={() => handleEdit(contract)}
                  >
                    Sửa
                  </button>
                  <button 
                    className="btn btn-sm btn-delete"
                    onClick={() => handleDelete(contract.id)}
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
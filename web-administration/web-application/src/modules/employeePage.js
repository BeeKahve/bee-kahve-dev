// employeePage.js
import React, { useState, useEffect } from 'react';
import { Button, Table, Modal, Form, Input } from 'antd';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const { Column } = Table;

const EmployeePage = () => {
  const [orderList, setOrderList] = useState([]);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [modalTitle, setModalTitle] = useState('');
  const [selectedOrder, setSelectedOrder] = useState({});
  const [employeeName, setEmployeeName] = useState('Employee Novruz'); // Replace with the actual employee name

  const navigate = useNavigate();

//   useEffect(() => {
//     // Check if the user has a valid token or role for employee
//     const token = localStorage.getItem('token');
//     const role = localStorage.getItem('role');

//     if (token && role === 'employee') {
//       fetchOrderList();
//     } else {
//       navigate('/signInPage'); // Redirect to sign-in if not authenticated as employee
//     }
//   }, []);

  const fetchOrderList = async () => {
    try {
      const response = await axios.get('/api/orders');
      setOrderList(response.data);
    } catch (error) {
      console.error('Error fetching order list:', error);
    }
  };

  const handleExitAccount = () => {
    localStorage.removeItem('token');
    navigate('/signInPage');
  };

  const showModal = (title, order) => {
    setIsModalVisible(true);
    setModalTitle(title);
    setSelectedOrder(order);
  };

  const handleCancel = () => {
    setIsModalVisible(false);
  };

  const handleConfirmOrder = () => {
    // Logic for confirming order
  };

//   const handleCancelOrder = () => {
//     // Logic for canceling order
//   };

  const handleUpdateStatus = () => {
    // Redirect to /updateStatus when Update Order Status button is clicked
    navigate('/updateStatus');
  };

  return (
    <div className="employeePage">
      <div className="left-sidebar">
        <h1 style={{ color: 'white', marginLeft: '20%' }}>Employee</h1>
        <div className={`menu-stock-header active`} onClick={fetchOrderList}>
          <h4 style={{ color: 'black' }}>Confirm Order</h4>
        </div>
        <div className={`menu-stock-header`} onClick={handleUpdateStatus}>
          <h4 style={{ color: 'black' }}>Update Order Status</h4>
        </div>
        <Button className="exit-account" type="danger" onClick={() => handleExitAccount()}>
          <h4>Exit Account</h4>
        </Button>
      </div>
      <div className="right-content">
        <div className="upper-content" style={{ height: '15%', display: 'flex', flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', width: '80vw' }}>
          <h1 style={{ color: 'black' }}>Hello {employeeName}</h1>
          <div className="brand" style={{ fontSize: '1.5em' }}>
            <span style={{ color: '#F1DB11' }}>Bee'</span> Kahve
          </div>
        </div>

        <div className="lower-content" style={{ height: '85%' }}>
          <h2>Order List</h2>
          {/* Table for Order List */}
          <Table dataSource={orderList} rowKey="_id">
            <Column title="Order ID" dataIndex="_id" key="_id" render={(text, record) => <h3>Order ID: {text}</h3>} />
            <Column title="Products" dataIndex="products" key="products" render={(text, record) => (
              <div>
                {/* Render product details for each order */}
                {text.map((product) => (
                  <div key={product._id}>
                    <img src={product.image} alt={product.name} style={{ width: 50, height: 50, marginRight: 8 }} />
                    <span>{product.name} - Size: {product.size} - Price: {product.price}</span>
                  </div>
                ))}
              </div>
            )} />
            <Column
              title="Action"
              key="action"
              render={(text, record) => (
                <span>
                  <Button type="primary" onClick={() => showModal('Confirm Order', record)}>
                    Confirm
                  </Button>
                  <Button type="danger" onClick={() => showModal('Cancel Order', record)}>
                    Cancel
                  </Button>
                </span>
              )}
            />
          </Table>
        </div>
      </div>

      <Modal title={modalTitle} visible={isModalVisible} onCancel={handleCancel} footer={null}>
        {/* Form for Order Modal */}
        <Form onFinish={handleConfirmOrder}>
          {/* Form fields go here */}
          {/* You can customize the form fields based on your requirements */}
          <Form.Item>
            <Button type="primary" htmlType="submit">
              Confirm Order
            </Button>
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default EmployeePage;

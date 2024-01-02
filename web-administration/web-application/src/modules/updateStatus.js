// updateStatus.js
import React, { useState, useEffect, useCallback } from 'react';
import { Button, Table, Modal, Form } from 'antd';
import axios from 'axios';
import { useNavigate , useLocation} from 'react-router-dom';

const { Column } = Table;

const UpdateStatus = () => {
  const [orderList, setOrderList] = useState([]);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [modalTitle, setModalTitle] = useState('');
  const [selectedOrder, setSelectedOrder] = useState({});
  const location = useLocation();
  const employeeName = location.state && location.state.employeeName;
  const navigate = useNavigate()

  const fetchOrderList = useCallback(async () => {
    try {
      const response = await axios.post('http://51.20.117.162:8000/get_active_orders?admin_id=1');
      console.log(response)
      setOrderList(response.data.orders);
    } catch (error) {
      console.error('Error fetching order list:', error);
    }
  }, [setOrderList]);

  useEffect(() => {
    // Check if the user has a valid token or role for employee
    const token = localStorage.getItem('token');
    const name = localStorage.getItem('name');

    try{
      if(token === "b1d632f26e83babf1c80709208e1b6ed01312cc94860c327d82107ff3f073e65e81f902169d4ddfe3f837f8297ea8d80085f0ed1f6fc6ee7a84e0383abadf5ba"){
        navigate('/adminPage')
      }
      if (token && name === employeeName) {
        fetchOrderList();
      } else {
        navigate('/signInPage'); // Redirect to sign-in if not authenticated as employee
      }
    }
    catch{
      navigate('/signInPage'); // Redirect to sign-in if not authenticated as employee
    }
  }, [fetchOrderList, navigate, employeeName]);


  const showModal = (title, order) => {
    setIsModalVisible(true);
    setModalTitle(title);
    setSelectedOrder(order);
  };

  const handleCancel = () => {
    setIsModalVisible(false);
  };

  const handleReadyOrder = () => {
    // Logic for marking order as ready
    handleCancel(); // Close the modal after action
  };

  const handleExitAccount = () => {
    localStorage.removeItem('token');
    navigate('/signInPage');
  };

  const handleDeliveredOrder = async () => {
    try {
      // Update the order status to 'Delivered' and send back to the server
      await axios.put(`/api/orders/${selectedOrder._id}`, { status: 'Delivered' });
      handleCancel(); // Close the modal after action
      fetchOrderList(); // Refresh the order list
    } catch (error) {
      console.error('Error updating order status:', error);
    }
  };

  return (
    <div className="updateStatus">
      <div className="left-sidebar">
        <h1 style={{ color: 'white', marginLeft: '20%' }}>Employee</h1>
        <div className={`menu-stock-header`} onClick={() => navigate('/employeePage')}>
          <h4 style={{ color: 'black' }}>Confirm Order</h4>
        </div>
        <div className={`menu-stock-header active`} onClick={fetchOrderList}>
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
            <Column title="Order ID" dataIndex="order_id" key="order_id" render={(text, record) => <h3>Order ID: {text}</h3>} />
            <Column title="Products" dataIndex="line_items" key="line_items" render={(text, record) => (
              <div>
                {/* Render product details for each order */}
                {text.map((product) => (
                  <div key={product.product_id}>
                    <img src={product.photo_path} alt={product.name} style={{ width: 100, height: 100, marginRight: 8 }} />
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
                  <Button type="primary" onClick={() => showModal('Ready Order', record)}>
                    Ready
                  </Button>
                  <Button type="primary" onClick={() => showModal('Delivered Order', record)}>
                    Delivered
                  </Button>
                </span>
              )}
            />
          </Table>
        </div>
      </div>

      <Modal title={modalTitle} visible={isModalVisible} onCancel={handleCancel} footer={null}>
        {/* Form for Order Modal */}
        <Form onFinish={modalTitle === 'Ready Order' ? handleReadyOrder : handleDeliveredOrder}>
          {/* Form fields go here */}
          {/* You can customize the form fields based on your requirements */}
          <Form.Item>
            <Button type="primary" htmlType="submit">
              {modalTitle === 'Ready Order' ? 'Mark as Ready' : 'Mark as Delivered'}
            </Button>
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default UpdateStatus;

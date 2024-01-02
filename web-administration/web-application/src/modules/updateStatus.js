// Novruz Amirov: 150200903
// Software Engineerin - BLG 411E - 2023/2024 - Semester Project
// updateStatus.js -> an employee page to update the status of the orders

import React, { useState, useEffect, useCallback } from 'react';
import { Button, Table, Modal } from 'antd';
import axios from 'axios';
import { useNavigate , useLocation} from 'react-router-dom';

const { Column } = Table;

const UpdateStatus = () => {
  const [orderList, setOrderList] = useState([]);
  const location = useLocation();
  const employeeName = location.state && location.state.employeeName;
  const navigate = useNavigate()
  const [clickedButtons, setClickedButtons] = useState({});
  const [isCancelModalVisible, setIsCancelModalVisible] = useState(false);
  const [cancelOrderID, setCancelOrderID] = useState(null);

  const fetchOrderList = useCallback(async () => {
    try {
      const response = await axios.post('http://51.20.117.162:8000/get_active_orders?admin_id=1');
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

  const handleExitAccount = () => {
    localStorage.removeItem('token');
    navigate('/signInPage');
  };

  const handleButtonClick = async (order_id, status) => {
    if (status === 'cancelled') {
      setIsCancelModalVisible(true);
      setCancelOrderID(order_id);
    } else {
      try {
        await axios.get(`http://51.20.117.162:8000/set_status?order_id=${order_id}&status=${status}`);
        fetchOrderList();
        setClickedButtons((prevClickedButtons) => ({
          ...prevClickedButtons,
          [order_id]: status,
        }));
      } catch (error) {
        console.error('Error updating order status:', error);
      }
    }
  };

  const handleCancelModalOk = async () => {
    try {
      await axios.get(`http://51.20.117.162:8000/set_status?order_id=${cancelOrderID}&status=cancelled`);
      fetchOrderList();
      setClickedButtons((prevClickedButtons) => ({
        ...prevClickedButtons,
        [cancelOrderID]: 'cancelled',
      }));
      setIsCancelModalVisible(false); // Close the modal
    } catch (error) {
      console.error('Error cancelling order:', error);
    }
  };

  const handleCancelModalCancel = () => {
    setIsCancelModalVisible(false);
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
          <Table dataSource={orderList} rowKey="_id">
            <Column title="Order ID" dataIndex="order_id" key="order_id" render={(text, record) => <h3>Order ID: {text}</h3>} />
            <Column title="Products" dataIndex="line_items" key="line_items" render={(text, record) => (
              <div>
                {text.map((product) => (
                  <div key={product.product_id}>
                    <img src={product.photo_path} alt={product.name} style={{ width: 150, height: 150, marginRight: 8 }} />
                    <span>{product.name} - Size: {product.size} - Price: {product.price}</span>
                  </div>
                ))}
              </div>
            )} />
            <Column
              title="Action"
              key="action"
              render={(text, record) => (
                <div className='update-status-buttons'>
               <Button
                type={clickedButtons[record.order_id] === 'on_the_way' ? 'primary' : 'default'}
                onClick={() => handleButtonClick(record.order_id, 'on_the_way')}
              >
                On The Way
              </Button>
              <Button
                type={clickedButtons[record.order_id] === 'delivered' ? 'primary' : 'default'}
                onClick={() => handleButtonClick(record.order_id, 'delivered')}
              >
                Delivered
              </Button>
              <Button
                type={clickedButtons[record.order_id] === 'cancelled' ? 'primary' : 'default'}
                onClick={() => handleButtonClick(record.order_id, 'cancelled')}
              >
                Cancel
              </Button>
                </div>
              )}
            />
          </Table>
          <Modal
        title="Cancel Order"
        visible={isCancelModalVisible}
        onOk={handleCancelModalOk}
        onCancel={handleCancelModalCancel}
      >
        <p>Are you sure you want to cancel this order?</p>
      </Modal>
        </div>
      </div>
    </div>
  );
};

export default UpdateStatus;
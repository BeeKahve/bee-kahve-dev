// Novruz Amirov: 150200903
// Software Engineerin - BLG 411E - 2023/2024 - Semester Project
// employeePage.js -> employee page, to accept and deny orders, and changing the status of orders

import React, { useState, useEffect, useCallback } from 'react';
import { Button, Table } from 'antd'; // Input
import axios from 'axios';
import { useNavigate, useLocation } from 'react-router-dom';

const { Column } = Table;

const EmployeePage = () => {
  const [orderList, setOrderList] = useState([]);
  const navigate = useNavigate();
  const location = useLocation();
  const employeeName = location.state && location.state.employeeName;

  const fetchOrderList = useCallback(async () => {
    try {
      const response = await axios.get('http://51.20.117.162:8000/get_waiting_orders?admin_id=1');

      const orders = response.data.orders;
      // Fetch address for each order and update the orderList state
      const updatedOrderList = await Promise.all(orders.map(async (order) => {
        const addressResponse = await axios.get(`http://51.20.117.162:8000/get_address?customer_id=${order.customer_id}`);
        return { ...order, address: addressResponse.data.address };
      }));

      setOrderList(updatedOrderList);
      // setOrderList(response.data.orders);
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
    localStorage.removeItem('name');
    localStorage.removeItem('obj')
    navigate('/signInPage');
  };

  const handleConfirmOrder = async (orderId) => {
    try {
      // Make a request to update the order status to 'preparing'
      const response = await axios.get(`http://51.20.117.162:8000/set_status?order_id=${orderId}&status=preparing`);

      if (response.data.message === "Status is updated successfully.") {
        fetchOrderList()
      } 
      
    } catch (error) {
      console.error('Error confirming order:', error);
    }
  };

  const handleCancelOrder = async (orderId) => {
    try {
      // Make a request to update the order status to 'cancelled'
      await axios.get(`http://51.20.117.162:8000/set_status?order_id=${orderId}&status=cancelled`);
      fetchOrderList()
    } 
    catch (error) {
      console.error('Error cancelling order:', error);
    }
  };
  
  const handleUpdateStatus = () => {
    // Redirect to /updateStatus when Update Order Status button is clicked
    navigate(`/updateStatus`, { state: { employeeName: employeeName } });
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
          <Table dataSource={orderList} rowKey="_id" className='confirm-orders'>
            <Column title="Order ID" dataIndex="order_id" key="order_id" render={(text, record) => <h3>Order ID: {text}</h3>} />
            <Column
              title="Products"
              dataIndex="line_items"
              key="line_items"
              render={(lineItems, record) => (
                <div className='orders'>
                  {lineItems.length > 0 ? (
                    lineItems.map((product, index) => (
                      <div className='order' key={index}>
                        <div className='prod-name'>
                          <p> {product.name} </p>
                          <p> Size: {product.size_choice}</p>
                          <p> Price: {product.price}</p>
                        </div>
                        <img src={product.photo_path} alt={product.name} style={{ width: 200, height: 200, marginRight: 8 }} />
                      </div>
                    ))
                  ) : (
                    <span>No products in this order</span>
                  )}
                </div>
              )}
            />
             <Column
            title="Customer Address"
            dataIndex="address"
            key="address"
            render={(address, record) => (
              <div>
                <h3>Address: {address}</h3>
              </div>
            )}
          />
            <Column
              title="Action"
              key="action"
              render={(text, record) => (
                <span>
                  <Button type="primary" onClick={() => handleConfirmOrder(record.order_id)}>
                    Confirm
                  </Button>
                  <Button type="danger" onClick={() => handleCancelOrder(record.order_id)}>
                    Cancel
                  </Button>
                </span>
              )}
            />
          </Table>
        </div>
      </div>
    </div>
  );
};

export default EmployeePage;
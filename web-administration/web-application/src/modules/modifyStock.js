// Novruz Amirov: 150200903
// Software Engineerin - BLG 411E - 2023/2024 - Semester Project
// modifyStock.js -> an admin page to update the stock information

import React, { useState, useEffect, useCallback } from 'react';
import { Button, Form, Input, Checkbox, Modal } from 'antd';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const ModifyStock = () => {
  const [stockData, setStockData] = useState({});
  const [updatedItems, setUpdatedItems] = useState({});
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  const fetchStockData = useCallback(async () => {
    try {
      const response = await axios.get('http://51.20.117.162:8000/get_stock?stock_id=1');
      setStockData(response.data);
      setLoading(false);
    } catch (error) {
      console.error('Error fetching stock data:', error);
      setStockData({
        smallCupCount: 0,
        mediumCupCount: 0,
        largeCupCount: 0,
        espressoAmount: 0,
        decafEspressoAmount: 0,
        wholeMilkAmount: 0,
        reducedFatMilkAmount: 0,
        lactoseFreeMilkAmount: 0,
        oatMilkAmount: 0,
        almondMilkAmount: 0,
        chocolateSyrupAmount: 0,
        whiteChocolateSyrupAmount: 0,
        caramelSyrupAmount: 0,
        whiteSugarAmount: 0,
        brownSugarAmount: 0,
        iceAmount: 0,
      });
      setLoading(false);
    }
  }, [setStockData]);

  useEffect(() => {
    // Check if the user has a valid token
    const token = localStorage.getItem('token');

    if (token === 'b1d632f26e83babf1c80709208e1b6ed01312cc94860c327d82107ff3f073e65e81f902169d4ddfe3f837f8297ea8d80085f0ed1f6fc6ee7a84e0383abadf5ba') {
      fetchStockData();
    } else {
      navigate('/signInPage'); 
    }
  }, [navigate, fetchStockData]);

  const handleCheckboxChange = (itemName, checked) => {
    setUpdatedItems((prevItems) => ({ ...prevItems, [itemName]: checked }));
  };

  const [activeMenu, setActiveMenu] = useState('Modify Stock');

  const handleExitAccount = () => {
    localStorage.removeItem('token');
    navigate('/signInPage')
  }

  const handleModifyMenu = () => {
    navigate('/adminPage');
    setActiveMenu('Modify Menu');
  };

  const handleModifyStock = () => {
    navigate('/modifyStock');
    setActiveMenu('Modify Stock');
  };

  const handleUpdateStock = async () => {
    try {
      const updatedData = Object.fromEntries(
        Object.entries(stockData).filter(([key, value]) => updatedItems[key])
      );

      // Send the updated data to the database over API
      console.log(updatedData)
      await axios.post('http://51.20.117.162:8000/update_stock', updatedData);
      
      Modal.success({
        title: 'Stock Updated',
        content: 'Stock has been successfully updated.',
      });
    } catch (error) {
      console.error('Error updating stock:', error);
    }
  };

  return (
    <div className="adminPage modifyStock">
     <div className="left-sidebar">
        <h1 style={{ color: 'white', marginLeft: '30%' }}>ADMIN</h1>
        <div
          className={`menu-stock-header ${activeMenu === 'Modify Menu' ? 'active' : ''}`}
          onClick={handleModifyMenu}
        >
          <h4 style={{ color: 'black' }}>Modify Menu</h4>
        </div>
        <div
          className={`menu-stock-header ${activeMenu === 'Modify Stock' ? 'active' : ''}`}
          onClick={handleModifyStock}
        >
          <h4 style={{ color: 'black' }}>Modify Stock</h4>
        </div>
        <Button className='exit-account' type="danger" onClick={() => handleExitAccount()}>
              <h4>Exit Account</h4>
        </Button>
      </div>
      <div className="right-content">
        <div className="upper-content" style={{ height: '15%', display: 'flex', flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', width: '80vw'}}>
          <h1 style={{ color: 'black' }}>Hello Admin</h1>
          <div className="brand" style={{ fontSize: '1.5em' }}>
            <span style={{ color: '#F1DB11' }}>Bee'</span> Kahve
          </div>
        </div>
        <div className="lower-content modify-stock" style={{ height: '85%' }}>
          <h2>Modify Stock</h2>
          <Form>
            {Object.entries(stockData).map(([itemName, amount]) => (
              <Form.Item label={itemName} key={itemName}>
                <Input
                  type="number"
                  value={amount}
                  onChange={(e) => setStockData((prevData) => ({ ...prevData, [itemName]: e.target.value }))}
                />
                <Checkbox
                  checked={updatedItems[itemName]}
                  onChange={(e) => handleCheckboxChange(itemName, e.target.checked)}
                >
                  Update Element
                </Checkbox>
              </Form.Item>
            ))}
            <Form.Item>
              <Button type="primary" onClick={handleUpdateStock} disabled={loading}>
                Update Stock
              </Button>
            </Form.Item>
          </Form>
        </div>
      </div>
    </div>
  );
};

export default ModifyStock;
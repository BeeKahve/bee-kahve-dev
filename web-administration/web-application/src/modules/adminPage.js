// Novruz Amirov: 150200903
// Software Engineerin - BLG 411E - 2023/2024 - Semester Project
// adminPage.js for admin, to modify stock and adds new products to menu

import React, { useState, useEffect, useCallback } from 'react';
import { Button, Table } from 'antd'; // Modal, Form, Input
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import { css } from '@emotion/react';
import { BarLoader } from 'react-spinners';

const override = css`
  display: block;
  margin: 0 auto;
  border-color: red;
`;

const { Column } = Table;

const AdminPage = () => {
  let [coffeeList, setCoffeeList] = useState([]);
  const [selectedCoffee, setSelectedCoffee] = useState({});
  const [loading, setLoading] = useState(false);
  const [activeMenu, setActiveMenu] = useState('Modify Menu');
  const [selectedRowKey, setSelectedRowKey] = useState(null);
  const navigate = useNavigate();

  const fetchCoffeeList = useCallback(async () => {
    try {
      setLoading(true)
      const response = await axios.get('http://51.20.117.162:8000/get_menu');
      setCoffeeList(response.data.menuProducts);
      setLoading(false)  
    } catch (error) {
      console.error('Error fetching coffee list:', error);
    }
  }, [setCoffeeList]);

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (token === 'b1d632f26e83babf1c80709208e1b6ed01312cc94860c327d82107ff3f073e65e81f902169d4ddfe3f837f8297ea8d80085f0ed1f6fc6ee7a84e0383abadf5ba') {
      fetchCoffeeList();
    } else {
      navigate('/signInPage'); 
    }
  }, [navigate, fetchCoffeeList]);

  const handleAddCoffee = () => {
    navigate('/addCoffee');
  };

  const handleModifyMenu = () => {
    navigate('/adminPage');
    setActiveMenu('Modify Menu');
  };

  const handleModifyStock = () => {
    setActiveMenu('Modify Stock');
    navigate('/modifyStock');
  };

  const handleExitAccount = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('obj')
    navigate('/signInPage');
  };

  const handleRowClick = (record) => {
    if (selectedRowKey === record.product_id) {
      setSelectedRowKey(null);
      setSelectedCoffee({});
    } else {
      setSelectedRowKey(record.product_id);
      setSelectedCoffee(record);
    }
  };
  
  const handleUpdateCoffee = () => {
    if (selectedCoffee.product_id) {
      navigate(`/updateCoffee`, { state: { selectedCoffee: selectedCoffee } });
    }
  };

  return (
    <div className="adminPage">
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
        <div className="lower-content" style={{ height: '85%' }}>
        <h2>Coffee Menu</h2>
          {loading ? (
            <BarLoader css={override} loading={loading} size={150} color={'#36D7B7'} />
          ) : (
            <Table
              dataSource={coffeeList}
              rowKey="product_id"
              rowSelection={{
                type: 'radio',
                selectedRowKeys: [selectedRowKey],
                onSelect: (record, selected, selectedRows) => {
                  if (selected) {
                    handleRowClick(record);
                  }
                },
              }}
              onRow={(record) => ({
                onClick: () => handleRowClick(record),
              })}
            >
              <Column title="Product_ID" dataIndex="product_id" key="product_id" />
              <Column title="Name" dataIndex="name" key="name" />
              <Column title="Price (TL)" dataIndex="price" key="price" />
              
              {loading ? (
                <BarLoader css={override} loading={loading} size={150} color={'#36D7B7'} />
              ) : (<Column
                title="Image"
                dataIndex="image"
                key="image"
                render={(text, record) => (
                  <img src={record.photo_path} alt={record.name} style={{ maxWidth: '200px', maxHeight: '200px' }} />
                )}
              />)}
              
            </Table>
          )}
        <div className="add-update-buttons">
          <Button type="primary" onClick={() => handleAddCoffee()}>
            Add Coffee
          </Button>
          <Button type="primary" disabled={!selectedRowKey} onClick={handleUpdateCoffee}>
            Update Coffee
          </Button>
        </div>
      </div>
      </div>
    </div>
  );
};

export default AdminPage;
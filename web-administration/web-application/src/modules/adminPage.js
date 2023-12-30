// adminPage.js
import React, { useState, useEffect } from 'react';
import { Button, Table, Modal, Form, Input } from 'antd';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const { Column } = Table;

const AdminPage = () => {
  const [coffeeList, setCoffeeList] = useState([]);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [modalTitle, setModalTitle] = useState('');
  const [selectedCoffee, setSelectedCoffee] = useState({});
  const [adminName, setAdminName] = useState('Admin'); // Replace with the actual admin name

  const navigate = useNavigate();

  useEffect(() => {
    fetchCoffeeList();
  }, []);

  const fetchCoffeeList = async () => {
    try {
      const response = await axios.get('/api/coffees');
      setCoffeeList(response.data);
    } catch (error) {
      console.error('Error fetching coffee list:', error);
    }
  };

  const showModal = (title, coffee) => {
    setIsModalVisible(true);
    setModalTitle(title);
    setSelectedCoffee(coffee);
  };

  const handleCancel = () => {
    setIsModalVisible(false);
  };

  const handleAddCoffee = () => {
    // Navigate to /addCoffee when Add Coffee button is clicked
    navigate('/addCoffee');
  };

  const handleSubmit = async (values) => {
    try {
      if (modalTitle === 'Add Coffee') {
        await axios.post('/api/coffees', values);
      } else {
        await axios.put(`/api/coffees/${selectedCoffee._id}`, values);
      }
      handleCancel();
      fetchCoffeeList();
    } catch (error) {
      console.error('Error submitting form:', error);
    }
  };

  return (
    <div className="adminPage">
      <div className="left-sidebar">
        <h1 style={{ color: 'white', marginLeft: '30%' }}>ADMIN</h1>
        <div className="menu-stock-header" style={{ backgroundColor: '#F1DB11' }}>
          <h4 style={{ color: 'black' }}>Modify Menu and Stock</h4>
        </div>
      </div>

      <div className="right-content">
        <div className="upper-content" style={{ height: '15%', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
          <h1 style={{ color: 'black' }}>Hello {adminName}</h1>
          <div className="brand" style={{ fontSize: '1.5em' }}>
            <span style={{ color: '#F1DB11' }}>Bee'</span> Kahve
          </div>
        </div>

        <div className="lower-content" style={{ height: '85%' }}>
          <h2>Coffee Menu</h2>
          <Table dataSource={coffeeList} rowKey="_id">
            {/* Columns for Coffee Menu Table */}
            <Column title="Name" dataIndex="name" key="name" />
            <Column title="Price" dataIndex="price" key="price" />
            <Column title="Description" dataIndex="description" key="description" />
            <Column
              title="Action"
              key="action"
              render={(text, record) => (
                <span>
                  <Button type="primary" onClick={() => showModal('Update Coffee', record)}>
                    Edit
                  </Button>
                </span>
              )}
            />
          </Table>
          <div className="add-update-buttons">
            <Button type="primary" onClick={() => handleAddCoffee()}>
              Add Coffee
            </Button>
            <Button type="primary" disabled={!selectedCoffee._id} onClick={() => showModal('Update Coffee', selectedCoffee)}>
              Update Coffee
            </Button>
          </div>
        </div>
      </div>

      <Modal title={modalTitle} visible={isModalVisible} onCancel={handleCancel} footer={null}>
        {/* Form for Coffee Modal */}
        <Form initialValues={selectedCoffee} onFinish={handleSubmit}>
          {/* Form fields go here */}
          <Form.Item label="Name" name="name" rules={[{ required: true, message: 'Please input the name!' }]}>
            <Input />
          </Form.Item>
          <Form.Item label="Price" name="price" rules={[{ required: true, message: 'Please input the price!' }]}>
            <Input />
          </Form.Item>
          <Form.Item label="Description" name="description">
            <Input />
          </Form.Item>
          <Form.Item>
            <Button type="primary" htmlType="submit">
              {modalTitle === 'Add Coffee' ? 'Create' : 'Update'}
            </Button>
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default AdminPage;

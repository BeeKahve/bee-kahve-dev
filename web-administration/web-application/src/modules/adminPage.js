// adminPage.js
import React, { useState, useEffect } from 'react';
import { Button, Table, Modal, Form, Input } from 'antd';
import axios from 'axios';
// import './adminPage.css';

const { Column } = Table;

const AdminPage = () => {
  const [coffeeList, setCoffeeList] = useState([]);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [modalTitle, setModalTitle] = useState('');
  const [selectedCoffee, setSelectedCoffee] = useState({});
  const [adminName, setAdminName] = useState('Admin'); // Replace with the actual admin name

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
        <h2 style={{ color: 'white' }}>ADMIN</h2>
        <div className="menu-stock-header" style={{ backgroundColor: 'yellow' }}>
          <h4 style={{ color: 'black' }}>Modify Menu</h4>
          <h4 style={{ color: 'black' }}>Stock</h4>
        </div>
      </div>

      <div className="right-content">
        <div className="greetings">
          <p>Hello {adminName}</p>
          <div className="brand">
            <span style={{ color: 'yellow' }}>Bee'</span> Kahve
          </div>
        </div>
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
          <Button type="primary" onClick={() => showModal('Add Coffee', {})}>
            Add Coffee
          </Button>
          <Button type="primary" disabled={!selectedCoffee._id} onClick={() => showModal('Update Coffee', selectedCoffee)}>
            Update Coffee
          </Button>
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

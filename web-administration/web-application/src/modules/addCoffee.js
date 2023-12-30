// AddCoffee.js
import React, { useState } from 'react';
import { Button, Form, Input, Checkbox, Upload, message } from 'antd';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const AddCoffee = () => {
  const [form] = Form.useForm();
  const [imageUrl, setImageUrl] = useState(null);
  const navigate = useNavigate();

  const onFinish = async (values) => {
    try {
      const response = await axios.post('/api/addCoffee', values);
      navigate('/adminPage');
    } catch (error) {
      console.error('Error submitting form:', error);
      message.error('Failed to submit the form. Please try again.');
    }
  };

  const onBackClick = () => {
    navigate('/adminPage');
  };

  const normFile = (e) => {
    if (Array.isArray(e)) {
      return e;
    }
    return e && e.fileList;
  };

  const checkImageDimensions = (file) => {
    const { width, height } = file;
    if (width < 100 || height < 100) {
      message.error('Image dimensions should be at least 100x100 pixels.');
      return false;
    }
    return true;
  };

  const customRequest = ({ file, onSuccess }) => {
    const formData = new FormData();
    formData.append('file', file);
    const placeholderUrl = 'https://via.placeholder.com/150';
    onSuccess(placeholderUrl);
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
          <h1 style={{ color: 'white' }}>Hello Admin</h1>
          <div className="brand" style={{ fontSize: '1.5em' }}>
            <span style={{ color: '#F1DB11' }}>Bee'</span> Kahve
          </div>
        </div>

        <div className="lower-content" style={{ height: '85%' }}>
          <Button type="primary" onClick={onBackClick}>
            {'\u2190'}
          </Button>
          <h2 style={{ textAlign: 'center' }}>Add Coffee</h2>
          <Form
            form={form}
            name="addCoffeeForm"
            onFinish={onFinish}
            labelCol={{ span: 8 }}
            wrapperCol={{ span: 16 }}
          >
            <Form.Item
              label="Image"
              name="image"
              valuePropName="fileList"
              getValueFromEvent={normFile}
              rules={[
                { required: true, message: 'Please upload an image!' },
                {
                  validator: (_, value) => {
                    if (value && value.length === 1 && checkImageDimensions(value[0])) {
                      return Promise.resolve();
                    }
                    return Promise.reject(new Error('Image dimensions are too small!'));
                  },
                },
              ]}
            >
              <Upload customRequest={customRequest} listType="picture" maxCount={1}>
                <Button>Upload Image</Button>
              </Upload>
            </Form.Item>
            <Form.Item
              label="Coffee Name"
              name="name"
              rules={[{ required: true, message: 'Please input the coffee name!' }]}
            >
              <Input />
            </Form.Item>
            <Form.Item label="Content" name="content" rules={[{ required: true, message: 'Please input the coffee content!' }]}>
              <Input.TextArea />
            </Form.Item>
            <Form.Item label="Size" name="size" rules={[{ required: true, message: 'Please select at least one size!' }]}>
              <Checkbox.Group>
                <Checkbox value="small">Small</Checkbox>
                <Checkbox value="medium">Medium</Checkbox>
                <Checkbox value="large">Large</Checkbox>
              </Checkbox.Group>
            </Form.Item>
            <Form.Item
              label="Price (Small)"
              name="priceSmall"
              rules={[
                ({ getFieldValue }) => ({
                  validator(_, value) {
                    if (getFieldValue('size') && getFieldValue('size').includes('small') && !value) {
                      return Promise.reject(new Error('Please enter the price for Small size!'));
                    }
                    return Promise.resolve();
                  },
                }),
              ]}
            >
              <Input type="number" />
            </Form.Item>
            <Form.Item
              label="Price (Medium)"
              name="priceMedium"
              rules={[
                ({ getFieldValue }) => ({
                  validator(_, value) {
                    if (getFieldValue('size') && getFieldValue('size').includes('medium') && !value) {
                      return Promise.reject(new Error('Please enter the price for Medium size!'));
                    }
                    return Promise.resolve();
                  },
                }),
              ]}
            >
              <Input type="number" />
            </Form.Item>
            <Form.Item
              label="Price (Large)"
              name="priceLarge"
              rules={[
                ({ getFieldValue }) => ({
                  validator(_, value) {
                    if (getFieldValue('size') && getFieldValue('size').includes('large') && !value) {
                      return Promise.reject(new Error('Please enter the price for Large size!'));
                    }
                    return Promise.resolve();
                  },
                }),
              ]}
            >
              <Input type="number" />
            </Form.Item>
            <Form.Item wrapperCol={{ offset: 8, span: 16 }}>
              <Button type="primary" htmlType="submit">
                Submit
              </Button>
            </Form.Item>
          </Form>
        </div>
      </div>
    </div>
  );
};

export default AddCoffee;

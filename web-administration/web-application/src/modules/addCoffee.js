import React, { useState, useEffect } from 'react';
import { Button, Form, Input, Checkbox, Upload, message, Slider } from 'antd';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const AddCoffee = () => {
  const [form] = Form.useForm();
  const [imageUrl, setImageUrl] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    // Check if the user has a valid token
    const token = localStorage.getItem('token');

    if (token === 'b1d632f26e83babf1c80709208e1b6ed01312cc94860c327d82107ff3f073e65e81f902169d4ddfe3f837f8297ea8d80085f0ed1f6fc6ee7a84e0383abadf5ba') {
        normFile()
    } else {
      navigate('/signInPage');
    }
  }, []);


    // State variables for checkboxes
    const [sugarChecked, setSugarChecked] = useState(false);
    const [iceChecked, setIceChecked] = useState(false);

  const [activeMenu, setActiveMenu] = useState('Modify Menu');

  const normFile = (e) => {
    if (Array.isArray(e)) {
      return e;
    }
    return e && e.fileList;
  };

  const handleExitAccount = () => {
    localStorage.removeItem('token');
    navigate('/signInPage');
  };

  const handleModifyMenu = () => {
    navigate('/adminPage');
    setActiveMenu('Modify Menu');
  };

  const handleModifyStock = () => {
    navigate('/modifyStock');
    setActiveMenu('Modify Stock');
  };

  const onFinish = async (values) => {
    try {
      if (values.espresso_amount === 0 || values.espresso_amount === undefined) {
        message.error('The amount for espresso must be entered!');
        return;
      }
      if (values.milk_amount === undefined) {
        values.milk_amount = 0;
      }
      if (values.foam_amount === undefined) {
        values.foam_amount = 0;
      }
      if (values.chocolate_syrup_amount === undefined) {
        values.chocolate_syrup_amount = 0;
      }
      if (values.white_chocolate_syrup_amount === undefined) {
        values.white_chocolate_syrup_amount = 0;
      }
      if (values.caramel_syrup_amount === undefined) {
        values.caramel_syrup_amount = 0;
      }

      const totalPercentage =
        values.espresso_amount +
        values.milk_amount +
        values.foam_amount +
        values.chocolate_syrup_amount +
        values.caramel_syrup_amount +
        values.white_chocolate_syrup_amount;

      if (totalPercentage !== 100) {
        message.error('Total percentage of ingredients must be equal to 100.');
        return;
      }

      const payload = {
        ...values,
        priceSmall: Number(values.priceSmall),
      };

        console.log(payload)
      const response = await axios.post('/api/addCoffee', payload);

      navigate('/adminPage');
    } catch (error) {
      console.error('Error submitting form:', error);
      message.error('Failed to submit the form. Please try again.');
    }
  };

  const onBackClick = () => {
    navigate('/adminPage');
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

  const handleSugarCheckboxChange = (checked) => {
    console.log(form.getFieldValue('sugar_checkbox'))
    form.setFieldsValue({ sugar_amount: checked ? undefined : null });
  };

  const handleIceCheckboxChange = (checked) => {
    form.setFieldsValue({ ice_amount: checked ? undefined : null });
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
        <Button className="exit-account" type="danger" onClick={() => handleExitAccount()}>
          <h4>Exit Account</h4>
        </Button>
      </div>

      <div className="right-content">
        <div
          className="upper-content"
          style={{
            height: '15%',
            display: 'flex',
            flexDirection: 'row',
            justifyContent: 'space-between',
            alignItems: 'center',
            width: '80vw',
          }}
        >
          <h1 style={{ color: 'black' }}>Hello Admin</h1>
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
            <Form.Item
              name="espresso_amount"
              label="Espresso Amount"
              rules={[{ required: true, message: 'Please input the coffee content!' }]}
            >
              <Slider min={0} max={100} />
            </Form.Item>
            <Form.Item name="milk_amount" label="Milk">
              <Slider min={0} max={100} />
            </Form.Item>
            <Form.Item name="foam_amount" label="Foam">
              <Slider min={0} max={100} />
            </Form.Item>
            <Form.Item name="chocolate_syrup_amount" label="Chocolate Syrup">
              <Slider min={0} max={100} />
            </Form.Item>
            <Form.Item name="caramel_syrup_amount" label="Caramel Syrup">
              <Slider min={0} max={100} />
            </Form.Item>
            <Form.Item name="white_chocolate_syrup_amount" label="White Chocolate Syrup" style={{ whiteSpace: 'pre-line' }}>
              <Slider min={0} max={100} />
            </Form.Item>
            <Form.Item
        name="sugar_checkbox"
        label="Sugar"
        valuePropName="checked"
        onChange={(e) => setSugarChecked(e.target.checked)}
      >
        <Checkbox>Include Sugar</Checkbox>
      </Form.Item>
      {sugarChecked && (
        <Form.Item
          name="sugar_amount"
          label="Sugar Amount (gr)"
          rules={[
            { required: true, message: 'Please enter the sugar amount!' },
          ]}
        >
          <Input type="number" />
        </Form.Item>
      )}
      <Form.Item
        name="ice_checkbox"
        label="Ice"
        valuePropName="checked"
        onChange={(e) => setIceChecked(e.target.checked)}
      >
        <Checkbox>Include Ice</Checkbox>
      </Form.Item>
      {iceChecked && (
        <Form.Item
          name="ice_amount"
          label="Ice Amount (1 to 10)"
          rules={[
            { required: true, min: 1, max: 10, message: 'Please enter the ice amount!' },
          ]}
        >
          <Input type="number" />
        </Form.Item>
      )}
            <Form.Item
              label="Size"
              name="size"
              rules={[{ required: true, message: 'Please select a size!' }]}
            >
              <Checkbox.Group>
                <Checkbox value="small">Small</Checkbox>
                <Checkbox value="medium">Medium</Checkbox>
                <Checkbox value="large">Large</Checkbox>
              </Checkbox.Group>
            </Form.Item>
            <Form.Item
              label="Price"
              name="priceSmall"
              rules={[
                { required: true, message: 'Please enter the price for Small size!' },
              ]}
            >
              <Input type="number" />
            </Form.Item>
            <h5>Note: You do not need to enter the medium or large cup price. If they exist, checkbox them, and the price will be followed for medium 1.3x and for large 1.7x.</h5>
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

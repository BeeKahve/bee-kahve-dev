import React, { useState, useEffect } from 'react';
import { Button, Form, Input, Checkbox, message, Slider } from 'antd'; // Upload
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const AddCoffee = () => {
  const [form] = Form.useForm();
  const navigate = useNavigate();

  useEffect(() => {
    // Check if the user has a valid token
    const token = localStorage.getItem('token');

    if (token !== 'b1d632f26e83babf1c80709208e1b6ed01312cc94860c327d82107ff3f073e65e81f902169d4ddfe3f837f8297ea8d80085f0ed1f6fc6ee7a84e0383abadf5ba') {
      navigate('/signInPage');
    } 
  }, [navigate]);


    // State variables for checkboxes
    const [sugarChecked, setSugarChecked] = useState(false);
    const [iceChecked, setIceChecked] = useState(false);

  const [activeMenu, setActiveMenu] = useState('Modify Menu');

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
      let {
        name,
        image,
        espresso_amount,
        milk_amount,
        foam_amount,
        chocolate_syrup_amount,
        caramel_syrup_amount,
        white_chocolate_syrup_amount,
        sugar_checkbox,
        sugar_amount,
        ice_checkbox,
        ice_amount,
        small_cup_only,
        priceSmall,
      } = values;

      if(isNaN(milk_amount)){
        milk_amount = 0
      }
      if(isNaN(foam_amount)){
        foam_amount = 0
      }
      if(isNaN(chocolate_syrup_amount)){
        chocolate_syrup_amount = 0
      }
      if(isNaN(caramel_syrup_amount)){
        caramel_syrup_amount = 0
      }
      if(isNaN(white_chocolate_syrup_amount)){
        white_chocolate_syrup_amount = 0
      }

      const totalPercentage =
      espresso_amount +
      milk_amount +
      foam_amount +
      chocolate_syrup_amount +
      caramel_syrup_amount +
      white_chocolate_syrup_amount;

    if (totalPercentage !== 100) {
      message.error('The sum of espresso amount, milk, foam, chocolate syrup, caramel syrup, and white chocolate syrup must be exactly 100.');
      return;
    }

      const payload = {
        admin_id: 1, // Assuming admin_id is 1 for the current admin
        coffee_name: name,
        photo_path: image,
        small_cup_only: small_cup_only,
        price: Number(priceSmall),
        espresso_amount,
        milk_amount: milk_amount || 0,
        foam_amount: foam_amount || 0,
        chocolate_syrup_amount: chocolate_syrup_amount || 0,
        caramel_syrup_amount: caramel_syrup_amount || 0,
        white_chocolate_syrup_amount: white_chocolate_syrup_amount || 0,
        sugar_amount: sugar_checkbox ? sugar_amount || 0 : 0,
        ice_amount: ice_checkbox ? ice_amount || 0 : 0,
      };
      console.log(payload);
      
      // Use your API endpoint instead of the placeholder URL
      const response = await axios.post('http://51.20.117.162:8000/add_product', payload);
      console.log(response)

      navigate('/adminPage');
    } catch (error) {
      console.error('Error submitting form:', error);
      message.error('Failed to submit the form. Please try again.');
    }
  };

  const onBackClick = () => {
    navigate('/adminPage');
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
              label="Image (URL)"
              name="image"
              rules={[
                { required: true, message: 'Please upload an image!' },
              ]}
            >
                 <Input />
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
              <Form.Item label="Size" name="small_cup_only">
                <Checkbox>
                  Small Only
                </Checkbox>
              </Form.Item>

            <Form.Item
              label="Price"
              name="priceSmall"
              rules={[
                { required: true, message: 'Please enter the price for Small small_cup_only!' },
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

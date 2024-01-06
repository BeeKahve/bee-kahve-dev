# def test_get_existing_product():
#     product_id = read_json("get_product", "existing_product.json")
#     response = client.post("/get_product", json=product_id)
#     print(response.json())
#     assert response.status_code == 200
#     print(response.json())


import sys
import pathlib
import json

sys.path.insert(0, pathlib.Path(__file__).parent.resolve().parent.resolve().joinpath("backend").__str__())

from api import app
from fastapi.testclient import TestClient

client = TestClient(app)


def read_json(method_name, json_file_name):
    json_file_path = "unit_test/payloads/test_" + method_name + "/" + json_file_name
    python_dict = None
    with open(json_file_path, 'r') as json_file:
        python_dict = json.load(json_file)
    return python_dict

"""
def test_root():
    response = client.get("/")
    # Check for server error
    assert response.status_code == 200


def test_web_login_admin_correct_credentials():
    credentials = read_json("web_login", "admin_correct_credentials.json")
    response = client.post("/web_login", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["user_id"] != None


def test_web_login_admin_wrong_email():
    credentials = read_json("web_login", "admin_wrong_email.json")
    response = client.post("/web_login", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["user_id"] == None


def test_web_login_admin_wrong_password():
    credentials = read_json("web_login", "admin_wrong_password.json")
    response = client.post("/web_login", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["user_id"] == None


def test_web_login_employee_correct_credentials():
    credentials = read_json("web_login", "employee_correct_credentials.json")
    response = client.post("/web_login", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["user_id"] != None


def test_web_login_employee_wrong_email():
    credentials = read_json("web_login", "employee_wrong_email.json")
    response = client.post("/web_login", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["user_id"] == None


def test_web_login_employee_wrong_password():
    credentials = read_json("web_login", "employee_wrong_password.json")
    response = client.post("/web_login", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["user_id"] == None


def test_web_register_existing_admin():
    credentials = read_json("web_register", "existing_admin.json")
    response = client.post("/web_register", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Email already exists"


def test_web_register_nonexisting_admin():
    credentials = read_json("web_register", "nonexisting_admin.json")
    response = client.post("/web_register", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Success"


def test_web_register_existing_employee():
    credentials = read_json("web_register", "existing_employee.json")
    response = client.post("/web_register", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Email already exists"


def test_web_register_nonexisting_employee():
    credentials = read_json("web_register", "nonexisting_employee.json")
    response = client.post("/web_register", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Success"


def test_login_customer_correct_credentials():
    credentials = read_json("login", "customer_correct_credentials.json")
    response = client.post("/login", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["customer_id"] != None


def test_login_customer_wrong_email():
    credentials = read_json("login", "customer_wrong_email.json")
    response = client.post("/login", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["customer_id"] == None


def test_login_customer_wrong_password():
    credentials = read_json("login", "customer_wrong_password.json")
    response = client.post("/login", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["customer_id"] == None


def test_register_existing_customer():
    credentials = read_json("register", "existing_customer.json")
    response = client.post("/register", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    print(response.json())
    assert response.json()["message"] == "Email already exists"


def test_register_nonexisting_customer():
    credentials = read_json("register", "nonexisting_customer.json")
    response = client.post("/register", json=credentials)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Success"


def test_get_menu():
    response = client.get("/get_menu")
    assert response.status_code == 200
    response_json = response.json()
    assert response_json != None
    assert response_json["menuProducts"] != None
    assert len(response_json["menuProducts"]) == response_json["product_count"]


def test_update_address_nonexisting_customer():
    address = read_json("update_address", "nonexisting_customer.json")
    response = client.post("/update_address", json=address)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    print(response.json())
    assert response.json()["message"] == "Address is not updated."


def test_update_address_existing_customer():
    address = read_json("update_address", "existing_customer.json")
    response = client.post("/update_address", json=address)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Address is updated successfully."


def test_rate_nonexisting_product():
    rate = read_json("rate", "nonexisting_product.json")
    response = client.post("/rate", json=rate)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Rate could not fetched."


def test_rate_existing_product():
    rate = read_json("rate", "existing_product.json")
    response = client.post("/rate", json=rate)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Rate is updated successfully."


def test_update_stock_missing_items():
    stock = read_json("update_stock", "missing_items.json")
    response = client.post("/update_stock", json=stock)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Stock is updated successfully."


def test_update_stock_all_items():
    stock = read_json("update_stock", "all_items.json")
    response = client.post("/update_stock", json=stock)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Stock is updated successfully."
"""

def test_add_product_missing_ingredients():
    product = read_json("add_product", "missing_ingredients.json")
    response = client.post("/add_product", json=product)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Product is added successfully."


def test_add_product_all_ingredients():
    product = read_json("add_product", "all_ingredients.json")
    response = client.post("/add_product", json=product)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Product is added successfully."


def test_add_product_duplicate_coffee_name():
    product = read_json("add_product", "duplicate_coffee_name.json")
    response = client.post("/add_product", json=product)
    # Check for server error
    assert response.status_code == 200
    # Check for handled error
    assert response.json()["message"] == "Product is not added."


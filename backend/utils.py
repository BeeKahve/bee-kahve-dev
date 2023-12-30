from pydantic import BaseModel
from typing import List

"""
fotoğraflar nasıl tutulacak
"""

class Product(BaseModel):
    coffee_name : str = None 
    photo_path : str = None
    small_cup_only : bool = None
    contains_milk : bool = None             # 0 for amer 1 for others
    contains_chocolate_syrup : bool = None  # 1 for mocha 0 for others
    contains_white_chocolate_syrup : bool = None
    contains_caramel_syrup : bool = None
    contains_sugar : bool = None
    price : float = None
    rate : int = None


class MenuProduct(BaseModel):
    product_id : int = None
    name : str = None
    photo_path : str = None
    rate : float = None
    price : float = None


class ProductMenu(BaseModel):
    menuProducts : List[MenuProduct] = None
    product_count : int = None


class LineItem(BaseModel):
    product_id : int = None
    name : str = None
    photo_path : str = None
    price : float = None
    size_choice : str = None
    milk_choice : str = None
    extra_shot_choice : bool = None 
    caffein_choice : bool = None
    # add extra choices (sugar, syrup etc)


class Order(BaseModel):
    customer_id : int = None
    order_id : int = None
    line_items : List[LineItem] = None
    order_date : str = None
    order_status : str = None


class Orders(BaseModel):
    customer_name : str = None
    orders : List[Order] = None
    order_count : int = None


class Customer(BaseModel):
    customer_id : int = None
    name : str = None
    email : str = None
    address : str = None
    loyalty_count : int = None


class StatusResponse(BaseModel):
    order_id : int = None
    order_status : str = None


class Login(BaseModel):
    email : str = None
    password : str = None

class User(BaseModel):  # for register
    email : str = None
    password : str = None
    name : str = None
    address : str = None
    is_customer : bool = True

class UserResponse(BaseModel):
    user_id : int = None
    is_customer : bool = None
    name : str = None
    email : str = None
    address : str = None
    loyalty_count : int = None

class Response(BaseModel):
    status : bool = True
    message : str = "Success"
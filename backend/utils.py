from pydantic import BaseModel
from typing import List

"""
fotoğraflar nasıl tutulacak
"""

class Product(BaseModel):
    coffee_name : str = None 
    photo_path : str = None
    small_cup_only : bool = None
    milk : bool = None             # 0 for amer 1 for others
    chocolate_syrup : bool = None  # 1 for mocha 0 for others
    white_chocolate_syrup : bool = None
    caramel_syrup : bool = None
    sugar : bool = None
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
    extra_shot : bool = None 
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

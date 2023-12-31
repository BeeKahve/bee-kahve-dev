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

class WebLogin(BaseModel):
    email : str = None
    hashedValue : str = None
    is_admin : bool = None

class WebUserRegistration(BaseModel):   # for web register
    user_id : str = None
    email : str = None
    hashedValue : str = None
    name : str = None
    address : str = None
    admin_id : int = None
    is_admin : bool = None

class WebUser(BaseModel):  # for web login
    user_id : str = None
    is_admin : bool = None
    name : str = None
    email : str = None
    address : str = None
    stock_id : int = None

class Login(BaseModel):
    email : str = None
    password : str = None

class User(BaseModel):  # for register
    email : str = None
    password : str = None
    name : str = None
    address : str = None

class UserResponse(BaseModel):
    user_id : int = None
    is_customer : bool = None
    name : str = None
    email : str = None
    address : str = None
    loyalty_count : int = None

class Response(BaseModel):
    body : BaseModel = BaseModel()
    status : bool = True
    message : str = "Success"


class Address(BaseModel):
    customer_id : int = None
    address : str = None

class Rate(BaseModel):
    product_id : int = None
    rate : int = None


class Stock(BaseModel):
    small_cup_count : int = None
    medium_cup_count : int = None
    large_cup_count : int = None
    espresso_amount : float = None
    decaff_espresso_amount : float = None
    whole_milk_amount : float = None
    reduced_fat_milk_amount : float = None
    lactose_free_milk_amount : float = None
    oat_milk_amount : float = None
    almond_milk_amount : float = None
    chocolate_syrup_amount : float = None
    white_chocolate_syrup_amount : float = None
    caramel_syrup_amount : float = None
    sugar_amount : float = None
    ice_amount : float = None

class ProductIngredient(BaseModel):
    espresso_amount : float = None
    milk_amount : float = None
    foam_amount : float = None
    chocolate_syrup_amount : float = None
    caramel_syrup_amount : float = None
    white_chocolate_syrup_amount : float = None
    sugar_amount : float = None
    ice_amount : float = None
    price : float = None

class ProductFull(BaseModel):
    admin_id : int = None
    coffee_name : str = None
    photo_path : str = None
    small_cup_only : bool = None
    price : float = None
    rate : float = None
    espresso_amount : float = None
    milk_amount : float = None
    foam_amount : float = None
    chocolate_syrup_amount : float = None
    caramel_syrup_amount : float = None
    white_chocolate_syrup_amount : float = None
    sugar_amount : float = None
    ice_amount : float = None
    
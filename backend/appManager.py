from utils import *
from database import *

"""
fotoğraflar nasıl tutulacak
"""

class Manager:
    order_status = {
        0 : "waiting"
        }
    menu_state = 0
    
    def register():
        pass
        
    def login():
        pass
        
    def get_menu():
        contents = 0 #response of db class
        menu = ProductMenu()
        return menu
    
    def get_product(product_id):
        # gets the contents of the product from db
        product = Product()
        return product
        
    def place_order(order : Order):
        # place order to db
        ret_status = StatusResponse()
        return status
        
    def get_status(order_id = 0):
        # if necessary check the db
        status = StatusResponse(order_status= order_status[0])
        return status
        
    def get_history(customer_id):
        # collect data from db
        history = Orders()
        return history
    
    def update_address():
        pass
        
    def rate():
        pass
    
    
    #jwt token
    

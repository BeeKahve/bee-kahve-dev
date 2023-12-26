from utils import *
from database import DatabaseManager

"""
fotoğraflar nasıl tutulacak
"""

class Manager:
    order_status = {
        0 : "waiting"
    }
    menu_state = 0
    

    def __init__(self):
        self.database_manager = DatabaseManager(db_host="localhost", db_user="test", db_password="test", db_name="bee_kahve_db")
    

    def register(self):
        pass


    def login(self):
        pass


    def get_menu(self):
        contents = 0 #response of db class
        menu = ProductMenu(self)
        return menu


    def get_product(self, product_id):
        # gets the contents of the product from db
        product = Product()
        return product


    def place_order(self, order : Order):
        status = self.database_manager.place_order(order)
        # status = StatusResponse()
        return status
        

    def get_status(self, order_id = 0):
        # if necessary check the db
        status = StatusResponse(order_status=self.order_status[0])
        return status


    def get_history(self, customer_id):
        # collect data from db
        history = Orders()
        return history
    

    def update_address(self):
        pass
        

    def rate(self):
        pass
    
    
    #jwt token
    

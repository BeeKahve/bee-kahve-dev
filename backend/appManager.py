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
        # self.database_manager = DatabaseManager(db_host="localhost", db_user="test", db_password="test", db_name="bee_kahve_db")
        pass

    def register(self, user: User):
        # register_status = self.database_manager.regkister(user)
        register_status = True
        if register_status:
            return Response(status=register_status ,message="User is registered successfully.")
        else:
            return Response(status=register_status ,message="User is not registered.")



    def login(self, credentials: Login):
        # login_status = self.database_manager.login(credentials)
        login_status = True
        if login_status:
            return Response(status=login_status ,message="User is logged in successfully.")
        else:
            return Response(status=login_status ,message="User is not logged in.")



    def get_menu(self):
        contents = 0 #response of db class
        # menu = self.database_manager.get_menu()
        menu = ProductMenu(self)
        return menu


    def get_product(self, product_id):
        # gets the contents of the product from db
        # product = self.database_manager.get_product(product_id)
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
        # history = self.database_manager.get_history(customer_id)
        history = Orders()
        return history
    

    def update_address(self, customer_id, address):
        # status = self.database_manager.update_address(customer_id, address)
        status = True
        if status:
            return Response(status=status ,message="Address is updated successfully.")
        else:
            return Response(status=status ,message="Address is not updated.")
        

    def rate(self, product_id, rate):
        # status = self.database_manager.rate(product_id, rate)
        status = True
        if status:
            return Response(status=status ,message="Rate is updated successfully.")
        else:
            return Response(status=status ,message="Rate is not updated.")

    
    
    #jwt token
    

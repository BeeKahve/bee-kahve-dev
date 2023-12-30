from utils import *
from database import DatabaseManager

"""
fotoğraflar nasıl tutulacak
"""

class Manager:
    order_status = {
        0 : "waiting"
    }
    

    def __init__(self):
        self.database_manager = DatabaseManager(db_host="localhost", db_user="test", db_password="test", db_name="bee_kahve_db")
        pass

    def register(self, user: User):
        # register_status = self.database_manager.regkister(user)
        register_status = True
        if register_status:
            return Response(status=register_status ,message="User is registered successfully.")
        else:
            return Response(status=register_status ,message="User is not registered.")



    def login(self, credentials: Login): ##
        # status = self.database_manager.login(credentials)
        status = True
        if status:
            # status, user = self.database_manager.get_user(credentials)
            user = User()
            if status:
                response = Response(status=status ,message="Login is successful.")
                response.body = user
                return response
            else:
                return Response(status=status ,message="User can not fetched.")
        else:
            return Response(status=status ,message="Login is not successful.")


    def get_menu(self):
        contents = 0 #response of db class
        # status, menu = self.database_manager.get_menu()
        menu = ProductMenu()
        status = True
        if status:
            return Response(body=menu, status=status ,message="Menu is fetched successfully.")
        else:
            return Response(status=status ,message="Menu is not fetched.")
        

    def get_product(self, product_id):
        # gets the contents of the product from db
        # product = self.database_manager.get_product(product_id)
        product = Product()
        status = True
        if status:
            return Response(body=product, status=status ,message="Product is fetched successfully.")
        else:
            return Response(status=status ,message="Product is not fetched.")


    def place_order(self, order : Order):
        status = self.database_manager.place_order(order)
        status = True
        if status:
            return Response(status=status ,message="Order is placed successfully.")
        else:
            return Response(status=status ,message="Order is not placed.")


    def get_status(self, order_id = 0):
        # if necessary check the db
        # status, order_status = self.database_manager.get_status(order_id)
        order_status = StatusResponse(order_status=self.order_status[0])
        status = True
        if status:
            return Response(body=order_status, status=status ,message="Status is fetched successfully.")
        else:
            return Response(status=status ,message="Status is not fetched.")


    def get_history(self, customer_id):
        # collect data from db
        # status, history = self.database_manager.get_history(customer_id)
        history = Orders()
        status = True
        if status:
            return Response(body=history, status=status ,message="History is fetched successfully.")
        else:
            return Response(status=status ,message="History is not fetched.")
    

    def update_address(self, customer_id, address):
        # status = self.database_manager.update_address(customer_id, address)
        status = True
        if status:
            return Response(status=status ,message="Address is updated successfully.")
        else:
            return Response(status=status ,message="Address is not updated.")
        

    def rate(self, product_id, rate):
        # current_rate, rate_count = self.database_manager.get_rate(product_id)
        # updated_rate = (current_rate * rate_count + rate) / (rate_count + 1)
        # status = self.database_manager.update_rate(product_id, updated_rate, rate_count + 1)
        
        status = True
        if status:
            return Response(status=status ,message="Rate is updated successfully.")
        else:
            return Response(status=status ,message="Rate is not updated.")

    
    
    #jwt token
    

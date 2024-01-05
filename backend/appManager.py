from utils import *
from database import DatabaseManager
import datetime

"""
fotoğraflar nasıl tutulacak
"""

class Manager:
    def __init__(self):
        self.database_manager = DatabaseManager(db_host="localhost", db_user="test", db_password="test", db_name="bee_kahve_db")
        self.database_manager.set_timeout_values()
        pass

    def get_dict(self, obj):
        return obj.dict()
    
    def web_login(self, credentials: WebLogin):
        status, user = self.database_manager.get_webuser(credentials)
        if status:
            response = Response(body=user, status=status ,message="Login is successful.")
            return response
        else:
            return Response(status=status ,message="User can not fetched.")

    def web_register(self, user: WebUserRegistration):
        registerResponse = self.database_manager.web_register(user)
        # if register_status:
        #     return Response(status=register_status ,message="User is registered successfully.")
        # else:
        #     return Response(status=register_status ,message="User is not registered.")
        return registerResponse
    
    def register(self, user: User):
        registerResponse = self.database_manager.customer_register(user)
        # if registerResponse:
        #     return Response(status=registerResponse ,message="User is registered successfully.")
        # else:
        #     return Response(status=registerResponse ,message="User is not registered.")
        return registerResponse

    def login(self, credentials: Login): ##
        status = self.database_manager.login(credentials)
        if status:
            status, user = self.database_manager.get_customer(credentials)
            if status:
                return Response(body=user, status=status ,message="Login is successful.")
            else:
                return Response(status=status ,message="User can not fetched.")
        else:
            return Response(status=status ,message="User can not found.")


    def get_menu(self): # Gets the menu from db
        status, menu = self.database_manager.get_menu()
        if status:
            return Response(body=menu, status=status ,message="Menu is fetched successfully.")
        else:
            return Response(status=status ,message="Menu can not fetched.")
        

    def get_product(self, product_id): # Gets the product for UI

        status, product = self.database_manager.get_product(product_id)
        if status:
            return Response(body=product, status=status ,message="Product is fetched successfully.")
        else:
            return Response(status=status ,message="Product can not fetched.")


    def get_coefficient(self, size_choice):
        if size_choice == "small":
            return 1
        elif size_choice == "medium":
            return 1.5
        elif size_choice == "large":
            return 2
        else:
            return 0


    def place_order(self, order : Order):
        
        # calculate total ingrediants
        total_ingrediants = Stock().dict()
        for ingredient in total_ingrediants:
            total_ingrediants[ingredient] = 0
        
        for item in order.line_items:
            if item.milk_choice == None:
                item.milk_choice = "no_milk"
            coeff = self.get_coefficient(item.size_choice)
            if coeff == 0:
                return Response(status=False ,message="Size choice is not valid.")
            ingredients = self.database_manager.get_product_ingredient(item.product_id).dict()
            for ingredient in ingredients:
                if ingredient == "milk_amount":
                    if item.milk_choice == "whole_milk":
                        total_ingrediants["whole_milk_amount"] += ingredients[ingredient] * coeff
                    elif item.milk_choice == "reduced_fat_milk":
                        total_ingrediants["reduced_fat_milk_amount"] += ingredients[ingredient] * coeff
                    elif item.milk_choice == "lactose_free_milk":
                        total_ingrediants["lactose_free_milk_amount"] += ingredients[ingredient] * coeff
                    elif item.milk_choice == "oat_milk":
                        total_ingrediants["oat_milk_amount"] += ingredients[ingredient] * coeff
                    elif item.milk_choice == "almond_milk":
                        total_ingrediants["almond_milk_amount"] += ingredients[ingredient] * coeff
                    elif ingredients[ingredient] > 0:
                        return Response(status=False ,message="Milk choice is not valid.")
                
                elif ingredient == "espresso_amount":
                    
                    extra_shot = 1
                    if item.extra_shot_choice == True:
                        extra_shot = 2
                    
                    if item.caffein_choice == False:
                        total_ingrediants["decaff_espresso_amount"] += ingredients[ingredient] * coeff * extra_shot
                    elif item.caffein_choice == True:
                        total_ingrediants["espresso_amount"] += ingredients[ingredient] * coeff * extra_shot
                    else:
                        return Response(status=False ,message="Caffein choice is not valid.")
                        
                elif ingredient == "foam_amount":
                    if not item.milk_choice == "no_milk" and not item.milk_choice == None:
                        total_ingrediants[item.milk_choice+"_amount"] += 0.2 * ingredients[ingredient] * coeff
                
                elif ingredient == "price":
                    pass
                
                else:
                    try:
                        total_ingrediants[ingredient] += ingredients[ingredient] * coeff
                    except Exception as e:
                        print("Error: ", e)
                        return Response(status=False ,message="Ingredient is not valid.")
                
                total_ingrediants[item.size_choice+"_cup_count"] += 1

            if item.price == 0:
                self.database_manager.decrease_loyalty_count(order.customer_id)

        # check stock
        status, stock = self.database_manager.get_stock() #TODO admin_id or stock_id
        stock_dict = stock.dict()
        for ingredient in total_ingrediants:
            if stock_dict[ingredient] < total_ingrediants[ingredient]:
                return Response(status=False ,message="Stock is not enough for {}.".format(ingredient))
        
        # place order
        order.order_date = str(datetime.datetime.now())[:-4]
        status = self.database_manager.place_order(order)
        if not status:
            return Response(status=False ,message="Order cannot be placed.")
        
        # update stock
        for ingredient in total_ingrediants:
            stock_dict[ingredient] -= total_ingrediants[ingredient]
        
        status = self.database_manager.update_stock(Stock(**stock_dict)) #TODO admin_id or stock_id
        if not status:
            return Response(status=False ,message="Order placed, but stock cannot be updated.")
        
        # update loyalty count
        total_coffee_count = len(order.line_items)
        status = self.database_manager.add_to_loyalty_count(order.customer_id, total_coffee_count)

        if status:
            return Response(status=status ,message="Stock updated, order is placed successfully.")
        else:
            return Response(status=status ,message="Stock updated, order is placed, an error occured in loyalty update!!")


    def get_status(self, order_id = 0):
        # if necessary check the db
        status, order_status = self.database_manager.get_status(order_id)
        if status:
            return Response(body=order_status, status=status ,message="Status is fetched successfully.")
        else:
            return Response(status=status ,message="Status is not fetched.")

    def set_status(self, order_id, status):
        status = self.database_manager.set_status(order_id, status)
        if status:
            return Response(status=status ,message="Status is updated successfully.")
        else:
            return Response(status=status ,message="Status is not updated.")

    def get_history(self, customer_id):
        status, history = self.database_manager.get_history(customer_id)
        status = True
        if status:
            return Response(body=history, status=status ,message="History is fetched successfully.")
        else:
            return Response(status=status ,message="History is not fetched.")


    def update_address(self, customer_id, address):
        status = self.database_manager.update_address(customer_id, address)
        if status:
            return Response(status=status ,message="Address is updated successfully.")
        else:
            return Response(status=status ,message="Address is not updated.")


    def rate(self, product_id, rate):
        status, current_rate, rate_count = self.database_manager.get_rate(product_id)
        if not status:
            return Response(status=status ,message="Rate could not fetched.")
        
        updated_rate = (current_rate * rate_count + rate) / (rate_count + 1)
        status = self.database_manager.update_rate(product_id, updated_rate, rate_count + 1)
        
        if status:
            return Response(status=status ,message="Rate is updated successfully.")
        else:
            return Response(status=status ,message="Rate is not updated.")


    def get_stock(self, stock_id=None):
        status, stock = self.database_manager.get_stock() #TODO admin_id or stock_id
        if status:
            return Response(body=stock, status=status ,message="Stock is fetched successfully.")
        else:
            return Response(status=status ,message="Stock is not fetched.")


    def update_stock(self, stock, admin_id=1):
        items = self.get_dict(stock)
        for item in items:
            if items[item] != None:
                if item == "sugar_amount":
                    send_item = "white_sugar_amount"
                else:
                    send_item = item
                status = self.database_manager.update_stock_item(admin_id, send_item, items[item])
                if not status:
                    return Response(status=status ,message=f"Stock is not updated,{item}.")
        
        # status = self.database_manager.update_stock(stock)
        if status:
            return Response(status=status ,message="Stock is updated successfully.")
        else:
            return Response(status=status ,message="Stock is not updated.")
        
    def add_product(self, product):
        status = self.database_manager.add_product(product)
        if status:
            return Response(status=status ,message="Product is added successfully.")
        else:
            return Response(status=status ,message="Product is not added.")
        
    def get_active_orders(self, admin_id):
        status, orders = self.database_manager.get_active_orders(admin_id)
        if status:
            return Response(body=orders, status=status ,message="Active orders are fetched successfully.")
        else:
            return Response(status=status ,message="Active orders are not fetched.")

    def get_waiting_orders(self, admin_id):
        status, orders = self.database_manager.get_waiting_orders(admin_id)
        if status:
            return Response(body=orders, status=status ,message="Waiting orders are fetched successfully.")
        else:
            return Response(status=status ,message="Waiting orders are not fetched.")

    def get_full_product(self, product_id):
        status, product = self.database_manager.get_full_product(product_id)
        if status:
            return Response(body=product, status=status ,message="Product is fetched successfully.")
        else:
            return Response(status=status ,message="Product is not fetched.")
        
    def update_product(self, product_id, product):
        status = self.database_manager.update_product(product_id, product)
        if status:
            return Response(status=status ,message="Product is updated successfully.")
        else:
            return Response(status=status ,message="Product can not updated.")
    
    def delete_product(self, product_id):
        status = self.database_manager.delete_product(product_id)
        if status:
            return Response(status=status ,message="Product is deleted successfully.")
        else:
            return Response(status=status ,message="Product can not be deleted.")

    def get_address(self, customer_id):
        status, address = self.database_manager.get_address(customer_id)
        if status:
            return Response(body=address, status=status ,message="Address is fetched successfully.")
        else:
            return Response(status=status ,message="Address is not fetched.")

    #jwt token

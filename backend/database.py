from utils import *
import mysql.connector


class Database:

    def __init__(self, host, user, password, database):
        self.connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )
        self.cursor = self.connection.cursor()

    
    def execute_query(self, query, values=None):
        try:
            if values:
                self.cursor.execute(query, values)
            else:
                self.cursor.execute(query)
            self.connection.commit()
            return True
        except Exception as e:
            print(f"Error executing query: {e}")
            return False
    

    def fetch_data(self, query, values=None):
        try:
            if values:
                self.cursor.execute(query, values)
            else:
                self.cursor.execute(query)
            result = self.cursor.fetchall()
            return result
        except Exception as e:
            print(f"Error fetching data: {e}")
            return None
    

    def close_connection(self):
        self.cursor.close()
        self.connection.close()


# order.order_id comes unique from ui, not auto incremented in db
class DatabaseManager:
    active_order_status = [
        "preparing",
        "on_the_way",
    ]
    
    def __init__(self, db_host, db_user, db_password, db_name):
        self.database = Database(db_host, db_user, db_password, db_name)


    def get_product_ingredient(self, product_id):
        query_product = "SELECT * FROM Products WHERE product_id = %s"  # list of tuples. each tuple is a product
        product = self.database.fetch_data(query_product, (product_id,))

        if product == []:
            return None
        
        product = product[0]

        # [(1, 'Coffee Name', 'Photo path', 40.0, 100.0, None, None, None, None, 0, 60.0, 0.0, 0, 0)][0]
        return ProductIngredient(espresso_amount=product[3],
                                 milk_amount=product[4],
                                 foam_amount=product[5],
                                 chocolate_syrup_amount=product[6],
                                 caramel_syrup_amount=product[7],
                                 white_chocolate_syrup_amount=product[8],
                                 sugar_amount=product[9],
                                 ice_amount=product[10],
                                 price=product[12])


    def get_stock_by_id(self, admin_id):
        pass


    def get_webuser(self, credentials: WebLogin):
        is_admin = credentials.is_admin

        if is_admin:
            query_admin = "SELECT * FROM Admins WHERE admin_email = %s"
            admin = self.database.fetch_data(query_admin, (credentials.email,))
            
            if admin == []:
                return False, None

            admin = admin[0]
            if credentials.hashedValue == admin[4]:
                return True, WebUser(user_id=admin[0],
                                     is_admin=True,
                                     name=1,
                                     email=admin[3],
                                     address=admin[5],
                                     stock_id=admin[2])
            else:
                return False, None
        
        else:
            query_employee = "SELECT * FROM Employees WHERE employee_email = %s"
            employee = self.database.fetch_data(query_employee, (credentials.email,))
            
            if employee == []:
                return False, None
            
            employee = employee[0]
            if credentials.hashedValue == employee[3]:
                return True, WebUser(user_id=employee[0],
                                     is_admin=False,
                                     name=employee[1],
                                     email=employee[2])
            else:
                return False, None

    # check
    def web_register(self, user: WebUserRegistration):
        is_admin = user.is_admin

        if is_admin:
            query_admin = "SELECT * FROM Admins WHERE admin_email = %s"
            admin = self.database.fetch_data(query_admin, (user.email,))

            if admin != []:
                return Response(status=False, message="Email already exists")

            query_insert_admin = "INSERT INTO Admins (admin_name, admin_email, admin_password, admin_address) VALUES (%s, %s, %s, %s)"
            values_insert_admin = (user.name, user.email, user.hashedValue, user.address)

            if self.database.execute_query(query_insert_admin, values_insert_admin):
                return Response(status=True, message="Success")
            else:
                return Response(status=False, message="Error inserting admin")

        else:
            query_employee = "SELECT * FROM Employees WHERE employee_email = %s"
            employee = self.database.fetch_data(query_employee, (user.email,))

            if employee != []:
                return Response(status=False, message="Email already exists")

            query_insert_employee = "INSERT INTO Employees (employee_name, employee_email, employee_password, admin_id) VALUES (%s, %s, %s, %s)"
            values_insert_employee = (user.name, user.email, user.hashedValue, user.admin_id)

            if self.database.execute_query(query_insert_employee, values_insert_employee):
                return Response(status=True, message="Success")
            else:
                return Response(status=False, message="Error inserting employee")
    
    # check
    def customer_register(self, user : User):
        query_user = "SELECT * FROM Customers WHERE customer_email = %s"
        test_user = self.database.fetch_data(query_user, (user.email,))
        
        if test_user != []:
            return Response(status=False, message="Email already exists")
        
        query_insert_user = "INSERT INTO Customers (customer_name, customer_email, customer_password, customer_address) VALUES (%s, %s, %s, %s)"
        values_insert_user = (user.name, user.email, user.password, user.address)

        if self.database.execute_query(query_insert_user, values_insert_user):
            return Response(status=True, message="Success")
        else:
            return Response(status=False, message="Error inserting user")
        
    # check
    def login(self, credentials: Login):
            query_user = "SELECT * FROM Customers WHERE customer_email = %s AND customer_password = %s"
            user = self.database.fetch_data(query_user, (credentials.email, credentials.password))
            
            if user == []:
                return False, None
            
            user = user[0]
            return True
    
    # check
    def get_customer(self, credentials: Login):
        query_user = "SELECT * FROM Customers WHERE customer_email = %s AND customer_password = %s"
        user = self.database.fetch_data(query_user, (credentials.email, credentials.password))
        
        if user == []:
            return False, None
        
        user = user[0]
        return True, Customer(customer_id=user[0],
                              name=user[1],
                              email=user[2],
                              address=user[4],
                              loyalty_count=user[5])
    
    # stock operations
    def update_stock_item(self, admin_id, item_name, item_value):

        query_update_stock_item = f"UPDATE Stocks SET {item_name} = %s WHERE stock_id = %s"
        values_update_stock_item = (item_value, admin_id)

        if self.database.execute_query(query_update_stock_item, values_update_stock_item):
            return True
        else:
            return False
    
   
   # check, update the indices of stock
    def get_stock(self, stock_id=1):
        query_stock = "SELECT * FROM Stocks WHERE stock_id = %s"
        stock = self.database.fetch_data(query_stock, (stock_id,))

        if stock == []:
            return False, None

        stock = stock[0]
        return True, Stock(small_cup_count=stock[1],
                        medium_cup_count=stock[2],
                        large_cup_count=stock[3],
                        espresso_amount=stock[4],
                        decaff_espresso_amount=stock[5],
                        whole_milk_amount=stock[6],
                        reduced_fat_milk_amount=stock[7],
                        lactose_free_milk_amount=stock[8],
                        oat_milk_amount=stock[9],
                        almond_milk_amount=stock[10],
                        chocolate_syrup_amount=stock[11],
                        white_chocolate_syrup_amount=stock[12],
                        caramel_syrup_amount=stock[13],
                        sugar_amount=stock[14],
                        ice_amount=stock[16])
    
    # check
    def update_stock(self, stock : Stock):
        stock_id = 1
        query_update_stock = "UPDATE Stocks SET small_cup_count = %s, medium_cup_count = %s, large_cup_count = %s, espresso_amount = %s, decaff_espresso_amount = %s, whole_milk_amount = %s, reduced_fat_milk_amount = %s, lactose_free_milk_amount = %s, oat_milk_amount = %s, almond_milk_amount = %s, chocolate_syrup_amount = %s, white_chocolate_syrup_amount = %s, caramel_syrup_amount = %s, white_sugar_amount = %s, ice_amount = %s WHERE stock_id = %s"
        values_update_stock = (stock.small_cup_count,
                               stock.medium_cup_count,
                               stock.large_cup_count,
                               stock.espresso_amount,
                               stock.decaff_espresso_amount,
                               stock.whole_milk_amount,
                               stock.reduced_fat_milk_amount,
                               stock.lactose_free_milk_amount,
                               stock.oat_milk_amount,
                               stock.almond_milk_amount,
                               stock.chocolate_syrup_amount,
                               stock.white_chocolate_syrup_amount,
                               stock.caramel_syrup_amount,
                               stock.sugar_amount,
                               stock.ice_amount,
                               stock_id)

        if self.database.execute_query(query_update_stock, values_update_stock):
            return True
        else:
            return False



    def get_product(self, product_id):
        query_product = "SELECT * FROM Products WHERE product_id = %s"  # list of tuples. each tuple is a product
        product = self.database.fetch_data(query_product, (product_id,))
        
        if product == []:
            return False, None

        product = product[0]
        return True, Product(coffee_name=product[1],
                             photo_path=product[2],
                             small_cup_only=product[11],
                             contains_milk=(product[4] > 0),
                             contains_chocolate_syrup=(product[6] > 0),
                             contains_white_chocolate_syrup=(product[8] > 0),
                             contains_caramel_syrup=(product[7] > 0),
                             contains_sugar=(product[9] > 0),
                             price=product[12],
                             rate=product[13])
    
    
    # check
    def get_menu(self):
        query_menu = "SELECT * FROM Products"
        products = self.database.fetch_data(query_menu)

        if products == []:
            return False, None

        menu_products = []
        for product in products:
            menu_products.append(MenuProduct(product_id=product[0],
                                            name=product[1],
                                            photo_path=product[2],
                                            rate=product[13],
                                            price=product[12]))
            
        return True, ProductMenu(menuProducts=menu_products, product_count=len(menu_products))
    
    
    # check
    def get_status(self, order_id):
        query_order = "SELECT order_status FROM Orders WHERE order_id = %s"
        order_status = self.database.fetch_data(query_order, (order_id,))[0][0]

        if order_status == []:
            return False, None
        
        return True, StatusResponse(order_status=order_status)


    # check
    def set_status(self, order_id, status):
        query_update_status = "UPDATE Orders SET order_status = %s WHERE order_id = %s"
        values_update_status = (status, order_id)

        if self.database.execute_query(query_update_status, values_update_status):
            return True
        else:
            return False
    
    # check
    def add_to_loyalty_count(self, customer_id, loyalty_count):
        query_update_loyalty = "UPDATE Customers SET loyalty_coffee_count = loyalty_coffee_count + %s WHERE customer_id = %s"
        values_update_loyalty = (loyalty_count, customer_id)

        if self.database.execute_query(query_update_loyalty, values_update_loyalty):
            return True
        else:
            return False
    
    
    # check
    def get_history(self, customer_id):
        query_orders = "SELECT * FROM Orders WHERE customer_id = %s"
        orders = self.database.fetch_data(query_orders, (customer_id,))
        orders_list = []
        for order in orders:
            query_line_items = "SELECT * FROM Line_Items WHERE order_id = %s"
            line_items = self.database.fetch_data(query_line_items, (order[0],))
            line_items_list = []
            for line_item in line_items:
                query_product = "SELECT * FROM Products WHERE product_id = %s"
                product = self.database.fetch_data(query_product, (line_item[2],))[0]
                line_items_list.append(LineItem(product_id=product[0],
                                                name=product[1],
                                                photo_path=product[2],
                                                price=product[12],
                                                size_choice=line_item[3],
                                                milk_choice=line_item[4],
                                                extra_shot_choice=line_item[5],
                                                caffein_choice=line_item[6]))
            orders_list.append(Order(customer_id=order[1],
                                     order_id=order[0],
                                     line_items=line_items_list,
                                     order_date=order[2],
                                     order_status=order[3]))
        return True, Orders(customer_name="",
                            orders=orders_list,
                            order_count=len(orders_list))

    # check
    def update_address(self, customer_id, address):
        query_update_address = "UPDATE Customers SET customer_address = %s WHERE customer_id = %s"
        values_update_address = (address, customer_id)

        if self.database.execute_query(query_update_address, values_update_address):
            return True
        else:
            return False
    
    # check
    def update_rate(self, product_id, rate, rate_count):
        query_update_rate = "UPDATE Products SET rate = %s, rate_count = %s WHERE product_id = %s"
        values_update_rate = (rate, rate_count, product_id)

        if self.database.execute_query(query_update_rate, values_update_rate):
            return True
        else:
            return False
    
    # check
    def get_rate(self, product_id):
        query_rate = "SELECT rate, rate_count FROM Products WHERE product_id = %s"
        result = self.database.fetch_data(query_rate, (product_id,))

        if result == []:
            return False, None, None
        
        result = result[0]

        rate = result[0]
        rate_count = result[1]

        return True, rate, rate_count
    
    # check
    def add_product(self, product: ProductFull): # admin_id not used
        query_insert_product = "INSERT INTO Products (coffee_name, photo_path, small_cup_only, price, rate, rate_count, espresso_amount, milk_amount, foam_amount, chocolate_syrup_amount, caramel_syrup_amount, white_chocolate_syrup_amount, sugar_amount, ice_amount) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        values_insert_product = (product.coffee_name,
                                 product.photo_path,
                                 product.small_cup_only,
                                 product.price,
                                 product.rate,
                                 product.rate_count,
                                 product.espresso_amount,
                                 product.milk_amount,
                                 product.foam_amount,
                                 product.chocolate_syrup_amount,
                                 product.caramel_syrup_amount,
                                 product.white_chocolate_syrup_amount,
                                 product.sugar_amount,
                                 product.ice_amount)

        if self.database.execute_query(query_insert_product, values_insert_product):
            return True
        else:
            return False
    

    # check
    def get_active_orders(self, admin_id=1):

        query_orders = "SELECT * FROM Orders WHERE order_status IN %s"
        orders = self.database.fetch_data(query_orders, (self.active_order_status,))
        orders_list = []
        for order in orders:
            query_line_items = "SELECT * FROM Line_Items WHERE order_id = %s"
            line_items = self.database.fetch_data(query_line_items, (order[0],))
            line_items_list = []
            for line_item in line_items:
                query_product = "SELECT * FROM Products WHERE product_id = %s"
                product = self.database.fetch_data(query_product, (line_item[2],))[0]
                line_items_list.append(LineItem(product_id=product[0],
                                                name=product[1],
                                                photo_path=product[2],
                                                price=product[12],
                                                size_choice=line_item[3],
                                                milk_choice=line_item[4],
                                                extra_shot_choice=line_item[5],
                                                caffein_choice=line_item[6]))
            orders_list.append(Order(customer_id=order[1],
                                     order_id=order[0],
                                     line_items=line_items_list,
                                     order_date=order[2],
                                     order_status=order[3]))
        return True, Orders(customer_name="",
                            orders=orders_list,
                            order_count=len(orders_list))
    
    # check
    def get_waiting_orders(self, admin_id):
        query_orders = "SELECT * FROM Orders WHERE order_status = %s"
        orders = self.database.fetch_data(query_orders, ("waiting",))
        orders_list = []
        for order in orders:
            query_line_items = "SELECT * FROM Line_Items WHERE order_id = %s"
            line_items = self.database.fetch_data(query_line_items, (order[0],))
            line_items_list = []
            for line_item in line_items:
                query_product = "SELECT * FROM Products WHERE product_id = %s"
                product = self.database.fetch_data(query_product, (line_item[2],))[0]
                line_items_list.append(LineItem(product_id=product[0],
                                                name=product[1],
                                                photo_path=product[2],
                                                price=product[12],
                                                size_choice=line_item[3],
                                                milk_choice=line_item[4],
                                                extra_shot_choice=line_item[5],
                                                caffein_choice=line_item[6]))
            orders_list.append(Order(customer_id=order[1],
                                     order_id=order[0],
                                     line_items=line_items_list,
                                     order_date=order[2],
                                     order_status=order[3]))
        return True, Orders(customer_name="",
                            orders=orders_list,
                            order_count=len(orders_list))


    # check
    def get_full_product(self, product_id):
        query_product = "SELECT * FROM Products WHERE product_id = %s"  # list of tuples. each tuple is a product
        product = self.database.fetch_data(query_product, (product_id,))
        
        if product == []:
            return False, None

        product = product[0]
        return True, ProductFull(coffee_name=product[1],
                                 photo_path=product[2],
                                 small_cup_only=product[11],
                                 price=product[12],
                                 rate=product[13],
                                 rate_count=product[14],
                                 espresso_amount=product[3],
                                 milk_amount=product[4],
                                 foam_amount=product[5],
                                 chocolate_syrup_amount=product[6],
                                 caramel_syrup_amount=product[7],
                                 white_chocolate_syrup_amount=product[8],
                                 sugar_amount=product[9],
                                 ice_amount=product[10],
                                 is_product_disabled=product[15])


    # check
    def update_product(self, product_id, product: ProductFull):
        query_update_product = "UPDATE Products SET coffee_name = %s, photo_path = %s, small_cup_only = %s, price = %s, rate = %s, rate_count = %s, espresso_amount = %s, milk_amount = %s, foam_amount = %s, chocolate_syrup_amount = %s, caramel_syrup_amount = %s, white_chocolate_syrup_amount = %s, sugar_amount = %s, ice_amount = %s, is_product_disabled = %s WHERE product_id = %s"
        values_update_product = (product.coffee_name,
                                 product.photo_path,
                                 product.small_cup_only,
                                 product.price,
                                 product.rate,
                                 product.rate_count,
                                 product.espresso_amount,
                                 product.milk_amount,
                                 product.foam_amount,
                                 product.chocolate_syrup_amount,
                                 product.caramel_syrup_amount,
                                 product.white_chocolate_syrup_amount,
                                 product.sugar_amount,
                                 product.ice_amount,
                                 product.is_product_disabled,
                                 product_id)

        if self.database.execute_query(query_update_product, values_update_product):
            return True
        else:
            return False
    

    def delete_product(self, product_id):
        query_product = "DELETE FROM Products WHERE product_id = %s"
        return self.database.execute_query(query_product, (product_id,))


    # Returns None if an insertion failed, "waiting" otherwise.
    def place_order(self, order : Order):
        query_orders = "INSERT INTO Orders (customer_id, order_date, order_status) VALUES (%s, %s, %s)"
        values_orders = (order.customer_id, order.order_date, order.order_status)

        query_order_id = "SELECT order_id FROM Orders WHERE order_date = %s"
        order.order_id = self.database.fetch_data(query_order_id, (order.order_date,))

        if self.database.execute_query(query_orders, values_orders):
            failure = False

            status_response = StatusResponse(order_status=order.order_status)

            line_items = order.line_items
            for line_item in line_items:
                query_product_price = "SELECT price FROM Products WHERE product_id = %s"
                product_price = self.database.fetch_data(query_product_price, (line_item.product_id,))[0][0]
                query_line_items = "INSERT INTO Line_Items (order_id, product_id, size_choice, milk_choice, extra_shot_choice, caffein_choice, price) VALUES (%s, %s, %s, %s, %s, %s, %s)"
                values_line_items = (order.order_id, line_item.product_id, line_item.size_choice, line_item.milk_choice, line_item.extra_shot_choice, line_item.caffein_choice, product_price)

                if not self.database.execute_query(query_line_items, values_line_items):
                    failure = True
            
            if not failure:
                return status_response
        
        return None
    
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
    order_status = {
        0 : "waiting"
    }

    
    def __init__(self, db_host, db_user, db_password, db_name):
        self.database = Database(db_host, db_user, db_password, db_name)


    def get_product_by_id(self, product_id):
        query_product = "SELECT * FROM Products WHERE product_id = %s"  # list of tuples. each tuple is a product
        product = self.database.fetch_data(query_product, (product_id,))[0]
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

    
    def get_product(self, product_id):
        query_product = "SELECT * FROM Products WHERE product_id = %s"  # list of tuples. each tuple is a product
        product = self.database.fetch_data(query_product, (product_id,))[0]
        return Product(coffee_name=product[1],
                       photo_path=product[2],
                       small_cup_only=product[11],
                       contains_milk=(product[4] > 0),
                       contains_chocolate_syrup=(product[6] > 0),
                       contains_white_chocolate_syrup=(product[8] > 0),
                       contains_caramel_syrup=(product[7] > 0),
                       contains_sugar=(product[9] > 0),
                       price=product[12],
                       rate=product[13])


    # Returns None if an insertion failed, "waiting" otherwise.
    def place_order(self, order : Order):
        query_orders = "INSERT INTO Orders (customer_id, order_date, order_status) VALUES (%s, %s, %s)"
        values_orders = (order.customer_id, order.order_date, order.order_status)

        if self.database.execute_query(query_orders, values_orders):
            failure = False

            status_response = StatusResponse(order_status=self.order_status[0])

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
    
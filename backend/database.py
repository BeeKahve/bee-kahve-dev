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
    

    # Returns None if an insertion failed, "waiting" otherwise.
    def place_order(self, order : Order):
        query_orders = "INSERT INTO Orders (order_id, customer_id, order_date, order_status) VALUES (%s, %s, %s, %s)"
        values_orders = (order.order_id, order.customer_id, order.order_date, order.order_status)

        if self.database.execute_query(query_orders, values_orders):
            failure = False

            status_response = StatusResponse(order_status=self.order_status[0])

            line_items = order.line_items
            for line_item in line_items:
                query_line_items = "INSERT INTO Line_Items (order_id, product_id, size_choice, milk_choice, extra_shot_choice, caffein_choice) VALUES (%s, %s, %s, %s, %s, %s)"
                values_line_items = (order.order_id, line_item.product_id, line_item.size_choice, line_item.milk_choice, line_item.extra_shot_choice, line_item.caffein_choice)

                if not self.database.execute_query(query_line_items, values_line_items):
                    failure = True
            
            if not failure:
                return status_response
        
        return None
    
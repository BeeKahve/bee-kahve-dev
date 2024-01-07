from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    host = "http://51.20.117.162:8000"
    wait_time = between(3, 10)

    @task(5)  # Higher weight, more frequent execution
    def get_menu(self):
        self.client.get("/get_menu")

    @task(2)
    def get_full_product(self):
        product_id = 1
        self.client.get(f"/get_full_product?product_id={product_id}")
    
    @task(1)
    def web_login(self):
        credentials = {
            "email": "bla",
            "hashedValue": "bla",
            "is_admin": True
        }
        self.client.post("/web_login", json=credentials)

    @task(5)
    def get_waiting_orders(self):
        self.client.get("/get_waiting_orders?admin_id=1")

    @task(5)
    def get_active_orders(self):
        self.client.post("/get_active_orders?admin_id=1")

    @task(5)
    def get_address(self):
        self.client.get("/get_address?customer_id=1")

    @task(2)
    def get_stock(self):
        self.client.get("/get_stock?stock_id=1")

class CustomerUser(HttpUser):
    host = "http://51.20.117.162:8000"
    wait_time = between(1, 5)

    @task(7)  # Higher weight, more frequent execution
    def get_menu(self):
        self.client.get("/get_menu")

    @task(7)
    def get_product(self):
        product_id = 1  # Example product ID
        self.client.get(f"/get_product?product_id={product_id}")

    @task(1)
    def place_order(self):
        order = {
            "customer_id": 1,
            "order_id": 1,
            "line_items": [
                {
                    "product_id": 37,
                    "name": "Espresso",
                    "photo_path": "https://i.imgur.com/0YlUwYQ.png",
                    "price": 5.0,
                    "size_choice": "small",
                    "milk_choice": "no_milk",
                    "extra_shot_choice": False,
                    "caffein_choice": True
                }
            ],
            "order_status": "cancelled"
        }
        self.client.post("/place_order", json=order)

    @task(5)  
    def get_status(self):
        order_id = 1  # Example order ID
        self.client.get(f"/get_status?order_id={order_id}")

    @task(4)
    def login(self):
        credentials = {
            "email": "bla",
            "password": "bla"
        }
        self.client.post("/login", json=credentials)
    
    @task(2)
    def update_address(self):
        address = {
            "customer_id": 1,
            "address": "bla"
        }
        self.client.post("/update_address", json=address)

    @task(1)
    def get_history(self):
        self.client.get("/order_history?customer_id=1")

    @task(1)
    def rate(self):
        rate = {
            "product_id": 39,
            "rate": 5
        }
        self.client.post("/rate", json=rate)
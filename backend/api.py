import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import RedirectResponse
from utils import *
from appManager import *


app = FastAPI()
manager = Manager()

# origins = [
#     "http://localhost:3000",
#     "localhost:3000",
#     "http://localhost:8000",
#     "localhost:8000",
#     "http://localhost",
#     "localhost",
#     "http://bee-kahve.herokuapp.com",
#     "bee-kahve.herokuapp.com"
# ]

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["POST", "GET"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return RedirectResponse(url="/docs")

@app.post("/web_login")
async def web_login(credentials : WebLogin) -> WebUser:
    return manager.web_login(credentials).body

@app.post("/web_register")
async def web_register(user : WebUserRegistration) -> Response:
    return manager.web_register(user)

@app.post("/login")
async def login(credentials : Login) -> Customer:
    return manager.login(credentials).body

@app.post("/register")
async def register(user : User) -> Response:
    return manager.register(user)

@app.get("/get_menu")
async def get_menu() -> ProductMenu:
    return manager.get_menu().body


@app.get("/get_product")
async def get_product(product_id : int) -> Product:
    return manager.get_product(product_id).body


@app.post("/place_order")
async def place_order(order : Order) -> Response:
    return manager.place_order(order)


@app.get("/get_status")
async def get_status(order_id : int) -> StatusResponse:
    return manager.get_status(order_id).body

@app.get("/set_status")
async def set_status(order_id : int, status : str) -> Response:
    return manager.set_status(order_id, status)

@app.get("/order_history")
async def get_history(customer_id : int) -> Orders:
    return manager.get_history(customer_id).body

@app.post("/update_address")
async def update_adress(address : Address) -> Response:
    return manager.update_address(address.customer_id, address.address)

@app.post("/rate")
async def rate(rate : Rate) -> Response:
    return manager.rate(rate.product_id, rate.rate)

@app.get("/get_stock")
async def get_stock(stock_id : int) -> Stock:
    return manager.get_stock(stock_id).body

@app.post("/update_stock")
async def update_stock(stock : Stock) -> Response:
    return manager.update_stock(stock)

@app.post("/add_product")
async def add_product(product : ProductFull) -> Response:
    return manager.add_product(product)

@app.post("/get_active_orders")
async def get_active_orders(admin_id : int) -> Orders:
    return manager.get_active_orders(admin_id).body

@app.get("/get_waiting_orders")
async def get_waiting_orders(admin_id : int) -> Orders:
    return manager.get_waiting_orders(admin_id).body

@app.get("/get_full_product")
async def get_full_product(product_id : int) -> ProductFull:
    return manager.get_full_product(product_id).body

@app.post("/update_product")
async def update_product(product_id : int, product : ProductFull) -> Response:
    return manager.update_product(product_id,product)

@app.get("/delete_product")
async def delete_product(product_id : int) -> Response:
    return manager.delete_product(product_id)

@app.get("/get_address")
async def get_address(customer_id : int) -> Address:
    return manager.get_address(customer_id).body

@app.get("/get_customer")
async def get_customer(customer_id : int) -> Customer:
    return manager.get_customer(customer_id).body

if __name__ == "__main__":
    uvicorn.run(app,host="0.0.0.0", port=8000)

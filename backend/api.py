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


@app.post("/login")
async def login(credentials : Login) -> Customer:
    # check credentials
    return Customer()


@app.get("/get_menu")
async def get_menu() -> ProductMenu:
    return manager.get_menu()


@app.get("/get_product")
async def get_product(product_id : int) -> Product:
    return manager.get_product(product_id)


@app.post("/place_order")
async def place_order(order : Order) -> StatusResponse:
    return manager.place_order(order)


@app.get("/get_status")
async def get_status(order_id : int) -> StatusResponse:
    return manager.get_status(order_id)


@app.get("/order_history")
async def get_history(customer_id : int) -> Orders:
    return manager.get_history(customer_id)


if __name__ == "__main__":
    uvicorn.run(app,host="0.0.0.0", port=8000)

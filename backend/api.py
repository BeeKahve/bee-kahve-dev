import uvicorn
from fastapi import FastAPI
from fastapi.responses import RedirectResponse
from utils import *

app = FastAPI()


@app.get("/")
async def root():
    return RedirectResponse(url="/docs")


@app.post("/login")
async def login(credentials : Login) -> Customer:
    # check credentials
    return Customer()


@app.get("/get_menu")
async def get_menu() -> ProductMenu:
    return ProductMenu()


@app.get("/get_product")
async def get_product(product_id : int) -> Product:
    return Product()


@app.post("/place_order")
async def place_order(order : Order) -> StatusResponse:
    return StatusResponse(order_status="Waiting")


@app.get("/get_status")
async def get_status(order_id : int) -> StatusResponse:
    return StatusResponse(order_status= "Preparing")


@app.get("/order_history")
async def get_history(customer_id : int) -> Orders:
    return Orders()


if __name__ == "__main__":
    uvicorn.run(app,host="0.0.0.0", port=8000)

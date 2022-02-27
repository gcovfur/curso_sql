# Importação de bibliotecas utilizadas
from numpy import append
import pandas as pd
import sqlite3 as sl
import os

def create_database(con):
    with con:
        con.execute("""
            CREATE TABLE olist_customers_dataset (
                customer_id TEXT,
                customer_unique_id TEXT,
                customer_zip_code_prefix TEXT,
                customer_city TEXT,
                customer_state TEXT
            );
        """)

        con.execute("""
            CREATE TABLE olist_geolocation_dataset (
                geolocation_zip_code_prefix TEXT,
                geolocation_lat REAL,
                geolocation_lng REAL,
                geolocation_city TEXT,
                geolocation_state TEXT
            );
        """)

        con.execute("""
            CREATE TABLE olist_order_items_dataset (
                order_id TEXT,
                order_item_id TEXT,
                product_id TEXT,
                seller_id TEXT,
                shipping_limit_date DATETIME,
                price REAL,
                freight_value REAL
            );
        """)

        con.execute("""
            CREATE TABLE olist_order_payments_dataset (
                order_id TEXT,
                payment_sequential INTEGER,
                payment_type TEXT,
                payment_installments INTEGER,
                payment_value REAL
            );
        """)

        con.execute("""
            CREATE TABLE olist_order_reviews_dataset (
                review_id TEXT,
                order_id TEXT,
                review_score INTEGER,
                review_comment_title TEXT,
                review_comment_message TEXT,
                review_creation_date DATETIME,
                review_answer_timestamp DATETIME
            );
        """)

        con.execute("""
            CREATE TABLE olist_orders_dataset (
                order_id TEXT,
                customer_id TEXT,
                order_status TEXT,
                order_purchase_timestamp DATETIME,
                order_approved_at DATETIME,
                order_delivered_carrier_date DATETIME,
                order_delivered_customer_date DATETIME,
                order_estimated_delivery_date DATETIME
            );
        """)

        con.execute("""
            CREATE TABLE olist_products_dataset (
                product_id TEXT,
                product_category_name TEXT,
                product_name_lenght INTEGER,
                product_description_lenght INTEGER,
                product_photos_qty INTEGER,
                product_weight_g INTEGER,
                product_length_cm INTEGER,
                product_height_cm INTEGER,
                product_width_cm INTEGER
            );
        """)

        con.execute("""
            CREATE TABLE olist_sellers_dataset (
                seller_id TEXT,
                seller_zip_code_prefix TEXT,
                seller_city TEXT,
                seller_state TEXT
            );
        """)

        con.execute("""
            CREATE TABLE product_category_name_translation (
                product_category_name TEXT,
                product_category_name_english TEXT
            );
        """)

# Se o banco de dados já existir, remove o mesmo
if os.path.exists("olist_example.db"):
        os.remove("olist_example.db")
# Cria conexão para o banco
con = sl.connect('olist_example.db')
# Cria tabelas para setar tipos de dados corretos
create_database(con)
# Lê todos os arquivos que precisam ser inseridos em tabelas
files = [f for f in os.listdir('./db') if os.path.isfile(os.path.join('./db', f))]
# Para cada um dos arquivos
for f in files:
    # Lê arquivo csv para dataframe
    df = pd.read_csv('./db/' + f, sep=',', dtype=str)
    # Divide nome do arquivo removendo ".csv" para dar origem a tabela do banco
    table = f.split('.')
    # Cria tabela e insere registros
    df.to_sql(name=table[0], con=con, index=False, if_exists='append')

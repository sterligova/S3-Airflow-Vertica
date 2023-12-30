from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.decorators import dag
import pendulum
import pandas as pd
import vertica_python
from typing import List, Optional, Dict

conn_info = {
    'host': 'vertica.tgcloudenv.ru',
    'port': 5433,
    'user': 'stv2023111328',
    'password': '5YUuFPJ2513xIGa',
    'database': 'dwh',
    'autocommit': True
}

def load_dataset_file_to_vertica(
    dataset_path: str,
    schema: str,
    table: str,
    columns: List[str],
    type_override: Optional[Dict[str, str]] = None,
):
    df = pd.read_csv(dataset_path, dtype=type_override)
    print(df.head())
    num_rows = len(df)
    vertica_conn = vertica_python.connect(
        **conn_info
    )
    columns = ', '.join(columns)
    copy_expr = f"""
    COPY {schema}.{table} ({columns}) FROM STDIN DELIMITER ',' 
    """
    chunk_size = num_rows // 100
    with vertica_conn.cursor() as cur:
        start = 0
        while start <= num_rows:
            end = min(start + chunk_size, num_rows)
            print(f"loading rows {start}-{end}")
            df.loc[start: end].to_csv('/tmp/chunk.csv', index=False)
            with open('/tmp/chunk.csv', 'rb') as chunk:
                cur.copy(copy_expr, chunk, buffer_size=65536)
            vertica_conn.commit()
            print("loaded")
            start += chunk_size + 1

    vertica_conn.close()

@dag(schedule_interval=None, start_date=pendulum.parse('2022-07-13'))
def load_stg_group_log_vertica():
    upload_task1 = PythonOperator(
        task_id='upload_group_log_to_vertica',
        python_callable=load_dataset_file_to_vertica,
        op_kwargs={
            'dataset_path': '/data/group_log.csv',
            'schema': 'STV2023111328__STAGING',
            'table': 'group_log',
            'columns': ['group_id', 'user_id', 'user_id_from', 'event', 'datetime'],
        },
    )


    upload_task1 

sprint6_dag_vertica = load_stg_group_log_vertica()

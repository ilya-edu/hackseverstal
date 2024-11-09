import asyncio
import json
import os
from datetime import datetime

from aio_pika import connect_robust
from aio_pika.patterns import RPC

from worker.data_processing import process_data

from yarl import URL

from keras import models


model_0 = models.load_model(
    filepath='worker/models/tf_model_2_best')


def predict_wrapper(*, am_id, data):
    response = process_data(model_0, am_id, data)
    return response


async def main() -> None:
    """
    Выбор функций для прогноза. Получает сообщения от брокера
    и выполняет нужную операцию (RPC).
    """
    # Variables for RabbitMQ
    # TODO: изменить на выбор через окружение
    rabbit_host: str = "severstal_predict-rmq"
    rabbit_port: int = 5672
    rabbit_user: str = "guest"
    rabbit_pass: str = "guest"
    rabbit_vhost: str = "/"

    rabbit_url = URL.build(
        scheme="amqp",
        host=rabbit_host,
        port=rabbit_port,
        user=rabbit_user,
        password=rabbit_pass,
        path=rabbit_vhost,
    )

    connection = await connect_robust(
        rabbit_url,
        client_properties={"connection_name": f"worker_{os.getpid()}"},
    )

    # Создание канала (channel)
    channel = await connection.channel()

    rpc = await RPC.create(channel)
    await rpc.register("predict_wrapper",
                       predict_wrapper,
                       auto_delete=True)
    print('Ready')

    try:
        await asyncio.Future()
    except Exception as e:
        # TODO: внятный обработчик
        print(e)
    finally:
        await connection.close()


if __name__ == "__main__":
    asyncio.run(main())

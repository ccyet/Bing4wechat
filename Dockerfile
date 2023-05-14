FROM python:3.8

WORKDIR /app

COPY requirements.txt .

RUN pip check requirements.txt
RUN pip install --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple -r requirements.txt


COPY . .

CMD ["python", "main.py"]

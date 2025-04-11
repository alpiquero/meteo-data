FROM python:3.13.3-slim-bookworm

ARG USERNAME=noroot \
    GROUPNAME=noroot \
    UID=1001 \
    GID=1001

RUN groupadd -g $GID $GROUPNAME && \
    useradd -g $GID -u $UID $USERNAME

USER $USERNAME

WORKDIR /home/noroot

COPY requeriments.txt main.py .

RUN pip install --no-cache-dir -r requeriments.txt

ENTRYPOINT ["python", "./main.py"]


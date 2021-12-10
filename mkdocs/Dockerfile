FROM python:3.9-slim

RUN pip install mkdocs-material mkdocs-mermaid2-plugin

WORKDIR /docs

ENTRYPOINT ["mkdocs"]

CMD ["serve" "--dev-addr=0.0.0.0:8000"]
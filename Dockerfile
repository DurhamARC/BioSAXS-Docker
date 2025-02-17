# Stage 1: build C++ deps
FROM alpine:latest AS build

RUN apk add --update gcc g++ make cmake

RUN mkdir -p /app/build /app/src

COPY carbonara/src /app/src 
COPY carbonara/CMakeLists.txt /app

WORKDIR /app/build

RUN cmake ..
RUN make


# Stage 2: Install python environment in miniconda image
FROM condaforge/miniforge3:latest

ENV PYTHONUNBUFFERED=1

RUN mkdir /app
WORKDIR /app

# Install requirements
COPY requirements.yml .
RUN conda env update -n biosaxs --file requirements.yml
RUN sed -i 's/conda activate base/conda activate biosaxs/' /root/.bashrc

# Copy built C++ files
COPY --from=build /app/build/bin /app/build/bin

# Copy flask app
COPY carbonara/carbonara-setup /app

EXPOSE 5001
ENTRYPOINT ["/opt/conda/envs/biosaxs/bin/python", "/app/app.py"]


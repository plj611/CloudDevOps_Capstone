FROM python:3.8.10-alpine

## Step 1:
# Create a working directory
WORKDIR /opt

## Step 2:
# Copy source code to working directory
COPY . /opt/

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --upgrade pip && \
    pip install -r /opt/requirements.txt --no-cache-dir


## Step 4:
# Expose port 80
EXPOSE 80

## Step 5:
# Run app.py at container launch
CMD ["python", "app.py"]

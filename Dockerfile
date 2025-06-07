# Use the official Python image
FROM python:3.11

# Set the working directory
WORKDIR /app

# Copy only requirements first (to cache dependencies)
COPY requirements.txt /app/

# Create and activate virtual environment
RUN python -m venv venv && \
    . /app/venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

# Now copy the rest of the application
COPY . /app


# Expose Flask’s new port (3000)
EXPOSE 3000

# Use Gunicorn inside the venv
CMD ["/app/venv/bin/gunicorn", "-b", "0.0.0.0:3000", "--timeout", "500", "--workers", "13", "start:app"]

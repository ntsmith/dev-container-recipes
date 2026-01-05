apt-get update && \
    apt-get install -y --no-install-recommends curl vim

# Set up python environment
python -m venv venv
source venv/bin/activate
pip install -r requirements/requirements.txt

echo 'source ~/venv/bin/activate' >> ~/.bashrc
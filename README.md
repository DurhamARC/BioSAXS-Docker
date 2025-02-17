# BioSAXS Dockerfile

## Instructions for use:

1. Clone this git repository into a local directory: `git clone https://github.com/DurhamARC/BioSAXS-Docker`
2. Change into that directory: `cd BioSAXS-Docker`
3. Update submodules: `git submodule update --init --recursive`
4. Check flask app port is bound to public IP (required for running under Docker– the container is still on a private network by default)
    Check last line of `carbonara/carbonara-setup/app.py` reads `app.run(debug=True, host='0.0.0.0', port=5001)`
5. Build Docker image: `docker build --tag=biosaxs .`
6. Run docker image: `docker run -it --rm -p 5001:5001 --name=biosaxs biosaxs`
7. Access flask web interface on [http://localhost:5001](http://localhost:5001)


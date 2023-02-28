# Build image and run container

This Dockerfile that builds an image containing conda packages (Python versions: 3.7, 3.8, 3.6) for opensim-core.

To build the image execute the following command:

    docker build --progress=plain -t opensim-conda:ubuntu-18.04 .
	
To run the resulting container, execute the following command:

	docker run -i -v opensim_volume:/root/artifacts/ -t opensim-conda:ubuntu-18.04
	
This command creates a volume with access to the folder `/root/artifacts`, containing the built packages.

# Download artifacts

## From Docker Desktop

1. Open `Docker Desktop`.
2. Click on `Volumes` in the left bar.
3. Click on `opensim_volume`.
4. Select the `Data` tab at the top.
5. Right click on each file and `Save as...`.

## From console

1. If you are inside of the container, type `exit`.
2. Insert the following command to download the artifacts:

	docker cp <container-name>:/root/artifacts/opensim-4.4-py37np120.tar.bz2 C:\Users\<user-name>\Downloads
	docker cp <container-name>:/root/artifacts/opensim-4.4-py38np120.tar.bz2 C:\Users\<user-name>\Downloads
	docker cp <container-name>:/root/artifacts/opensim-4.4-py39np120.tar.bz2 C:\Users\<user-name>\Downloads


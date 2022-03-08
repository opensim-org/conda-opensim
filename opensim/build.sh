#!/bin/bash
# TODO: Dependencies should be separate packages...
mkdir opensim_dependencies_build
cd opensim_dependencies_build
cmake ../dependencies/ -LAH \
      -DCMAKE_INSTALL_PREFIX="$PREFIX" \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT} \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 \
      -DSUPERBUILD_casadi=OFF \
      -DSUPERBUILD_adolc=OFF \
      -DSUPERBUILD_colpack=OFF \
      -DSUPERBUILD_docopt=ON \
      -DSUPERBUILD_eigen=OFF \
      -DSUPERBUILD_ipopt=OFF \
      -DSUPERBUILD_simbody=ON \
      -DSUPERBUILD_spdlog=ON \
      -DSUPERBUILD_ezc3d=ON 
make -j8
cd ..

# cp -r $PREFIX/simbody/libexec/simbody/* $PREFIX/bin/

# TODO: Tests are missing!
mkdir opensim_build
cd opensim_build
cmake ../ \
      -DCMAKE_INSTALL_PREFIX="$PREFIX" \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_BUILD_TYPE=Release \
      -DOPENSIM_DEPENDENCIES_DIR="$PREFIX" \
      -DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT} \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 \
      -DSWIG_DIR=/usr/local/Cellar/swig/4.0.2 \
      -DBUILD_PYTHON_WRAPPING=ON \
      -DOPENSIM_DISABLE_LOG_FILE=ON \
      -DOPENSIM_C3D_PARSER=ezc3d \
      -DBUILD_TESTING=OFF \
      -DOPENSIM_PYTHON_STANDALONE=ON \
      -DOPENSIM_INSTALL_UNIX_FHS=ON \
      -DBUILD_API_ONLY=ON \
      -DOPENSIM_BUILD_INDIVIDUAL_APPS_DEFAULT=OFF \
      -DOPENSIM_COPY_DEPENDENCIES=ON \
      -DOPENSIM_WITH_TROPTER=OFF \
      -DOPENSIM_WITH_CASADI=OFF
make -j8
make install

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
      -DSUPERBUILD_docopt=ON \
      -DSUPERBUILD_simbody=ON \
      -DSUPERBUILD_spdlog=ON \
      -DSUPERBUILD_ezc3d=ON \
      -DOPENSIM_WITH_TROPTER=ON \
      -DOPENSIM_WITH_CASADI=ON

make -j8
cd ..

# cp -r $PREFIX/simbody/libexec/simbody/* $PREFIX/bin/

if [ "$(uname)" == "Darwin" ]; then
   SWIG_DIR_SPEC=/usr/local/Cellar/swig/4.1.1
else
   SWIG_DIR_SPEC=/usr/local/bin/swig 
fi
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
      -DSWIG_DIR=${SWIG_DIR_SPEC} \
      -DSWIG_EXECUTABLE=/usr/local/bin/swig \
      -DBUILD_PYTHON_WRAPPING=ON \
      -DOPENSIM_DISABLE_LOG_FILE=ON \
      -DOPENSIM_C3D_PARSER=ezc3d \
      -DOPENSIM_PYTHON_STANDALONE=ON \
      -DOPENSIM_INSTALL_UNIX_FHS=ON \
      -DBUILD_API_ONLY=OFF \
      -DBUILD_API_EXAMPLES=OFF \
      -DBUILD_TESTING=OFF \
      -DOPENSIM_BUILD_INDIVIDUAL_APPS=ON \
      -DOPENSIM_COPY_DEPENDENCIES=ON \
      -DOPENSIM_WITH_TROPTER=ON \
      -DOPENSIM_WITH_CASADI=ON
make -j8
make install

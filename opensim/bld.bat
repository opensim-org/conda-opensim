mkdir opensim_dependencies_build
cd .\opensim_dependencies_build
cmake ..\dependencies -G"Visual Studio 14 2015 Win64" -DCMAKE_INSTALL_PREFIX="%PREFIX%"
cmake --build . --config RelWithDebInfo --target install -- /maxcpucount:8
cd ..

mkdir opensim_build
cd .\opensim_build
cmake ..\ -G"Visual Studio 14 2015 Win64" -DCMAKE_INSTALL_PREFIX="%PREFIX%" -DOPENSIM_DEPENDENCIES_DIR="%PREFIX%" -DBUILD_PYTHON_WRAPPING=ON -DWITH_BTK=ON
cmake --build . --config RelWithDebInfo --target install -- /maxcpucount:8

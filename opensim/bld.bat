mkdir opensim_dependencies_build
cd .\opensim_dependencies_build
cmake ..\dependencies^
	-G"Visual Studio 16 2019"^
	-DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"^
	-DSUPERBUILD_ezc3d=ON

cmake --build . --config Release -- /maxcpucount:8
cd .. 
mkdir opensim_build
cd .\opensim_build
cmake ..\^
	-G"Visual Studio 16 2019"^
	-DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"^
	-DOPENSIM_DEPENDENCIES_DIR="%LIBRARY_PREFIX%"^
	-DCMAKE_INSTALL_INCLUDEDIR="%LIBRARY_PREFIX%/include"^
	-DCMAKE_INSTALL_LIBDIR="%LIBRARY_PREFIX%/lib"^
	-DCMAKE_INSTALL_DOCDIR="%LIBRARY_PREFIX%/doc"^
	-DCMAKE_INSTALL_SYSCONFDIR="%LIBRARY_PREFIX%/Library"^
	-DOPENSIM_INSTALL_PYTHONDIR="%LIBRARY_PREFIX%/Lib/site-packages"^
	-DOPENSIM_INSTALL_SIMBODYDIR="%LIBRARY_PREFIX%/Library/Simbody"^
	-DOPENSIM_INSTALL_SPDLOGDIR="%LIBRARY_PREFIX%/Library/spdlog"^
	-DOPENSIM_INSTALL_CASADIDIR="%LIBRARY_PREFIX%/Library"^
	-DBUILD_PYTHON_WRAPPING=ON^
	-DOPENSIM_C3D_PARSER=ezc3d^
	-DOPENSIM_PYTHON_STANDALONE=ON^
	-DBUILD_TESTING=OFF^
	-DBUILD_API_EXAMPLES=OFF^
	-DOPENSIM_BUILD_INDIVIDUAL_APPS=OFF^
	-DOPENSIM_PYTHON_CONDA=ON
cmake --build . --target install --config Release -- /maxcpucount:8

Rem move Library\sdk\Python Lib
move %LIBRARY_PREFIX%\sdk\Python  %LIBRARY_PREFIX%\..\Lib
cd %LIBRARY_PREFIX%\..\Lib
python setup_win_python38.py conda
python setup.py install


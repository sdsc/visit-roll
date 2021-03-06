ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME	          = visit_$(COMPILERNAME)_$(MPINAME)
VERSION	          = 2.5.2
RELEASE	          = 7
PKGROOT           = /opt/visit

SRC_SUBDIR        = visit

SOURCE_NAME       = visit
SOURCE_SUFFIX     = tar.gz
SOURCE_VERSION    = $(VERSION)
SOURCE_PKG        = $(SOURCE_NAME)$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR        = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

CCSE_NAME         = ccse
CCSE_SUFFIX       = tar.gz
CCSE_VERSION      = 0.1.8
CCSE_PKG          = $(CCSE_NAME)-$(CCSE_VERSION).$(CCSE_SUFFIX)
CCSE_DIR          = $(CCSE_PKG:%.$(CCSE_SUFFIX)=%)

CMAKE_NAME        = cmake
CMAKE_SUFFIX      = tar.gz
CMAKE_VERSION     = 2.8.8
CMAKE_PKG         = $(CMAKE_NAME)-$(CMAKE_VERSION).$(CMAKE_SUFFIX)
CMAKE_DIR         = $(CMAKE_PKG:%.$(CMAKE_SUFFIX)=%)

GDAL_NAME         = gdal
GDAL_SUFFIX       = tar.gz
GDAL_VERSION      = 1.7.1
GDAL_PKG          = $(GDAL_NAME)-$(GDAL_VERSION).$(GDAL_SUFFIX)
GDAL_DIR          = $(GDAL_PKG:%.$(GDAL_SUFFIX)=%)

H5PART_NAME       = H5Part
H5PART_SUFFIX     = tar.gz
H5PART_VERSION    = 1.6.6
H5PART_PKG        = $(H5PART_NAME)-$(H5PART_VERSION).$(H5PART_SUFFIX)
H5PART_DIR        = $(H5PART_PKG:%.$(H5PART_SUFFIX)=%)

HDF5_NAME         = hdf5
HDF5_SUFFIX       = tar.gz
HDF5_VERSION      = 1.8.7
HDF5_PKG          = $(HDF5_NAME)-$(HDF5_VERSION).$(HDF5_SUFFIX)
HDF5_DIR          = $(HDF5_PKG:%.$(HDF5_SUFFIX)=%)

ICET_NAME         = IceT
ICET_SUFFIX       = tar.gz
ICET_VERSION      = 1-0-0
ICET_PKG          = $(ICET_NAME)-$(ICET_VERSION).$(ICET_SUFFIX)
ICET_DIR          = $(ICET_PKG:%.$(ICET_SUFFIX)=%)

IMAGING_NAME      = Imaging
IMAGING_SUFFIX    = tar.gz
IMAGING_VERSION   = 1.1.6
IMAGING_PKG       = $(IMAGING_NAME)-$(IMAGING_VERSION).$(IMAGING_SUFFIX)
IMAGING_DIR       = $(IMAGING_PKG:%.$(IMAGING_SUFFIX)=%)

MESALIB_NAME      = MesaLib
MESALIB_SUFFIX    = tar.gz
MESALIB_VERSION   = 7.8.2
MESALIB_PKG       = $(MESALIB_NAME)-$(MESALIB_VERSION).$(MESALIB_SUFFIX)
MESALIB_DIR       = $(MESALIB_PKG:%.$(MESALIB_SUFFIX)=%)

NETCDF_NAME       = netcdf
NETCDF_SUFFIX     = tar.gz
NETCDF_VERSION    = 4.1.1
NETCDF_PKG        = $(NETCDF_NAME)-$(NETCDF_VERSION).$(NETCDF_SUFFIX)
NETCDF_DIR        = $(NETCDF_PKG:%.$(NETCDF_SUFFIX)=%)

PYPARSING_NAME    = pyparsing
PYPARSING_SUFFIX  = tar.gz
PYPARSING_VERSION = 1.5.2
PYPARSING_PKG     = $(PYPARSING_NAME)-$(PYPARSING_VERSION).$(PYPARSING_SUFFIX)
PYPARSING_DIR     = $(PYPARSING_PKG:%.$(PYPARSING_SUFFIX)=%)

PYSIDE_NAME       = pyside-combined
PYSIDE_SUFFIX     = tar.gz
PYSIDE_VERSION    = 1.0.7
PYSIDE_PKG        = $(PYSIDE_NAME)-$(PYSIDE_VERSION).$(PYSIDE_SUFFIX)
PYSIDE_DIR        = $(PYSIDE_PKG:%.$(PYSIDE_SUFFIX)=%)

PYTHON_NAME       = Python
PYTHON_SUFFIX     = tgz
PYTHON_VERSION    = 2.6.4
PYTHON_PKG        = $(PYTHON_NAME)-$(PYTHON_VERSION).$(PYTHON_SUFFIX)
PYTHON_DIR        = $(PYTHON_PKG:%.$(PYTHON_SUFFIX)=%)

QT_NAME           = qt-everywhere-opensource-src
QT_SUFFIX         = tar.gz
QT_VERSION        = 4.7.4
QT_PKG            = $(QT_NAME)-$(QT_VERSION).$(QT_SUFFIX)
QT_DIR            = $(QT_PKG:%.$(QT_SUFFIX)=%)

SILO_NAME         = silo
SILO_SUFFIX       = tar.gz
SILO_VERSION      = 4.8
SILO_PKG          = $(SILO_NAME)-$(SILO_VERSION).$(SILO_SUFFIX)
SILO_DIR          = $(SILO_PKG:%.$(SILO_SUFFIX)=%)

SZIP_NAME         = szip
SZIP_SUFFIX       = tar.gz
SZIP_VERSION      = 2.1
SZIP_PKG          = $(SZIP_NAME)-$(SZIP_VERSION).$(SZIP_SUFFIX)
SZIP_DIR          = $(SZIP_PKG:%.$(SZIP_SUFFIX)=%)

VTK_NAME          = visit-vtk
VTK_SUFFIX        = tar.gz
VTK_VERSION       = 5.8
VTK_PKG           = $(VTK_NAME)-$(VTK_VERSION).$(VTK_SUFFIX)
VTK_DIR           = $(VTK_PKG:%.$(VTK_SUFFIX)=%)

XDMF_NAME         = Xdmf
XDMF_SUFFIX       = tar.gz
XDMF_VERSION      = 2.1.1
XDMF_PKG          = $(XDMF_NAME)-$(XDMF_VERSION).$(XDMF_SUFFIX)
XDMF_DIR          = $(XDMF_PKG:%.$(XDMF_SUFFIX)=%)

TAR_GZ_PKGS  = \
  $(SOURCE_PKG) $(CCSE_PKG) $(CMAKE_PKG) $(GDAL_PKG) $(H5PART_PKG) $(HDF5_PKG) \
  $(ICET_PKG) $(IMAGING_PKG) $(MESALIB_PKG) $(NETCDF_PKG) $(PYPARSING_PKG) \
  $(PYSIDE_PKG) $(QT_PKG) $(SILO_PKG) $(SZIP_PKG) $(VTK_PKG) $(XDMF_PKG)
TGZ_PKGS     = $(PYTHON_PKG)

RPM.EXTRAS     = AutoReq:No

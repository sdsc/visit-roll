#
# $Id$
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		       version 6.1.1 (Sand Boa)
# 
# Copyright (c) 2000 - 2014 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log$
#

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include pull.mk

ROLLCOMMENT=#
ifeq ( "$(ROLLCOMPILER)","intel")
    ROLLCOMMENT=
endif
ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif


ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif
ifndef ROLLMPI
  ROLLMPI = openmpi
endif

PKGROOT = /opt/visit
SOURCE = visit-$(VERSION)
REDHAT.ROOT = $(PWD)/../../

-include $(ROCKSROOT)/etc/Rules.mk

export C_COMPILER=gcc
export CXX_COMPILER=g++
COMPILERSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module load $(ROLLCOMPILER); \
  fi; \
  if test "$(ROLLCOMPILER)" = "intel"; then \
      export C_COMPILER=icc; \
      export CXX_COMPILER=icpc; \
  fi; \
  if test "$(ROLLCOMPILER)" = "pgi"; then \
      export C_COMPILER=pgcc; \
      export CXX_COMPILER=pgCC; \
   fi

ifeq ("$(ROLLNETWORK)", "eth")
  MPI = $(ROLLMPI)
else
  MPI = $(ROLLMPI)_$(ROLLNETWORK)
endif

MPISETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module load $(MPI); \
  fi; \
  export MPI_HOME=`which mpicxx | perl -pe 's!/bin/.*!!'`; \
  if test -z "$${MPI_HOME}"; then \
    export MPI_HOME=/opt/$(ROLLMPI); \
  fi; \
  echo Using MPI from $${MPI_HOME}; \
  export PATH=$${PATH}:$${MPI_HOME}/bin; \
  export LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:$${MPI_HOME}/lib; \
  export PAR_INCLUDE=-I$${MPI_HOME}/include; \
  export PAR_LIBS=$${MPI_HOME}/lib; \
  export PAR_COMPILER=$${MPI_HOME}/bin/mpicxx

build:$(SRC_DIRS)
	yum install makedepend
	
install::
	mkdir -p $(ROOT)/$(PKGROOT)/thirdparty
	mkdir -p $(ROOT)/$(PKGROOT)/data
	mkdir -p $(PKGROOT)
	mount --bind $(ROOT)/$(PKGROOT) $(PKGROOT)
	mkdir v$(VERSION)
	cp build_visit2_7_3 v$(VERSION)
	patch v$(VERSION)/build_visit2_7_3 patch-files/build_visit2_7_3.patch
	( \
          $(COMPILERSETUP); \
          $(MPISETUP); \
          make scipy; \
          cd v$(VERSION); \
          bash build_visit2_7_3 --mesa --pyside --boxlib --gdal --h5part --hdf5 --netcdf --silo --vtk --xdmf --console --parallel --thirdparty-path $(PKGROOT)/thirdparty --prefix $(PKGROOT) --makeflags '-j 16'; \
	)
	umount $(PKGROOT)
	rm -rf $(ROOT)/$(PKGROOT)/data/*
	cp *.silo $(ROOT)/$(PKGROOT)/data
	cp customlauncher $(ROOT)/$(PKGROOT)/$(VERSION)/bin
	mkdir -p $(REDHAT.ROOT)/src/build-visit-modules
	cat visit.module | perl -pi -e "s!INSTALLROOT!$(PKGROOT)!g;s!MODULEROOT!/opt/modulefiles/applications/visit!g;s!VERSION!$(VERSION)!g;s!ROLLCOMPILER!$(ROLLCOMPILER)!g;s!ROLLMPI!$(ROLLMPI)!g;s!ROLLNETWORK!$(ROLLNETWORK)!g" \
          > $(REDHAT.ROOT)/src/build-visit-modules/$(NAME).module
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf v$(VERSION)

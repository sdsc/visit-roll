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

REDHAT.ROOT = $(PWD)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include pull.mk

CC = gcc
CXX = g++
ifeq ("$(COMPILERNAME)", "intel")
  CC = icc
  CXX = icpc
else ifeq ("$(COMPILERNAME)", "pgi")
  CC = pgcc
  CXX = pgCC
endif

COMPILERSETUP =  \
  module load $(ROLLCOMPILER) || true; \
  echo === Compiler and version ===; \
  $(CC) --version

MPISETUP = \
  module load $(ROLLMPI) || true; \
  echo === MPIHOME ===; \
  echo $${MPIHOME}

build: $(SRC_DIRS)
	patch visit$(VERSION)/src/svn_bin/visit-install $(REDHAT.ROOT)/src/visit/patch-files/visit-install.patch
	patch visit$(VERSION)/src/bin/internallauncher $(REDHAT.ROOT)/src/visit/patch-files/internallauncher.$(VERSION).patch
	mkdir v$(VERSION)
	cp build_visit2_5_2 *z v$(VERSION)
	patch v$(VERSION)/build_visit2_5_2 patch-files/build_visit2_5_2.patch
	@echo "::: Package $(NAME) build complete :::"

install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)/thirdparty
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)/data
	-mkdir -p -m 755 $(PKGROOT)
	mount --bind $(ROOT)/$(PKGROOT) $(PKGROOT)
	( \
	  $(COMPILERSETUP); \
	  $(MPISETUP); \
	  export PAR_INCLUDE=-I$${MPI_HOME}/include; \
	  export PAR_LIBS=$${MPI_HOME}/lib; \
	  export PAR_COMPILER=$${MPI_HOME}/bin/mpicxx; \
	  export C_COMPILER=$(CC); \
	  export CXX_COMPILER=$(CXX); \
	  export CFLAGS=-fPIC; \
	  export CXXFLAGS=-fPIC; \
	  export C_OPT_FLAGS=" -O3 -fPIC"; \
	  export CXX_OPT_FLAGS=" -O3 -fPIC"; \
	  export MAKE_OPT_FLAGS="-j 16"; \
	  cd v$(VERSION); \
	  bash build_visit2_5_2 --pyside --boxlib --h5part --hdf5 --netcdf --silo --vtk --xdmf --console --parallel --thirdparty-path $(PKGROOT)/thirdparty; \
	  cd visit$(VERSION)/src; \
	  make package; \
	  ./svn_bin/visit-install $(VERSION) linux-x86_64 $(PKGROOT); \
	  cd $(PKGROOT); \
	  ln -s $(VERSION) current; \
	)
	umount $(PKGROOT)
	-rmdir -p $(PKGROOT)
	rm -rf $(ROOT)/$(PKGROOT)/data/*
	cp *.silo $(ROOT)/$(PKGROOT)/data
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf v$(VERSION)

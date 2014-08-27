SRCDIRS = `find * -prune\
	  -type d 	\
          -not -name thirdparty \
          -not -name visit-modules \
          -not -name build-\* \
	  ! -name .` visit-modules

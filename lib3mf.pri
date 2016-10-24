# Detect lib3mf, then use this priority list to determine
# which library to use:
#
# Priority
# 1. LIB3MF_INCLUDEPATH / LIB3MF_LIBPATH (qmake parameter, not checked if given on commandline)
# 2. OPENSCAD_LIBRARIES (environment variable)
# 3. system's standard include paths

lib3mf {

OPENSCAD_LIBRARIES_DIR = $$(OPENSCAD_LIBRARIES)

!isEmpty(LIB3MF_INCLUDEPATH) {
  LIB3MF_CFLAGS = -I$$LIB3MF_INCLUDEPATH -I$$LIB3MF_INCLUDEPATH/Model/COM
} else {
  !isEmpty(OPENSCAD_LIBRARIES_DIR) {
    exists($$OPENSCAD_LIBRARIES_DIR/include/lib3mf/Model/COM/NMR_DLLInterfaces.h) {
      LIB3MF_CFLAGS = -I$$OPENSCAD_LIBRARIES_DIR/include/lib3mf -I$$OPENSCAD_LIBRARIES_DIR/include/lib3mf/Model/COM
      LIB3MF_LIBS = -L$$OPENSCAD_LIBRARIES_DIR/lib
    }
  }
  isEmpty(LIB3MF_CFLAGS) {
    exists(/opt/include/lib3mf/Model/COM/NMR_DLLInterfaces.h) {
      LIB3MF_CFLAGS = -I/opt/include/lib3mf -I/opt/include/lib3mf/Model/COM
      LIB3MF_LIBS = -L/opt/lib
    }
    exists(/usr/local/include/lib3mf/Model/COM/NMR_DLLInterfaces.h) {
      LIB3MF_CFLAGS = -I/usr/local/include/lib3mf -I/usr/local/include/lib3mf/Model/COM
      LIB3MF_LIBS = -L/usr/local/lib
    }
    exists(/usr/include/lib3mf/Model/COM/NMR_DLLInterfaces.h) {
      LIB3MF_CFLAGS = -I/usr/include/lib3mf -I/usr/include/lib3mf/Model/COM
      LIB3MF_LIBS = -L/usr/lib
    }
  }
}

!isEmpty(LIB3MF_LIBPATH) {
  LIB3MF_LIBS = -L$$LIB3MF_LIBPATH
}

LIB3MF_LIBS += -l3MF

!isEmpty(LIB3MF_CFLAGS):!isEmpty(LIB3MF_LIBS) {
  DEFINES += __GCC ENABLE_LIB3MF
  QMAKE_CXXFLAGS += $$LIB3MF_CFLAGS
  LIBS += $$LIB3MF_LIBS
}

}
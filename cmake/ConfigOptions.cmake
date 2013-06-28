
if((CMAKE_SYSTEM_PROCESSOR MATCHES "i386|i686|x86") AND (CMAKE_SIZEOF_VOID_P EQUAL 4))
	set(TARGET_ARCH "x86")
elseif((CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|AMD64") AND (CMAKE_SIZEOF_VOID_P EQUAL 8))
	set(TARGET_ARCH "x64")
elseif((CMAKE_SYSTEM_PROCESSOR MATCHES "i386") AND (CMAKE_SIZEOF_VOID_P EQUAL 8) AND (APPLE))
	# Mac is weird like that.
	set(TARGET_ARCH "x64")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "arm*")
	set(TARGET_ARCH "ARM")
endif()

option(WITH_MANPAGES "Generate manpages." ON)
option(WITH_PROFILER "Compile profiler." OFF)

if((TARGET_ARCH MATCHES "x86|x64") AND (NOT DEFINED WITH_SSE2))
	option(WITH_SSE2 "Enable SSE2 optimization." ON)
else()
	option(WITH_SSE2 "Enable SSE2 optimization." OFF)
endif()

if(TARGET_ARCH MATCHES "ARM")
	if (NOT DEFINED WITH_NEON)
		option(WITH_NEON "Enable NEON optimization." ON)
	else()
		option(WITH_NEON "Enable NEON optimization." OFF)
	endif()
	if (NOT DEFINED ARM_FP_ABI)
		set(ARM_FP_ABI "softfp" CACHE STRING "Floating point ABI to use on arm")
	else()
		set(ARM_FP_ABI ${ARM_FP_API} CACHE STRING "Floating point ABI to use on arm")
	endif()
	mark_as_advanced(ARM_FP_ABI)
else()
	if(NOT APPLE)
		option(WITH_IPP "Use Intel Performance Primitives." OFF)
	endif()
endif()

option(WITH_JPEG "Use JPEG decoding." OFF)

if(CMAKE_C_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
	set(CMAKE_COMPILER_IS_CLANG 1)
endif()

if(MSVC)
	option(WITH_NATIVE_SSPI "Use native SSPI modules" ON)
	option(WITH_WINMM "Use Windows Multimedia" ON)
	option(WITH_WIN8 "Use Windows 8 libraries" OFF)
endif()

option(BUILD_TESTING "Build unit tests" OFF)
option(WITH_SAMPLE "Build sample code" OFF)

if(${CMAKE_VERSION} VERSION_GREATER 2.8.8)
	if(ANDROID)
		option(MONOLITHIC_BUILD "Use monolithic build" ON)
	else()
		option(MONOLITHIC_BUILD "Use monolithic build" OFF)
	endif()
endif()

option(WITH_CLIENT "Build client binaries" ON)
option(WITH_SERVER "Build server binaries" OFF)

option(STATIC_CHANNELS "Build channels statically" ON)

option(WITH_CHANNELS "Build virtual channel plugins" ON)

if(WITH_CLIENT AND WITH_CHANNELS)
	option(WITH_CLIENT_CHANNELS "Build virtual channel plugins" ON)
endif()

if(WITH_SERVER AND WITH_CHANNELS)
	option(WITH_SERVER_CHANNELS "Build virtual channel plugins" ON)
endif()

option(WITH_THIRD_PARTY "Build third-party components" OFF)

option(WITH_CLIENT_INTERFACE "Build clients as a library with an interface" ON)
option(WITH_SERVER_INTERFACE "Build servers as a library with an interface" ON)

option(WITH_DEBUG_ALL "Print all debug messages." OFF)

if(WITH_DEBUG_ALL)
	set(DEFAULT_DEBUG_OPTION "ON")
else()
	set(DEFAULT_DEBUG_OPTION "OFF")
endif()

option(WITH_DEBUG_CERTIFICATE "Print certificate related debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_CAPABILITIES "Print capability negotiation debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_CHANNELS "Print channel manager debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_CLIPRDR "Print clipboard redirection debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_DVC "Print dynamic virtual channel debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_GDI "Print graphics debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_KBD "Print keyboard related debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_LICENSE "Print license debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_NEGO "Print negotiation related debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_NLA "Print authentication related debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_NTLM "Print NTLM debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_TSG "Print Terminal Server Gateway debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_ORDERS "Print drawing orders debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_RAIL "Print RemoteApp debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_RDP "Print RDP debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_REDIR "Redirection debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_RFX "Print RemoteFX debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_SCARD "Print smartcard debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_SVC "Print static virtual channel debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_TRANSPORT "Print transport debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_TIMEZONE "Print timezone debug messages." ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_WND "Print window order debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_X11_CLIPRDR "Print X11 clipboard redirection debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_X11_LOCAL_MOVESIZE "Print X11 Client local movesize debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_X11 "Print X11 Client debug messages" ${DEFAULT_DEBUG_OPTION})
option(WITH_DEBUG_XV "Print XVideo debug messages" ${DEFAULT_DEBUG_OPTION})

if(ANDROID)
include(ConfigOptionsAndroid)
endif(ANDROID)

if(IOS)
include(ConfigOptionsiOS)
endif(IOS)
